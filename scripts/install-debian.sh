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
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
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
        GO_VERSION="1.21.5"
        wget "https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz" -O /tmp/go.tar.gz
        sudo rm -rf /usr/local/go
        sudo tar -C /usr/local -xzf /tmp/go.tar.gz
        echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc
        export PATH=$PATH:/usr/local/go/bin
    }
else
    print_success "Go already installed"
fi

# .NET Core (C#)
print_info "Installing .NET SDK..."
if ! command -v dotnet &> /dev/null; then
    wget https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/packages-microsoft-prod.deb -O /tmp/packages-microsoft-prod.deb
    sudo dpkg -i /tmp/packages-microsoft-prod.deb
    sudo apt-get update
    sudo apt-get install -y dotnet-sdk-8.0 || sudo apt-get install -y dotnet-sdk-7.0
else
    print_success ".NET already installed"
fi

# Docker and Kubernetes tools
print_info "Installing Docker and K8s tools..."
if ! command -v docker &> /dev/null; then
    # Check if running on Kali Linux
    if grep -qi "kali" /etc/os-release 2>/dev/null; then
        print_info "Detected Kali Linux - Installing Docker using Debian repository..."
        # Use Debian Bookworm repository for Kali
        sudo apt-get install -y ca-certificates curl gnupg
        sudo install -m 0755 -d /etc/apt/keyrings
        curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
        sudo chmod a+r /etc/apt/keyrings/docker.gpg
        echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian bookworm stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
        sudo apt-get update
        sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin || {
            echo "[WARNING] Docker installation failed - skipping (optional for Neovim)"
        }
        sudo usermod -aG docker $USER 2>/dev/null || true
        print_success "Docker installed (logout/login required for permissions)"
    else
        # Use official Docker install script for other distros
        curl -fsSL https://get.docker.com | sudo sh
        sudo usermod -aG docker $USER
        print_success "Docker installed (logout/login required for permissions)"
    fi
else
    print_success "Docker already installed"
fi

# kubectl
if ! command -v kubectl &> /dev/null; then
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
    rm kubectl
    print_success "kubectl installed"
else
    print_success "kubectl already installed"
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
    if curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y; then
        source "$HOME/.cargo/env" 2>/dev/null || true
        print_success "Rust installed"
    else
        echo -e "${YELLOW}[WARNING]${NC} Rust installation failed (network timeout or error)"
        echo -e "${BLUE}[INFO]${NC} Rust is optional - continuing installation..."
        echo -e "${BLUE}[INFO]${NC} You can install Rust later with: curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh"
    fi
else
    print_success "Rust already installed"
fi

# Install LazyGit (modern git UI)
print_info "Installing LazyGit..."
if ! command -v lazygit &> /dev/null; then
    if LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*') && \
       curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz" && \
       tar xf lazygit.tar.gz lazygit && \
       sudo install lazygit /usr/local/bin; then
        rm -f lazygit lazygit.tar.gz
        print_success "LazyGit installed"
    else
        rm -f lazygit lazygit.tar.gz 2>/dev/null || true
        echo -e "${YELLOW}[WARNING]${NC} LazyGit installation failed (network timeout or error)"
        echo -e "${BLUE}[INFO]${NC} LazyGit is optional - continuing installation..."
        echo -e "${BLUE}[INFO]${NC} You can install LazyGit later from: https://github.com/jesseduffield/lazygit"
    fi
else
    print_success "LazyGit already installed"
fi

print_success "Debian/Ubuntu/Kali dependencies installed successfully!"
