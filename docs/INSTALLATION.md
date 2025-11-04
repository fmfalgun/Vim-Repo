# 📦 Installation Guide

Complete installation instructions for all supported platforms.

---

## Table of Contents
- [Quick Installation](#quick-installation)
- [System Requirements](#system-requirements)
- [Supported Distributions](#supported-distributions)
- [Installation Steps](#installation-steps)
- [Post-Installation](#post-installation)
- [Troubleshooting](#troubleshooting)

---

## Quick Installation

### Automated Installation (Recommended)

```bash
# Clone the repository
git clone https://github.com/your-username/Vim-Repo.git
cd Vim-Repo

# Run the installer
chmod +x install.sh
./install.sh
```

The installer will:
1. Detect your Linux distribution
2. Install Neovim and dependencies
3. Install language servers and debuggers
4. Configure Neovim
5. Install all plugins

---

## System Requirements

### Minimum Requirements
- **OS**: Linux (Debian/Ubuntu/Kali/Arch/Garuda/Manjaro)
- **Neovim**: 0.9.0 or later
- **Git**: 2.0 or later
- **C Compiler**: gcc or clang
- **Node.js**: 16.0 or later
- **Disk Space**: ~500MB for full installation

### Recommended
- **Neovim**: 0.10.0 or later
- **RAM**: 4GB or more
- **Terminal**: Alacritty, Kitty, or WezTerm (for best experience)
- **Font**: A Nerd Font (for icons)

---

## Supported Distributions

| Distribution | Versions | Status |
|-------------|----------|--------|
| Debian | 10, 11, 12 | ✅ Fully Supported |
| Ubuntu | 20.04, 22.04, 24.04 | ✅ Fully Supported |
| Kali Linux | 2023.x, 2024.x | ✅ Fully Supported |
| Arch Linux | Rolling | ✅ Fully Supported |
| Garuda Linux | Sway, Dragonized | ✅ Fully Supported |
| Manjaro | Rolling | ✅ Fully Supported |

---

## Installation Steps

### Step 1: Install Dependencies

#### Debian/Ubuntu/Kali

```bash
# Update package list
sudo apt-get update

# Install build tools
sudo apt-get install -y build-essential cmake git curl wget

# Install Neovim
sudo apt-get install -y neovim

# Or install latest version via AppImage
wget https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod +x nvim.appimage
sudo mv nvim.appimage /usr/local/bin/nvim
```

#### Arch/Garuda/Manjaro

```bash
# Update system
sudo pacman -Syu

# Install Neovim and dependencies
sudo pacman -S neovim git curl wget base-devel cmake
```

### Step 2: Install Programming Languages

#### Install All Languages (Recommended)

```bash
# Run the distro-specific script
./scripts/install-debian.sh    # For Debian/Ubuntu/Kali
./scripts/install-arch.sh      # For Arch/Garuda/Manjaro
```

#### Manual Language Installation

<details>
<summary><b>Python</b></summary>

```bash
# Debian/Ubuntu/Kali
sudo apt-get install -y python3 python3-pip python3-venv

# Arch/Garuda/Manjaro
sudo pacman -S python python-pip
```
</details>

<details>
<summary><b>C/C++</b></summary>

```bash
# Debian/Ubuntu/Kali
sudo apt-get install -y gcc g++ clang clangd gdb lldb

# Arch/Garuda/Manjaro
sudo pacman -S gcc clang llvm gdb lldb
```
</details>

<details>
<summary><b>Java</b></summary>

```bash
# Debian/Ubuntu/Kali
sudo apt-get install -y default-jdk

# Arch/Garuda/Manjaro
sudo pacman -S jdk-openjdk
```
</details>

<details>
<summary><b>Go</b></summary>

```bash
# Debian/Ubuntu/Kali
sudo apt-get install -y golang-go

# Arch/Garuda/Manjaro
sudo pacman -S go
```
</details>

<details>
<summary><b>C#/.NET</b></summary>

```bash
# Debian/Ubuntu/Kali
wget https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
sudo apt-get update
sudo apt-get install -y dotnet-sdk-8.0

# Arch/Garuda/Manjaro
sudo pacman -S dotnet-sdk
```
</details>

<details>
<summary><b>Node.js</b></summary>

```bash
# Debian/Ubuntu/Kali
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt-get install -y nodejs

# Arch/Garuda/Manjaro
sudo pacman -S nodejs npm
```
</details>

### Step 3: Install Configuration

```bash
# Backup existing config (if any)
mv ~/.config/nvim ~/.config/nvim.backup.$(date +%Y%m%d)

# Copy new configuration
cp -r nvim ~/.config/
```

### Step 4: First Launch

```bash
# Start Neovim
nvim

# Plugins will install automatically
# Wait for completion (2-5 minutes)
```

---

## Post-Installation

### Verify Installation

```vim
" In Neovim, run:
:checkhealth

" Check LSP servers:
:Mason

" Check installed plugins:
:Lazy
```

### Install Language Servers

```vim
" Open Mason
:Mason

" Navigate with:
"   j/k - move up/down
"   i   - install
"   X   - uninstall
"   U   - update

" Recommended servers (auto-installed):
" - lua_ls
" - clangd
" - pyright
" - tsserver
" - gopls
" - omnisharp
" - jdtls
```

### Install Nerd Font (For Icons)

```bash
# Download a Nerd Font
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts

# FiraCode Nerd Font (recommended)
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.0/FiraCode.zip
unzip FiraCode.zip
rm FiraCode.zip

# Refresh font cache
fc-cache -fv

# Configure your terminal to use "FiraCode Nerd Font"
```

---

## Troubleshooting

### Neovim Version Too Old

```bash
# Remove old version
sudo apt-get remove neovim  # or: sudo pacman -R neovim

# Install from AppImage (Debian/Ubuntu)
wget https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod +x nvim.appimage
sudo mv nvim.appimage /usr/local/bin/nvim

# Or build from source (Arch)
yay -S neovim-git
```

### Plugins Not Installing

```vim
" Manually trigger installation
:Lazy sync

" Check for errors
:Lazy log
:checkhealth lazy
```

### LSP Not Working

```vim
" Check LSP status
:LspInfo

" Install missing servers
:Mason

" Check health
:checkhealth lsp
```

### Icons Not Showing

1. Install a Nerd Font (see above)
2. Configure your terminal to use the font
3. Restart terminal and Neovim

### Slow Performance

```lua
-- Edit nvim/lua/core/options.lua
-- Disable some features:

-- Disable virtual text
vim.diagnostic.config({ virtual_text = false })

-- Reduce updatetime
vim.opt.updatetime = 1000

-- Disable some plugins in nvim/lua/plugins/init.lua
```

### Python Virtual Environment Not Detected

```vim
" Manually select venv
:VenvSelect

" Or set in project:
" Create .venv/ in project root
```

### Clipboard Not Working

```bash
# Install clipboard provider
# Debian/Ubuntu/Kali
sudo apt-get install xclip

# Arch/Garuda/Manjaro
sudo pacman -S xclip
```

---

## Advanced Configuration

### Custom LSP Settings

Edit `nvim/lua/plugins/lsp.lua` to customize language servers.

### Custom Keybindings

Edit `nvim/lua/core/keymaps.lua` to add or modify keybindings.

### Change Colorscheme

Edit `nvim/lua/plugins/init.lua`, line ~35:
```lua
vim.cmd.colorscheme("tokyonight")  -- or "nightfox", "kanagawa"
```

---

## Getting Help

1. **Check Health**: `:checkhealth`
2. **Read Logs**: `:Lazy log`, `:LspLog`
3. **Documentation**: See `docs/` folder
4. **GitHub Issues**: Report bugs or ask questions

---

## Next Steps

- Read [BEGINNER_TUTORIAL.md](BEGINNER_TUTORIAL.md) to get started
- Check [KEYBINDINGS.md](KEYBINDINGS.md) for shortcuts
- Explore language guides in [docs/languages/](languages/)

---

**Installation complete! 🎉 Start coding with `nvim`**
