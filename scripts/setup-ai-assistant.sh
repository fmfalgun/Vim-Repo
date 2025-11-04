#!/usr/bin/env bash
#===============================================================================
# AI ASSISTANT SETUP SCRIPT
#===============================================================================
# Interactive script to set up AI coding assistants for Neovim
# Supports: Codeium, Ollama (local models), and Avante.nvim
#===============================================================================

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color
BOLD='\033[1m'

# Emoji support
CHECK="✓"
CROSS="✗"
ARROW="→"
STAR="★"

#===============================================================================
# HELPER FUNCTIONS
#===============================================================================

print_header() {
    echo ""
    echo -e "${BOLD}${BLUE}╔══════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BOLD}${BLUE}║                                                          ║${NC}"
    echo -e "${BOLD}${BLUE}║          ${CYAN}AI CODING ASSISTANT SETUP${BLUE}                    ║${NC}"
    echo -e "${BOLD}${BLUE}║                                                          ║${NC}"
    echo -e "${BOLD}${BLUE}╚══════════════════════════════════════════════════════════╝${NC}"
    echo ""
}

print_section() {
    echo ""
    echo -e "${BOLD}${CYAN}$1${NC}"
    echo -e "${CYAN}─────────────────────────────────────────────────────${NC}"
}

print_success() {
    echo -e "${GREEN}${CHECK} $1${NC}"
}

print_error() {
    echo -e "${RED}${CROSS} $1${NC}"
}

print_info() {
    echo -e "${BLUE}${ARROW} $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠  $1${NC}"
}

ask_question() {
    echo -e "${YELLOW}❯ $1${NC}"
}

#===============================================================================
# AI ASSISTANT INFORMATION
#===============================================================================

show_ai_options() {
    print_section "Available AI Coding Assistants"

    echo ""
    echo -e "${BOLD}${GREEN}FREE OPTIONS:${NC}"
    echo ""

    echo -e "${BOLD}1. Codeium ${STAR}${STAR}${STAR} (RECOMMENDED FOR BEGINNERS)${NC}"
    echo -e "   ${CYAN}Type:${NC} Cloud-based, Auto-completion"
    echo -e "   ${CYAN}Pros:${NC}"
    echo -e "      ${GREEN}${CHECK}${NC} Completely free forever"
    echo -e "      ${GREEN}${CHECK}${NC} Similar to GitHub Copilot"
    echo -e "      ${GREEN}${CHECK}${NC} Fast and reliable"
    echo -e "      ${GREEN}${CHECK}${NC} Easy setup (just register and get API key)"
    echo -e "      ${GREEN}${CHECK}${NC} Supports 70+ languages"
    echo -e "      ${GREEN}${CHECK}${NC} Inline code suggestions"
    echo -e "   ${CYAN}Cons:${NC}"
    echo -e "      ${RED}${CROSS}${NC} Requires internet connection"
    echo -e "      ${RED}${CROSS}${NC} Your code is sent to their servers"
    echo -e "   ${CYAN}Best for:${NC} Most users, everyday coding"
    echo ""

    echo -e "${BOLD}2. Ollama + Local Models ${STAR}${STAR}${STAR} (RECOMMENDED FOR PRIVACY)${NC}"
    echo -e "   ${CYAN}Type:${NC} Local AI, Chat + Code completion"
    echo -e "   ${CYAN}Pros:${NC}"
    echo -e "      ${GREEN}${CHECK}${NC} 100% local and private"
    echo -e "      ${GREEN}${CHECK}${NC} No internet required (after setup)"
    echo -e "      ${GREEN}${CHECK}${NC} Your code never leaves your machine"
    echo -e "      ${GREEN}${CHECK}${NC} Multiple models available (CodeLlama, DeepSeek, Qwen)"
    echo -e "      ${GREEN}${CHECK}${NC} Chat interface + code completion"
    echo -e "   ${CYAN}Cons:${NC}"
    echo -e "      ${RED}${CROSS}${NC} Requires good hardware (8GB+ RAM, GPU recommended)"
    echo -e "      ${RED}${CROSS}${NC} Slower than cloud-based solutions"
    echo -e "      ${RED}${CROSS}${NC} Large downloads (models are 2-7GB each)"
    echo -e "      ${RED}${CROSS}${NC} More complex setup"
    echo -e "   ${CYAN}Best for:${NC} Privacy-conscious users, offline work"
    echo ""

    echo -e "${BOLD}3. Both (Codeium + Ollama) ${STAR}${STAR}${NC}"
    echo -e "   ${CYAN}Type:${NC} Hybrid approach"
    echo -e "   ${CYAN}Pros:${NC}"
    echo -e "      ${GREEN}${CHECK}${NC} Best of both worlds"
    echo -e "      ${GREEN}${CHECK}${NC} Fast completion (Codeium) + Private chat (Ollama)"
    echo -e "      ${GREEN}${CHECK}${NC} Use cloud when online, local when offline"
    echo -e "   ${CYAN}Cons:${NC}"
    echo -e "      ${RED}${CROSS}${NC} More complex setup"
    echo -e "      ${RED}${CROSS}${NC} Requires resources for local models"
    echo -e "   ${CYAN}Best for:${NC} Advanced users who want flexibility"
    echo ""

    echo ""
    echo -e "${BOLD}${YELLOW}PAID OPTIONS:${NC}"
    echo ""

    echo -e "${BOLD}4. GitHub Copilot${NC}"
    echo -e "   ${CYAN}Cost:${NC} \$10/month (students/teachers free)"
    echo -e "   ${CYAN}Pros:${NC}"
    echo -e "      ${GREEN}${CHECK}${NC} Best code completion available"
    echo -e "      ${GREEN}${CHECK}${NC} Very fast and accurate"
    echo -e "      ${GREEN}${CHECK}${NC} Trained on massive codebase"
    echo -e "   ${CYAN}Best for:${NC} Users with GitHub subscription"
    echo ""

    echo -e "${BOLD}5. Other Paid APIs (ChatGPT, Claude, etc.)${NC}"
    echo -e "   ${CYAN}Cost:${NC} Pay per use"
    echo -e "   ${CYAN}Note:${NC} Can be configured with Avante.nvim"
    echo ""
}

#===============================================================================
# INSTALLATION FUNCTIONS
#===============================================================================

install_codeium() {
    print_section "Installing Codeium"

    print_info "Codeium is a free AI code completion tool"
    echo ""

    # Check if already installed
    if [ -f "$HOME/.config/nvim/lua/plugins/ai/codeium.lua" ]; then
        print_warning "Codeium configuration already exists"
        ask_question "Do you want to reinstall? (y/n)"
        read -r response
        if [ "$response" != "y" ]; then
            return 0
        fi
    fi

    print_info "Creating Codeium configuration..."

    mkdir -p "$HOME/.config/nvim/lua/plugins/ai"

    cat > "$HOME/.config/nvim/lua/plugins/ai/codeium.lua" << 'EOF'
--[[
================================================================================
  CODEIUM CONFIGURATION
================================================================================
  Free AI code completion similar to GitHub Copilot
================================================================================
--]]

return {
  "Exafunction/codeium.nvim",
  event = "BufEnter",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
  },
  config = function()
    require("codeium").setup({
      -- Enable/disable codeium
      enable_chat = true,
    })

    -- Add codeium to nvim-cmp sources
    local cmp = require("cmp")
    local config = cmp.get_config()
    table.insert(config.sources, { name = "codeium", priority = 900 })
    cmp.setup(config)
  end,
}
EOF

    print_success "Codeium configuration created"
    echo ""
    print_info "Next steps:"
    echo "  1. Restart Neovim"
    echo "  2. Run ${CYAN}:Codeium Auth${NC} to get your API key"
    echo "  3. Sign up at https://codeium.com (free)"
    echo "  4. Copy your API key and paste it in Neovim"
    echo ""
}

install_ollama() {
    print_section "Installing Ollama + Local AI Models"

    # Check if ollama is installed
    if ! command -v ollama &> /dev/null; then
        print_info "Ollama is not installed. Installing..."

        if [ -f /etc/debian_version ]; then
            curl -fsSL https://ollama.com/install.sh | sh
        elif [ -f /etc/arch-release ]; then
            sudo pacman -S ollama --noconfirm
        else
            print_error "Unsupported distribution. Please install Ollama manually:"
            echo "  Visit: https://ollama.com/download"
            return 1
        fi
    else
        print_success "Ollama is already installed"
    fi

    # Start ollama service
    print_info "Starting Ollama service..."
    if command -v systemctl &> /dev/null; then
        sudo systemctl enable ollama
        sudo systemctl start ollama
    fi

    print_section "Select AI Model to Download"
    echo ""
    echo "Available models:"
    echo ""
    echo "1. CodeLlama (7B) - Fast, good for code completion (4GB)"
    echo "2. DeepSeek-Coder (6.7B) - Best coding model, slower (4GB)"
    echo "3. Qwen2.5-Coder (7B) - Balanced speed and quality (4GB)"
    echo "4. CodeGemma (7B) - Google's code model (5GB)"
    echo ""
    ask_question "Which model do you want to install? (1-4)"
    read -r model_choice

    case $model_choice in
        1)
            MODEL="codellama:7b"
            print_info "Downloading CodeLlama (7B)..."
            ;;
        2)
            MODEL="deepseek-coder:6.7b"
            print_info "Downloading DeepSeek-Coder (6.7B)..."
            ;;
        3)
            MODEL="qwen2.5-coder:7b"
            print_info "Downloading Qwen2.5-Coder (7B)..."
            ;;
        4)
            MODEL="codegemma:7b"
            print_info "Downloading CodeGemma (7B)..."
            ;;
        *)
            print_warning "Invalid choice. Using CodeLlama as default"
            MODEL="codellama:7b"
            ;;
    esac

    print_warning "This may take several minutes (downloading ~4GB)..."
    ollama pull "$MODEL"

    print_success "Model downloaded successfully"

    # Create llm.nvim configuration
    print_info "Creating local AI configuration..."

    mkdir -p "$HOME/.config/nvim/lua/plugins/ai"

    cat > "$HOME/.config/nvim/lua/plugins/ai/ollama.lua" << EOF
--[[
================================================================================
  OLLAMA + GEN.NVIM CONFIGURATION
================================================================================
  Local AI models for code generation and chat
================================================================================
--]]

return {
  "David-Kunz/gen.nvim",
  cmd = "Gen",
  config = function()
    require("gen").setup({
      model = "$MODEL",
      host = "localhost",
      port = "11434",
      display_mode = "split",
      show_prompt = true,
      show_model = true,
      no_auto_close = false,
      init = function(options)
        pcall(io.popen, "ollama serve > /dev/null 2>&1 &")
      end,
      command = function(options)
        return "curl --silent --no-buffer -X POST http://"
          .. options.host
          .. ":"
          .. options.port
          .. "/api/chat -d \$body"
      end,
    })

    -- Custom keybindings
    vim.keymap.set({ "n", "v" }, "<leader>ai", ":Gen<CR>", { desc = "AI Ollama" })
    vim.keymap.set("v", "<leader>ac", ":Gen Chat<CR>", { desc = "AI Chat" })
    vim.keymap.set("v", "<leader>ag", ":Gen Generate<CR>", { desc = "AI Generate" })
    vim.keymap.set("v", "<leader>ae", ":Gen Enhance_Code<CR>", { desc = "AI Enhance" })
    vim.keymap.set("v", "<leader>ar", ":Gen Review_Code<CR>", { desc = "AI Review" })
  end,
}
EOF

    print_success "Ollama configuration created"
    echo ""
    print_info "You can now use AI in Neovim:"
    echo "  ${CYAN}<leader>ai${NC} - Open AI menu"
    echo "  ${CYAN}<leader>ac${NC} - Chat with AI (visual mode)"
    echo "  ${CYAN}<leader>ag${NC} - Generate code"
    echo "  ${CYAN}<leader>ae${NC} - Enhance code"
    echo "  ${CYAN}<leader>ar${NC} - Review code"
    echo ""
}

install_github_copilot() {
    print_section "Installing GitHub Copilot"

    print_warning "GitHub Copilot requires an active subscription (\$10/month)"
    print_info "Students and teachers can get it for free"
    echo ""

    ask_question "Do you have a GitHub Copilot subscription? (y/n)"
    read -r has_subscription

    if [ "$has_subscription" != "y" ]; then
        print_info "You can sign up at: https://github.com/features/copilot"
        return 0
    fi

    mkdir -p "$HOME/.config/nvim/lua/plugins/ai"

    cat > "$HOME/.config/nvim/lua/plugins/ai/copilot.lua" << 'EOF'
--[[
================================================================================
  GITHUB COPILOT CONFIGURATION
================================================================================
  Official GitHub Copilot plugin for Neovim
================================================================================
--]]

return {
  "github/copilot.vim",
  event = "InsertEnter",
  config = function()
    -- Accept suggestion with Tab
    vim.g.copilot_no_tab_map = true
    vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })

    -- Navigate suggestions
    vim.keymap.set("i", "<C-]>", "<Plug>(copilot-next)")
    vim.keymap.set("i", "<C-[>", "<Plug>(copilot-previous)")
  end,
}
EOF

    print_success "GitHub Copilot configuration created"
    echo ""
    print_info "Next steps:"
    echo "  1. Restart Neovim"
    echo "  2. Run ${CYAN}:Copilot setup${NC}"
    echo "  3. Follow the authentication steps"
    echo ""
}

#===============================================================================
# MAIN MENU
#===============================================================================

main_menu() {
    print_header

    show_ai_options

    print_section "What would you like to install?"
    echo ""
    echo "1. Codeium (Free, Cloud-based) ${STAR}${STAR}${STAR} Recommended for beginners"
    echo "2. Ollama + Local Models (Free, Local) ${STAR}${STAR}${STAR} Recommended for privacy"
    echo "3. Both Codeium + Ollama (Best of both worlds)"
    echo "4. GitHub Copilot (Paid, requires subscription)"
    echo "5. Exit"
    echo ""

    ask_question "Enter your choice (1-5):"
    read -r choice

    case $choice in
        1)
            install_codeium
            ;;
        2)
            install_ollama
            ;;
        3)
            install_codeium
            install_ollama
            ;;
        4)
            install_github_copilot
            ;;
        5)
            print_info "Exiting..."
            exit 0
            ;;
        *)
            print_error "Invalid choice. Please try again."
            sleep 2
            main_menu
            ;;
    esac

    print_section "Installation Complete!"
    print_success "AI coding assistant has been configured"
    echo ""
    print_info "Next steps:"
    echo "  1. Open Neovim configuration: ${CYAN}nvim ~/.config/nvim/lua/plugins/init.lua${NC}"
    echo "  2. Add this line to enable AI plugins:"
    echo ""
    echo "     ${GREEN}-- Load AI assistant plugins${NC}"
    echo "     ${GREEN}require('plugins.ai.codeium')  -- or your chosen plugin${NC}"
    echo ""
    echo "  3. Or run: ${CYAN}./scripts/integrate-ai-plugins.sh${NC} to auto-integrate"
    echo "  4. Restart Neovim"
    echo ""
    print_warning "Remember to configure your API keys if using cloud services!"
    echo ""
}

# Run main menu
main_menu
