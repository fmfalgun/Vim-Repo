# 🚀 Modern Neovim Configuration

> **A production-ready, fully-featured Neovim setup for full-stack development**

[![Neovim](https://img.shields.io/badge/Neovim-0.9+-green.svg)](https://neovim.io/)
[![Lua](https://img.shields.io/badge/Lua-5.1+-blue.svg)](https://www.lua.org/)
[![License](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

Transform your Neovim into a powerful IDE with support for **C, C++, Python, C#, JavaScript, Java, Go, HTML, YAML, Docker, Kubernetes**, and more!

---

## ✨ Features

### 🎯 Language Support
- **C/C++** - clangd LSP, debugging with lldb/gdb
- **Python** - pyright LSP, debugpy debugging, virtual environment support
- **C#/.NET** - omnisharp LSP, netcoredbg debugging
- **JavaScript/TypeScript** - tsserver LSP, node debugging
- **Java** - jdtls LSP, java-debug-adapter
- **Go** - gopls LSP, delve debugging
- **HTML/CSS** - html/cssls LSP, live preview
- **YAML** - yamlls with Kubernetes schema support
- **Docker** - dockerls LSP, syntax highlighting
- **Bash** - bashls LSP, bash-debug-adapter
- **Rust** - rust-analyzer (bonus!)

### 🔥 Modern Features
- ⚡ **Blazing Fast** - Lazy loading with lazy.nvim
- 🎨 **Beautiful UI** - Catppuccin theme, lualine statusline, bufferline tabs
- 🔍 **Fuzzy Finding** - Telescope for files, grep, buffers, and more
- 📁 **File Explorer** - Neo-tree with git integration
- 🐛 **Debugging** - Full DAP support for all languages
- 📝 **Auto-completion** - nvim-cmp with LSP, snippets, and more
- 🤖 **AI Coding Assistants** - Codeium, Ollama, GitHub Copilot support
- 🌳 **Treesitter** - Advanced syntax highlighting
- 🔧 **Git Integration** - Gitsigns, Fugitive, LazyGit
- 📦 **Package Management** - Mason for LSP servers and DAP adapters
- ⌨️ **Smart Keybindings** - Which-key for discovering commands

### 🎓 Beginner Friendly
- 📚 **Comprehensive Documentation** - Complete guides for every language
- 🎯 **One-Command Installation** - Works on Debian, Ubuntu, Kali, Arch, Garuda
- 💡 **Interactive Help** - Press `<Space>` to see available commands
- 📖 **Debugging Guides** - Step-by-step tutorials for each language
- 🚀 **Quick Start Tutorial** - Get productive in 5 minutes

---

## 📦 Installation

### Quick Install (Automated)

```bash
# Clone the repository
git clone https://github.com/your-username/Vim-Repo.git
cd Vim-Repo

# Run the universal installer (detects your distro automatically)
chmod +x install.sh
./install.sh
```

### Supported Distributions
- ✅ **Debian** (10, 11, 12)
- ✅ **Ubuntu** (20.04, 22.04, 24.04)
- ✅ **Kali Linux** (2023.x, 2024.x)
- ✅ **Arch Linux**
- ✅ **Garuda Linux** (Sway, Dragonized)
- ✅ **Manjaro**

### Manual Installation

<details>
<summary>Click to expand manual installation steps</summary>

#### 1. Install Neovim (0.9+)
```bash
# Debian/Ubuntu/Kali
sudo apt-get install neovim

# Arch/Garuda/Manjaro
sudo pacman -S neovim
```

#### 2. Install Dependencies
```bash
# See scripts/install-debian.sh or scripts/install-arch.sh
# for complete dependency lists
```

#### 3. Copy Configuration
```bash
cp -r nvim ~/.config/
```

#### 4. Start Neovim
```bash
nvim
# Plugins will auto-install on first launch
```

</details>

---

## 🎯 Quick Start

### First Launch
1. Open Neovim: `nvim`
2. Wait for plugins to install (automatic)
3. Run `:checkhealth` to verify installation
4. Read the tutorial: `docs/BEGINNER_TUTORIAL.md`

### Essential Keybindings

| Key | Action |
|-----|--------|
| `<Space>` | Show all commands (Which-Key) |
| `<Space>ff` | Find files (Telescope) |
| `<Space>fg` | Find in files (Grep) |
| `<Space>e` | Toggle file explorer |
| `<F5>` | Start/Continue debugging |
| `<F9>` | Toggle breakpoint |
| `<F10>` | Step over (debug) |
| `gd` | Go to definition |
| `gr` | Find references |
| `K` | Show documentation |

📖 **Full keybindings**: [docs/KEYBINDINGS.md](docs/KEYBINDINGS.md)

---

## 📚 Documentation

### General
- [Installation Guide](docs/INSTALLATION.md) - Detailed installation instructions
- [Keybindings Reference](docs/KEYBINDINGS.md) - All shortcuts and commands
- [Beginner Tutorial](docs/BEGINNER_TUTORIAL.md) - Start here if new to Neovim!
- [AI Coding Assistants](docs/AI_ASSISTANTS.md) - Setup and use AI-powered coding

### Language-Specific Guides
Each guide includes setup, commands, debugging, and workflows:

- [C/C++ Development](docs/languages/C_CPP.md)
- [Python Development](docs/languages/PYTHON.md)
- [C#/.NET Development](docs/languages/CSHARP.md)
- [JavaScript/Node.js](docs/languages/JAVASCRIPT.md)
- [Java Development](docs/languages/JAVA.md)
- [Go Development](docs/languages/GO.md)
- [Web Development (HTML/CSS)](docs/languages/WEB.md)
- [DevOps (Docker/Kubernetes)](docs/languages/DEVOPS.md)

### Plugin Documentation
- [LSP Configuration](nvim/lua/plugins/lsp.lua) - Language server setup
- [DAP Configuration](nvim/lua/plugins/dap.lua) - Debugging setup
- [Plugin List](nvim/lua/plugins/init.lua) - All installed plugins

---

## 🎨 Screenshots

### Dashboard
Beautiful start screen with quick actions

### File Explorer (Neo-tree)
Modern file tree with git status

### Debugging (DAP UI)
Professional debugging interface

### Code Completion
Intelligent auto-completion with LSP

---

## 🛠️ Customization

### Change Colorscheme
```lua
-- Edit nvim/lua/plugins/init.lua
-- Line ~12: Change "catppuccin" to:
-- "tokyonight", "nightfox", or "kanagawa"
```

### Add Custom Keybindings
```lua
-- Edit nvim/lua/core/keymaps.lua
-- Add your custom mappings
vim.keymap.set("n", "<leader>x", ":YourCommand<CR>", { desc = "Your description" })
```

### Install Additional LSP Servers
```vim
:Mason
# Press 'i' on any server to install
```

---

## 🐛 Debugging Setup

### Per-Language Debugging

<details>
<summary><b>C/C++</b></summary>

```bash
# Compile with debug symbols
gcc -g myprogram.c -o myprogram

# Open in Neovim
nvim myprogram.c

# Press F9 to set breakpoint
# Press F5 to start debugging
```
</details>

<details>
<summary><b>Python</b></summary>

```bash
# Open your Python file
nvim script.py

# Press F9 to set breakpoint
# Press F5 to start debugging
# Automatically detects virtual environment
```
</details>

<details>
<summary><b>JavaScript/Node.js</b></summary>

```bash
# Open your JS file
nvim app.js

# Press F9 to set breakpoint
# Press F5 to start debugging
```
</details>

📖 **Full debugging guides**: See [docs/languages/](docs/languages/) for each language

---

## 🔧 Troubleshooting

### Plugins Not Loading
```vim
:Lazy sync
```

### LSP Not Working
```vim
:Mason
:LspInfo
:checkhealth
```

### Performance Issues
```lua
-- Disable some features in nvim/lua/core/options.lua
-- See Performance section in docs/INSTALLATION.md
```

### More Help
- Run `:checkhealth` for diagnostics
- Check [docs/INSTALLATION.md](docs/INSTALLATION.md)
- Open an issue on GitHub

---

## 📋 Requirements

### Minimum
- Neovim 0.9+
- Git
- A C compiler (gcc/clang)
- Node.js 16+ (for LSP servers)

### Recommended
- Neovim 0.10+
- Nerd Font (for icons)
- ripgrep (for fast grep)
- fd (for fast file finding)
- LazyGit (for git UI)

---

## 🤝 Contributing

Contributions are welcome! Feel free to:
- Report bugs
- Suggest features
- Submit pull requests
- Improve documentation

---

## 📝 License

MIT License - feel free to use and modify!

---

## 🙏 Credits

Built with these amazing projects:
- [Neovim](https://neovim.io/)
- [lazy.nvim](https://github.com/folke/lazy.nvim)
- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
- [nvim-dap](https://github.com/mfussenegger/nvim-dap)
- [Telescope](https://github.com/nvim-telescope/telescope.nvim)
- [Treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
- And many more! See [nvim/lua/plugins/init.lua](nvim/lua/plugins/init.lua)

---

## ⭐ Show Your Support

If this configuration helped you, please:
- ⭐ Star this repository
- 🐛 Report bugs
- 📖 Improve documentation
- 💡 Share with others

---

<div align="center">

**Happy Coding! 🚀**

Made with ❤️ for developers who love the terminal

</div>
