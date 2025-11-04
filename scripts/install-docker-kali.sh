#!/usr/bin/env bash
################################################################################
# DOCKER & KUBERNETES INSTALLATION FOR KALI LINUX
################################################################################
# Installs Docker and kubectl properly on Kali Linux
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

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

echo ""
echo "═══════════════════════════════════════════════════════════════"
echo "  DOCKER & KUBERNETES INSTALLER FOR KALI LINUX"
echo "═══════════════════════════════════════════════════════════════"
echo ""

# Check if running as root
if [ "$EUID" -eq 0 ]; then
    print_error "Please run this script as a normal user, not root"
    exit 1
fi

# Check if running on Kali
if ! grep -qi "kali" /etc/os-release 2>/dev/null; then
    print_warning "This script is designed for Kali Linux"
    print_info "Detected: $(lsb_release -d | cut -f2)"
    read -p "Continue anyway? (y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

################################################################################
# DOCKER INSTALLATION
################################################################################

print_info "Installing Docker..."

if command -v docker &> /dev/null; then
    print_success "Docker is already installed"
    docker --version
else
    print_info "Removing old Docker packages..."
    sudo apt-get remove -y docker docker-engine docker.io containerd runc 2>/dev/null || true

    print_info "Installing prerequisites..."
    sudo apt-get update
    sudo apt-get install -y \
        ca-certificates \
        curl \
        gnupg \
        lsb-release

    print_info "Adding Docker GPG key..."
    sudo install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    sudo chmod a+r /etc/apt/keyrings/docker.gpg

    print_info "Adding Docker repository (using Debian Bookworm)..."
    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
      bookworm stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    print_info "Updating package list..."
    sudo apt-get update

    print_info "Installing Docker Engine..."
    sudo apt-get install -y \
        docker-ce \
        docker-ce-cli \
        containerd.io \
        docker-buildx-plugin \
        docker-compose-plugin

    print_success "Docker installed successfully!"
    docker --version

    # Add user to docker group
    print_info "Adding user '$USER' to docker group..."
    sudo usermod -aG docker $USER

    print_warning "You need to logout and login again for docker group permissions to take effect"
    print_info "Or run: newgrp docker"
fi

# Enable and start docker
print_info "Enabling Docker service..."
sudo systemctl enable docker
sudo systemctl start docker

print_success "Docker service is running"

################################################################################
# DOCKER COMPOSE (if not installed)
################################################################################

print_info "Checking Docker Compose..."
if command -v docker compose &> /dev/null || command -v docker-compose &> /dev/null; then
    print_success "Docker Compose is already installed"
    docker compose version 2>/dev/null || docker-compose --version
else
    print_info "Installing Docker Compose..."
    COMPOSE_VERSION=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep 'tag_name' | cut -d\" -f4)
    sudo curl -L "https://github.com/docker/compose/releases/download/${COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    print_success "Docker Compose installed"
    docker-compose --version
fi

################################################################################
# KUBERNETES (KUBECTL)
################################################################################

print_info "Installing kubectl..."

if command -v kubectl &> /dev/null; then
    print_success "kubectl is already installed"
    kubectl version --client
else
    print_info "Downloading kubectl..."
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

    print_info "Installing kubectl..."
    sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
    rm kubectl

    print_success "kubectl installed successfully!"
    kubectl version --client
fi

################################################################################
# MINIKUBE (OPTIONAL)
################################################################################

print_info "Do you want to install Minikube (local Kubernetes cluster)?"
read -p "Install Minikube? (y/n) " -n 1 -r
echo

if [[ $REPLY =~ ^[Yy]$ ]]; then
    if command -v minikube &> /dev/null; then
        print_success "Minikube is already installed"
        minikube version
    else
        print_info "Installing Minikube..."
        curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
        sudo install minikube-linux-amd64 /usr/local/bin/minikube
        rm minikube-linux-amd64
        print_success "Minikube installed successfully!"
        minikube version
    fi
fi

################################################################################
# HELM (OPTIONAL)
################################################################################

print_info "Do you want to install Helm (Kubernetes package manager)?"
read -p "Install Helm? (y/n) " -n 1 -r
echo

if [[ $REPLY =~ ^[Yy]$ ]]; then
    if command -v helm &> /dev/null; then
        print_success "Helm is already installed"
        helm version
    else
        print_info "Installing Helm..."
        curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
        print_success "Helm installed successfully!"
        helm version
    fi
fi

################################################################################
# VERIFY INSTALLATION
################################################################################

echo ""
echo "═══════════════════════════════════════════════════════════════"
echo "  INSTALLATION COMPLETE!"
echo "═══════════════════════════════════════════════════════════════"
echo ""

print_success "Docker and Kubernetes tools installed successfully!"
echo ""

print_info "Installed versions:"
echo "  - Docker:  $(docker --version)"
echo "  - Docker Compose: $(docker compose version 2>/dev/null || docker-compose --version)"
echo "  - kubectl: $(kubectl version --client --short 2>/dev/null | head -1)"
command -v minikube &> /dev/null && echo "  - Minikube: $(minikube version --short 2>/dev/null)"
command -v helm &> /dev/null && echo "  - Helm: $(helm version --short 2>/dev/null)"

echo ""
print_warning "IMPORTANT: Logout and login again for Docker permissions to take effect!"
echo ""
print_info "Or run this command to activate docker group in current shell:"
echo "  newgrp docker"
echo ""

print_info "Quick test commands:"
echo "  docker run hello-world"
echo "  docker ps"
echo "  kubectl version --client"
echo ""

print_info "To use Docker without sudo, run:"
echo "  newgrp docker"
echo "  # Or logout and login again"
echo ""

print_success "Setup complete! You can now use Docker and Kubernetes in Neovim!"
