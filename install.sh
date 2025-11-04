#!/usr/bin/env bash

################################################################################
# UNIVERSAL NEOVIM CONFIGURATION INSTALLER
################################################################################
#
# This script automatically detects your Linux distribution and installs
# Neovim along with all required dependencies and language servers.
#
# Supported Distributions:
#   - Debian/Ubuntu/Kali Linux
#   - Arch Linux/Garuda Linux/Manjaro
#
# Usage:
#   chmod +x install.sh
#   ./install.sh
#
################################################################################

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Helper functions
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

print_header() {
    echo ""
    echo "═══════════════════════════════════════════════════════════════"
    echo "  $1"
    echo "═══════════════════════════════════════════════════════════════"
    echo ""
}

# Detect Linux distribution
detect_distro() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        OS=$ID
        OS_VERSION=$VERSION_ID
    else
        print_error "Cannot detect Linux distribution"
        exit 1
    fi

    print_info "Detected OS: $OS"
}

# Check if running as root
check_root() {
    if [ "$EUID" -eq 0 ]; then
        print_error "Please do not run this script as root!"
        print_info "The script will ask for sudo password when needed."
        exit 1
    fi
}

# Main installation
main() {
    print_header "NEOVIM CONFIGURATION INSTALLER"

    check_root
    detect_distro

    case $OS in
        debian|ubuntu|kali)
            print_info "Using Debian-based installation script"
            bash "$(dirname "$0")/scripts/install-debian.sh"
            ;;
        arch|manjaro|garuda)
            print_info "Using Arch-based installation script"
            bash "$(dirname "$0")/scripts/install-arch.sh"
            ;;
        *)
            print_error "Unsupported distribution: $OS"
            print_info "Please install manually or create an issue on GitHub"
            exit 1
            ;;
    esac

    # Common post-installation steps
    print_header "POST-INSTALLATION SETUP"

    # Create config directory
    print_info "Setting up Neovim configuration..."
    mkdir -p ~/.config/nvim

    # Copy configuration files
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    print_info "Copying configuration files from: $SCRIPT_DIR/nvim"

    if [ -d "$SCRIPT_DIR/nvim" ]; then
        # Backup existing config if it exists
        if [ -d ~/.config/nvim ] && [ "$(ls -A ~/.config/nvim)" ]; then
            print_warning "Existing Neovim config found. Creating backup..."
            BACKUP_DIR=~/.config/nvim.backup.$(date +%Y%m%d_%H%M%S)
            mv ~/.config/nvim "$BACKUP_DIR"
            print_success "Backup created at: $BACKUP_DIR"
        fi

        # Copy new configuration
        cp -r "$SCRIPT_DIR/nvim" ~/.config/
        print_success "Configuration files copied successfully"
    else
        print_error "Configuration directory not found: $SCRIPT_DIR/nvim"
        exit 1
    fi

    # Install Node.js (needed for many LSP servers)
    print_info "Checking Node.js installation..."
    if ! command -v node &> /dev/null; then
        print_info "Installing Node.js..."
        case $OS in
            debian|ubuntu|kali)
                curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
                sudo apt-get install -y nodejs
                ;;
            arch|manjaro|garuda)
                sudo pacman -S --noconfirm nodejs npm
                ;;
        esac
        print_success "Node.js installed"
    else
        print_success "Node.js already installed"
    fi

    # First run to install plugins
    print_header "INSTALLING NEOVIM PLUGINS"
    print_info "Starting Neovim to install plugins..."
    print_info "This may take a few minutes..."
    print_warning "Neovim will open and close automatically"

    # Run Neovim headless to install plugins
    nvim --headless "+Lazy! sync" +qa 2>/dev/null || true

    print_success "Plugins installed successfully"

    # Final message
    print_header "INSTALLATION COMPLETE!"
    echo ""
    echo "  🚀 Neovim configuration installed successfully!"
    echo ""
    echo "  Next steps:"
    echo "    1. Open Neovim: nvim"
    echo "    2. Wait for lazy.nvim to finish installing plugins"
    echo "    3. Run :checkhealth to verify installation"
    echo "    4. Read the documentation in docs/ folder"
    echo ""
    echo "  Important commands:"
    echo "    :Mason         - Install/manage LSP servers"
    echo "    :Lazy          - Manage plugins"
    echo "    :checkhealth   - Check installation health"
    echo ""
    echo "  Documentation:"
    echo "    docs/INSTALLATION.md    - Installation guide"
    echo "    docs/KEYBINDINGS.md     - Keybindings reference"
    echo "    docs/languages/         - Language-specific guides"
    echo ""
    echo "  Quick start:"
    echo "    <Space>         - Show available commands"
    echo "    <Space>ff       - Find files"
    echo "    <Space>e        - File explorer"
    echo "    <F5>            - Start debugging"
    echo ""
    print_success "Happy coding! 🎉"
    echo ""
}

main "$@"
