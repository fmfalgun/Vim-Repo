#!/usr/bin/env bash

################################################################################
# DEBIAN/UBUNTU/KALI INSTALLATION SCRIPT
################################################################################
#
# Installs Neovim and all dependencies on Debian-based systems
#
################################################################################

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Robust download function with retry logic
# Usage: download_with_retry <url> <output_file> [max_retries]
download_with_retry() {
    local url="$1"
    local output="$2"
    local max_retries="${3:-5}"
    local retry_count=0
    local wait_time=2

    while [ $retry_count -lt $max_retries ]; do
        print_info "Downloading: $url (attempt $((retry_count + 1))/$max_retries)"

        # Try with curl first (with timeouts)
        if curl -fSL --connect-timeout 30 --max-time 300 --retry 3 --retry-delay 2 \
                -o "$output" "$url" 2>/dev/null; then
            print_success "Download successful"
            return 0
        fi

        # If curl fails, try wget
        if wget --timeout=30 --tries=3 --waitretry=2 \
                -O "$output" "$url" 2>/dev/null; then
            print_success "Download successful (using wget)"
            return 0
        fi

        retry_count=$((retry_count + 1))
        if [ $retry_count -lt $max_retries ]; then
            print_warning "Download failed, retrying in ${wait_time}s..."
            sleep $wait_time
            wait_time=$((wait_time * 2))  # Exponential backoff
        fi
    done

    print_error "Failed to download after $max_retries attempts: $url"
    return 1
}

# Execute command with retry logic
# Usage: execute_with_retry <command> [max_retries]
execute_with_retry() {
    local command="$1"
    local max_retries="${2:-3}"
    local retry_count=0
    local wait_time=2

    while [ $retry_count -lt $max_retries ]; do
        if [ $retry_count -gt 0 ]; then
            print_warning "Retrying command (attempt $((retry_count + 1))/$max_retries)..."
        fi

        if eval "$command"; then
            return 0
        fi

        retry_count=$((retry_count + 1))
        if [ $retry_count -lt $max_retries ]; then
            print_warning "Command failed, retrying in ${wait_time}s..."
            sleep $wait_time
            wait_time=$((wait_time * 2))
        fi
    done

    print_error "Command failed after $max_retries attempts"
    return 1
}

print_info "Installing dependencies for Debian/Ubuntu/Kali..."

# Update package list
print_info "Updating package list..."
sudo apt-get update

# Install build essentials
print_info "Installing build tools..."
sudo apt-get install -y \
    build-essential \
    cmake \
    pkg-config \
    gettext \
    libtool \
    libtool-bin \
    autoconf \
    automake \
    unzip \
    curl \
    wget \
    git

# Install Neovim
print_info "Installing Neovim..."
if ! command -v nvim &> /dev/null; then
    # Try to install from official repositories
    if sudo apt-get install -y neovim; then
        print_success "Neovim installed from repository"
    else
        # If that fails, install from AppImage
        print_info "Installing Neovim from AppImage..."
        cd /tmp
        wget https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
        chmod +x nvim.appimage
        sudo mv nvim.appimage /usr/local/bin/nvim
        print_success "Neovim installed from AppImage"
    fi
else
    print_success "Neovim already installed"
fi

# Install programming language dependencies
print_info "Installing language dependencies..."

# Python
print_info "Installing Python tools..."
sudo apt-get install -y \
    python3 \
    python3-pip \
    python3-venv

# C/C++
print_info "Installing C/C++ tools..."
sudo apt-get install -y \
    gcc \
    g++ \
    clang \
    clangd \
    gdb \
    lldb

# Java
print_info "Installing Java tools..."
sudo apt-get install -y \
    default-jdk \
    default-jre

# Go
print_info "Installing Go..."
if ! command -v go &> /dev/null; then
    sudo apt-get install -y golang-go || {
        # Install from official source if not in repos
        print_info "Installing Go from official source..."
        GO_VERSION="1.21.5"
        GO_URL="https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz"

        download_with_retry "$GO_URL" "/tmp/go.tar.gz" 5

        print_info "Installing Go to /usr/local..."
        sudo rm -rf /usr/local/go
        sudo tar -C /usr/local -xzf /tmp/go.tar.gz
        rm -f /tmp/go.tar.gz

        # Add to PATH
        if ! grep -q "/usr/local/go/bin" ~/.bashrc; then
            echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc
        fi
        export PATH=$PATH:/usr/local/go/bin

        print_success "Go installed successfully"
        go version
    }
else
    print_success "Go already installed"
    go version
fi

# .NET Core (C#)
print_info "Installing .NET SDK..."
if ! command -v dotnet &> /dev/null; then
    UBUNTU_VERSION=$(lsb_release -rs)
    DOTNET_URL="https://packages.microsoft.com/config/ubuntu/${UBUNTU_VERSION}/packages-microsoft-prod.deb"

    print_info "Downloading .NET repository package..."
    download_with_retry "$DOTNET_URL" "/tmp/packages-microsoft-prod.deb" 5

    sudo dpkg -i /tmp/packages-microsoft-prod.deb
    rm -f /tmp/packages-microsoft-prod.deb

    execute_with_retry "sudo apt-get update" 3

    # Try .NET 8.0, fallback to 7.0
    print_info "Installing .NET SDK..."
    sudo apt-get install -y dotnet-sdk-8.0 || sudo apt-get install -y dotnet-sdk-7.0

    print_success ".NET SDK installed successfully"
    dotnet --version
else
    print_success ".NET already installed"
    dotnet --version
fi

# Docker and Kubernetes tools
print_info "Installing Docker and K8s tools..."
if ! command -v docker &> /dev/null; then
    # Check if running on Kali Linux
    if grep -qi "kali" /etc/os-release 2>/dev/null; then
        print_info "Detected Kali Linux - Installing Docker using Debian repository..."

        # Install prerequisites
        sudo apt-get install -y ca-certificates curl gnupg
        sudo install -m 0755 -d /etc/apt/keyrings

        # Download Docker GPG key with retry
        print_info "Downloading Docker GPG key..."
        download_with_retry "https://download.docker.com/linux/debian/gpg" "/tmp/docker.gpg" 5
        sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg < /tmp/docker.gpg
        sudo chmod a+r /etc/apt/keyrings/docker.gpg
        rm -f /tmp/docker.gpg

        # Add Docker repository
        echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian bookworm stable" | \
            sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

        # Update package list with retry
        print_info "Updating package list..."
        execute_with_retry "sudo apt-get update" 3

        # Install Docker packages
        print_info "Installing Docker packages..."
        sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

        # Add user to docker group
        sudo usermod -aG docker $USER

        # Start Docker service
        sudo systemctl enable docker
        sudo systemctl start docker

        print_success "Docker installed successfully (logout/login required for permissions)"
        docker --version
    else
        # Use official Docker install script for other distros
        print_info "Installing Docker using official script..."
        download_with_retry "https://get.docker.com" "/tmp/docker-install.sh" 5
        sudo sh /tmp/docker-install.sh
        rm -f /tmp/docker-install.sh

        sudo usermod -aG docker $USER
        sudo systemctl enable docker
        sudo systemctl start docker

        print_success "Docker installed successfully (logout/login required for permissions)"
        docker --version
    fi
else
    print_success "Docker already installed"
    docker --version
fi

# kubectl
print_info "Installing kubectl..."
if ! command -v kubectl &> /dev/null; then
    print_info "Fetching latest kubectl version..."

    # Get latest stable version with retry
    retry_count=0
    max_retries=5
    while [ $retry_count -lt $max_retries ]; do
        KUBECTL_VERSION=$(curl -L -s --connect-timeout 10 --max-time 30 \
            https://dl.k8s.io/release/stable.txt 2>/dev/null)

        if [ -n "$KUBECTL_VERSION" ]; then
            print_success "Latest version: $KUBECTL_VERSION"
            break
        fi

        retry_count=$((retry_count + 1))
        if [ $retry_count -lt $max_retries ]; then
            print_warning "Failed to fetch version, retrying ($((retry_count + 1))/$max_retries)..."
            sleep 2
        else
            print_error "Failed to fetch kubectl version after $max_retries attempts"
            exit 1
        fi
    done

    # Download kubectl with retry
    KUBECTL_URL="https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl"
    download_with_retry "$KUBECTL_URL" "/tmp/kubectl" 5

    # Install kubectl
    sudo install -o root -g root -m 0755 /tmp/kubectl /usr/local/bin/kubectl
    rm -f /tmp/kubectl

    print_success "kubectl installed successfully"
    kubectl version --client
else
    print_success "kubectl already installed"
    kubectl version --client
fi

# Additional tools
print_info "Installing additional development tools..."
sudo apt-get install -y \
    ripgrep \
    fd-find \
    tree \
    htop \
    shellcheck \
    yamllint

# Rust (optional but recommended)
print_info "Installing Rust..."
if ! command -v rustc &> /dev/null; then
    print_info "Downloading Rust installer..."

    # Download rustup installer with retry
    download_with_retry "https://sh.rustup.rs" "/tmp/rustup-init.sh" 5

    # Make it executable
    chmod +x /tmp/rustup-init.sh

    # Install Rust with retries
    print_info "Installing Rust toolchain (this may take a few minutes)..."
    retry_count=0
    max_retries=3

    while [ $retry_count -lt $max_retries ]; do
        if /tmp/rustup-init.sh -y --default-toolchain stable --profile default; then
            source "$HOME/.cargo/env"
            print_success "Rust installed successfully"
            rustc --version
            break
        else
            retry_count=$((retry_count + 1))
            if [ $retry_count -lt $max_retries ]; then
                print_warning "Rust installation failed, retrying ($((retry_count + 1))/$max_retries)..."
                sleep 5
            else
                print_error "Failed to install Rust after $max_retries attempts"
                exit 1
            fi
        fi
    done

    # Clean up
    rm -f /tmp/rustup-init.sh
else
    print_success "Rust already installed"
    rustc --version
fi

# Install LazyGit (modern git UI)
print_info "Installing LazyGit..."
if ! command -v lazygit &> /dev/null; then
    print_info "Fetching latest LazyGit version..."

    # Get latest version with retry
    retry_count=0
    max_retries=5
    while [ $retry_count -lt $max_retries ]; do
        LAZYGIT_VERSION=$(curl -s --connect-timeout 10 --max-time 30 \
            "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" \
            | grep -Po '"tag_name": "v\K[^"]*' 2>/dev/null)

        if [ -n "$LAZYGIT_VERSION" ]; then
            print_success "Latest version: v$LAZYGIT_VERSION"
            break
        fi

        retry_count=$((retry_count + 1))
        if [ $retry_count -lt $max_retries ]; then
            print_warning "Failed to fetch version, retrying ($((retry_count + 1))/$max_retries)..."
            sleep 2
        else
            print_error "Failed to fetch LazyGit version after $max_retries attempts"
            exit 1
        fi
    done

    # Download LazyGit with retry
    LAZYGIT_URL="https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
    download_with_retry "$LAZYGIT_URL" "/tmp/lazygit.tar.gz" 5

    # Extract and install
    print_info "Extracting LazyGit..."
    cd /tmp
    tar xf lazygit.tar.gz
    sudo install -o root -g root -m 0755 lazygit /usr/local/bin/lazygit

    # Clean up
    rm -f /tmp/lazygit /tmp/lazygit.tar.gz

    print_success "LazyGit installed successfully"
    lazygit --version
else
    print_success "LazyGit already installed"
    lazygit --version
fi

print_success "Debian/Ubuntu/Kali dependencies installed successfully!"
