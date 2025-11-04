#!/usr/bin/env bash
################################################################################
# NEOVIM CONFIGURATION UNINSTALLER
################################################################################
# Completely removes Neovim configuration and optionally the application
################################################################################

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'
BOLD='\033[1m'

print_header() {
    echo ""
    echo -e "${BOLD}${BLUE}═══════════════════════════════════════════════════════════════${NC}"
    echo -e "${BOLD}${BLUE}  $1${NC}"
    echo -e "${BOLD}${BLUE}═══════════════════════════════════════════════════════════════${NC}"
    echo ""
}

print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[✓]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[!]${NC} $1"
}

print_error() {
    echo -e "${RED}[✗]${NC} $1"
}

print_question() {
    echo -e "${CYAN}[?]${NC} $1"
}

ask_confirmation() {
    local prompt="$1"
    local default="${2:-n}"

    if [ "$default" = "y" ]; then
        prompt="$prompt [Y/n]: "
    else
        prompt="$prompt [y/N]: "
    fi

    read -p "$(echo -e ${CYAN}[?]${NC} $prompt)" response
    response=${response:-$default}

    if [[ "$response" =~ ^[Yy]$ ]]; then
        return 0
    else
        return 1
    fi
}

################################################################################
# MAIN UNINSTALL FUNCTION
################################################################################

uninstall_neovim_config() {
    print_header "NEOVIM CONFIGURATION UNINSTALLER"

    print_warning "This will remove your Neovim configuration!"
    echo ""

    # Show what will be removed
    echo -e "${BOLD}The following will be checked and removed if found:${NC}"
    echo "  • ~/.config/nvim (Neovim configuration)"
    echo "  • ~/.local/share/nvim (Plugins, data, state)"
    echo "  • ~/.local/state/nvim (Session data)"
    echo "  • ~/.cache/nvim (Cache files)"
    echo "  • ~/.vim-logs (Log files)"
    echo ""

    if ! ask_confirmation "Do you want to continue?"; then
        print_info "Uninstall cancelled"
        exit 0
    fi

    echo ""
    print_header "REMOVING NEOVIM CONFIGURATION"

    # Backup option
    if ask_confirmation "Do you want to create a backup before removing?" "y"; then
        BACKUP_DIR="$HOME/nvim-backup-$(date +%Y%m%d_%H%M%S)"
        mkdir -p "$BACKUP_DIR"

        print_info "Creating backup at: $BACKUP_DIR"

        [ -d ~/.config/nvim ] && cp -r ~/.config/nvim "$BACKUP_DIR/nvim-config"
        [ -d ~/.local/share/nvim ] && cp -r ~/.local/share/nvim "$BACKUP_DIR/nvim-data"
        [ -d ~/.vim-logs ] && cp -r ~/.vim-logs "$BACKUP_DIR/vim-logs"

        print_success "Backup created at: $BACKUP_DIR"
        echo ""
    fi

    # Remove configuration
    if [ -d ~/.config/nvim ]; then
        print_info "Removing ~/.config/nvim..."
        rm -rf ~/.config/nvim
        print_success "Configuration removed"
    else
        print_info "Configuration directory not found (already removed)"
    fi

    # Remove data
    if [ -d ~/.local/share/nvim ]; then
        print_info "Removing ~/.local/share/nvim (plugins, data)..."
        rm -rf ~/.local/share/nvim
        print_success "Data removed"
    else
        print_info "Data directory not found (already removed)"
    fi

    # Remove state
    if [ -d ~/.local/state/nvim ]; then
        print_info "Removing ~/.local/state/nvim (state files)..."
        rm -rf ~/.local/state/nvim
        print_success "State removed"
    else
        print_info "State directory not found (already removed)"
    fi

    # Remove cache
    if [ -d ~/.cache/nvim ]; then
        print_info "Removing ~/.cache/nvim (cache files)..."
        rm -rf ~/.cache/nvim
        print_success "Cache removed"
    else
        print_info "Cache directory not found (already removed)"
    fi

    # Remove logs
    if [ -d ~/.vim-logs ]; then
        print_info "Removing ~/.vim-logs (log files)..."
        rm -rf ~/.vim-logs
        print_success "Logs removed"
    else
        print_info "Log directory not found (already removed)"
    fi

    # Remove old backups (if any)
    if [ -d ~/.config/nvim.backup.* ]; then
        if ask_confirmation "Remove old configuration backups?"; then
            print_info "Removing old backups..."
            rm -rf ~/.config/nvim.backup.*
            print_success "Old backups removed"
        fi
    fi

    echo ""
    print_success "Neovim configuration uninstalled successfully!"
}

################################################################################
# UNINSTALL NEOVIM APPLICATION
################################################################################

uninstall_neovim_app() {
    echo ""
    print_header "UNINSTALL NEOVIM APPLICATION"

    if ! command -v nvim &> /dev/null; then
        print_info "Neovim is not installed"
        return
    fi

    print_warning "This will remove Neovim itself from your system"

    if ! ask_confirmation "Do you want to uninstall Neovim?"; then
        print_info "Keeping Neovim installed"
        return
    fi

    # Detect OS
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        OS=$ID
    fi

    print_info "Uninstalling Neovim..."

    case $OS in
        debian|ubuntu|kali)
            sudo apt-get remove -y neovim
            sudo apt-get autoremove -y
            print_success "Neovim uninstalled (Debian/Ubuntu/Kali)"
            ;;
        arch|manjaro|garuda)
            sudo pacman -Rs --noconfirm neovim
            print_success "Neovim uninstalled (Arch/Manjaro/Garuda)"
            ;;
        *)
            print_warning "Unknown distribution. Please uninstall Neovim manually."
            ;;
    esac
}

################################################################################
# UNINSTALL DEPENDENCIES
################################################################################

uninstall_dependencies() {
    echo ""
    print_header "UNINSTALL DEPENDENCIES"

    print_warning "This will remove development tools installed by the installer"
    echo ""
    echo "This includes:"
    echo "  • Language servers (LSPs)"
    echo "  • Debug adapters (DAPs)"
    echo "  • Development tools (ripgrep, fd-find, etc.)"
    echo "  • Programming languages (Rust, Go, etc.)"
    echo ""

    if ! ask_confirmation "Do you want to uninstall dependencies?"; then
        print_info "Keeping dependencies installed"
        return
    fi

    # Detect OS
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        OS=$ID
    fi

    case $OS in
        debian|ubuntu|kali)
            print_info "Removing development tools..."
            sudo apt-get remove -y ripgrep fd-find tree htop shellcheck yamllint 2>/dev/null || true

            if ask_confirmation "Remove Rust? (rustc, cargo)"; then
                rustup self uninstall -y 2>/dev/null || true
                print_success "Rust removed"
            fi

            if ask_confirmation "Remove LazyGit?"; then
                sudo rm -f /usr/local/bin/lazygit
                print_success "LazyGit removed"
            fi

            if ask_confirmation "Remove kubectl?"; then
                sudo rm -f /usr/local/bin/kubectl
                print_success "kubectl removed"
            fi

            sudo apt-get autoremove -y
            print_success "Dependencies cleaned up"
            ;;
        arch|manjaro|garuda)
            print_info "Removing development tools..."
            sudo pacman -Rs --noconfirm ripgrep fd tree htop shellcheck yamllint 2>/dev/null || true

            if ask_confirmation "Remove Rust? (rustc, cargo)"; then
                rustup self uninstall -y 2>/dev/null || true
                print_success "Rust removed"
            fi

            print_success "Dependencies cleaned up"
            ;;
    esac
}

################################################################################
# CLEAN HOME DIRECTORY
################################################################################

clean_home_directory() {
    echo ""
    print_header "CLEAN HOME DIRECTORY"

    print_info "Checking for leftover files..."

    # Remove cargo if Rust was removed
    if [ -d ~/.cargo ] && ! command -v rustc &> /dev/null; then
        if ask_confirmation "Remove ~/.cargo directory? (Rust removed)"; then
            rm -rf ~/.cargo
            print_success "~/.cargo removed"
        fi
    fi

    # Remove go if Go was removed
    if [ -d ~/go ] && ! command -v go &> /dev/null; then
        if ask_confirmation "Remove ~/go directory? (Go removed)"; then
            rm -rf ~/go
            print_success "~/go removed"
        fi
    fi

    # Clean bashrc/zshrc entries
    if ask_confirmation "Remove PATH modifications from shell configs?"; then
        # Backup shell configs
        [ -f ~/.bashrc ] && cp ~/.bashrc ~/.bashrc.backup
        [ -f ~/.zshrc ] && cp ~/.zshrc ~/.zshrc.backup

        # Remove Go PATH
        [ -f ~/.bashrc ] && sed -i '/\/usr\/local\/go\/bin/d' ~/.bashrc
        [ -f ~/.zshrc ] && sed -i '/\/usr\/local\/go\/bin/d' ~/.zshrc

        # Remove Cargo PATH
        [ -f ~/.bashrc ] && sed -i '/\.cargo\/env/d' ~/.bashrc
        [ -f ~/.zshrc ] && sed -i '/\.cargo\/env/d' ~/.zshrc

        print_success "Shell configs cleaned (backups created)"
    fi
}

################################################################################
# MAIN MENU
################################################################################

main_menu() {
    while true; do
        clear
        print_header "NEOVIM UNINSTALLER - MAIN MENU"

        echo "What would you like to do?"
        echo ""
        echo "  1. Uninstall Neovim configuration only (keep Neovim)"
        echo "  2. Uninstall Neovim configuration + application"
        echo "  3. Uninstall everything (config + app + dependencies)"
        echo "  4. Clean up leftover files"
        echo "  5. Exit"
        echo ""

        read -p "$(echo -e ${CYAN}[?]${NC} Enter your choice [1-5]: )" choice

        case $choice in
            1)
                uninstall_neovim_config
                echo ""
                read -p "Press Enter to continue..."
                ;;
            2)
                uninstall_neovim_config
                uninstall_neovim_app
                echo ""
                read -p "Press Enter to continue..."
                ;;
            3)
                uninstall_neovim_config
                uninstall_neovim_app
                uninstall_dependencies
                clean_home_directory
                echo ""
                read -p "Press Enter to continue..."
                ;;
            4)
                clean_home_directory
                echo ""
                read -p "Press Enter to continue..."
                ;;
            5)
                print_info "Exiting uninstaller"
                exit 0
                ;;
            *)
                print_error "Invalid choice"
                sleep 2
                ;;
        esac
    done
}

################################################################################
# RUN
################################################################################

# Check if running as root
if [ "$EUID" -eq 0 ]; then
    print_error "Please do not run this script as root!"
    exit 1
fi

# Run main menu
main_menu
