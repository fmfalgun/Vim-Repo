#!/usr/bin/env bash

################################################################################
# ARCH/GARUDA/MANJARO INSTALLATION SCRIPT
################################################################################
#
# Installs Neovim and all dependencies on Arch-based systems
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

print_info "Installing dependencies for Arch/Garuda/Manjaro..."

# Update system
print_info "Updating system..."
sudo pacman -Syu --noconfirm

# Install base development tools
print_info "Installing base development tools..."
sudo pacman -S --needed --noconfirm \
    base-devel \
    git \
    curl \
    wget \
    unzip \
    cmake \
    ninja

# Install Neovim
print_info "Installing Neovim..."
sudo pacman -S --needed --noconfirm neovim
print_success "Neovim installed"

# Install programming language dependencies

# Python
print_info "Installing Python tools..."
sudo pacman -S --needed --noconfirm \
    python \
    python-pip \
    python-virtualenv

# C/C++
print_info "Installing C/C++ tools..."
sudo pacman -S --needed --noconfirm \
    gcc \
    clang \
    llvm \
    gdb \
    lldb \
    cmake \
    ninja

# Java
print_info "Installing Java tools..."
sudo pacman -S --needed --noconfirm \
    jdk-openjdk \
    jre-openjdk

# Go
print_info "Installing Go..."
sudo pacman -S --needed --noconfirm go
print_success "Go installed"

# .NET Core (C#)
print_info "Installing .NET SDK..."
sudo pacman -S --needed --noconfirm dotnet-sdk
print_success ".NET installed"

# Node.js and npm
print_info "Installing Node.js..."
sudo pacman -S --needed --noconfirm nodejs npm
print_success "Node.js installed"

# Docker and Kubernetes tools
print_info "Installing Docker and K8s tools..."
sudo pacman -S --needed --noconfirm docker docker-compose kubectl

# Enable and start Docker
sudo systemctl enable docker
sudo systemctl start docker
sudo usermod -aG docker $USER
print_success "Docker installed (logout/login required for permissions)"

# Additional tools
print_info "Installing additional development tools..."
sudo pacman -S --needed --noconfirm \
    ripgrep \
    fd \
    tree \
    htop \
    shellcheck \
    yamllint \
    fzf

# Rust
print_info "Installing Rust..."
sudo pacman -S --needed --noconfirm rust rust-analyzer
print_success "Rust installed"

# Install LazyGit
print_info "Installing LazyGit..."
sudo pacman -S --needed --noconfirm lazygit
print_success "LazyGit installed"

# Install yay (AUR helper) if not present
if ! command -v yay &> /dev/null; then
    print_info "Installing yay (AUR helper)..."
    cd /tmp
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd ..
    rm -rf yay
    print_success "yay installed"
else
    print_success "yay already installed"
fi

# Install additional tools from AUR (optional)
print_info "Installing additional tools from AUR..."
yay -S --needed --noconfirm \
    visual-studio-code-bin \
    postman-bin || true

print_success "Arch/Garuda/Manjaro dependencies installed successfully!"
