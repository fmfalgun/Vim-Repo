--[[
================================================================================
  AVANTE.NVIM CONFIGURATION
================================================================================
  AI chat interface for Neovim with multiple backend support

  FEATURES:
  - Chat with AI about your code
  - Supports multiple backends (Claude, ChatGPT, Ollama, etc.)
  - Code diff view for suggested changes
  - Context-aware conversations
  - Visual selection support

  SUPPORTED BACKENDS:
  1. Claude (Anthropic) - Requires API key
  2. ChatGPT (OpenAI) - Requires API key
  3. Ollama (Local) - Free, requires Ollama installation
  4. Gemini (Google) - Requires API key

  SETUP FOR PAID APIS:
  Set environment variables in ~/.bashrc or ~/.zshrc:
    export ANTHROPIC_API_KEY="your-key"
    export OPENAI_API_KEY="your-key"
    export GOOGLE_API_KEY="your-key"

  SETUP FOR OLLAMA (FREE):
  1. Install Ollama: curl -fsSL https://ollama.com/install.sh | sh
  2. Pull a model: ollama pull codellama:7b
  3. Change provider to "ollama" below

  KEYBINDINGS:
  - <leader>aa  Toggle Avante chat
  - <leader>ar  Refresh chat
  - <leader>ae  Edit selected code
  - <leader>as  Ask about selection

  COMMANDS:
  - :AvanteAsk          Ask a question
  - :AvanteChat         Open chat window
  - :AvanteEdit         Edit with AI
  - :AvanteRefresh      Refresh suggestions
================================================================================
--]]

return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  build = "make",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
  },
  opts = {
    -- Configure your preferred AI provider here
    provider = "ollama", -- "claude", "openai", "gemini", or "ollama"

    -- Ollama configuration (free, local)
    ollama = {
      endpoint = "http://localhost:11434/v1",
      model = "codellama:7b",
      timeout = 30000,
      temperature = 0.7,
      max_tokens = 4096,
    },

    -- Claude configuration (paid)
    claude = {
      endpoint = "https://api.anthropic.com",
      model = "claude-3-5-sonnet-20241022",
      temperature = 0.7,
      max_tokens = 4096,
    },

    -- OpenAI configuration (paid)
    openai = {
      endpoint = "https://api.openai.com/v1",
      model = "gpt-4",
      temperature = 0.7,
      max_tokens = 4096,
    },

    -- Gemini configuration (paid)
    gemini = {
      endpoint = "https://generativelanguage.googleapis.com/v1beta/models",
      model = "gemini-pro",
      temperature = 0.7,
      max_tokens = 4096,
    },

    -- UI configuration
    windows = {
      wrap = true,
      width = 40, -- Width percentage
      sidebar_header = {
        align = "center",
        rounded = true,
      },
    },

    -- Hints configuration
    hints = {
      enabled = true,
    },

    -- Diff configuration
    diff = {
      debug = false,
      autojump = true,
    },

    -- Behaviour
    behaviour = {
      auto_suggestions = false,
      auto_set_highlight_group = true,
      auto_set_keymaps = true,
      auto_apply_diff_after_generation = false,
      support_paste_from_clipboard = true,
    },
  },
  config = function(_, opts)
    require("avante").setup(opts)

    -- Custom keybindings
    vim.keymap.set("n", "<leader>aa", "<cmd>AvanteAsk<CR>", { desc = "Avante Ask" })
    vim.keymap.set("v", "<leader>aa", "<cmd>AvanteAsk<CR>", { desc = "Avante Ask (selection)" })
    vim.keymap.set("n", "<leader>ar", "<cmd>AvanteRefresh<CR>", { desc = "Avante Refresh" })
    vim.keymap.set("n", "<leader>ae", "<cmd>AvanteEdit<CR>", { desc = "Avante Edit" })
    vim.keymap.set("v", "<leader>ae", "<cmd>AvanteEdit<CR>", { desc = "Avante Edit (selection)" })

    -- Add to which-key menu
    local wk_ok, wk = pcall(require, "which-key")
    if wk_ok then
      wk.register({
        ["<leader>a"] = {
          name = "AI Assistant",
          a = { "Ask AI" },
          r = { "Refresh" },
          e = { "Edit with AI" },
        },
      })
    end

    -- Provider switching commands
    vim.api.nvim_create_user_command("AvanteUseOllama", function()
      require("avante").switch_provider("ollama")
      vim.notify("Switched to Ollama (local)", vim.log.levels.INFO)
    end, {})

    vim.api.nvim_create_user_command("AvanteUseClaude", function()
      require("avante").switch_provider("claude")
      vim.notify("Switched to Claude (paid)", vim.log.levels.INFO)
    end, {})

    vim.api.nvim_create_user_command("AvanteUseOpenAI", function()
      require("avante").switch_provider("openai")
      vim.notify("Switched to OpenAI (paid)", vim.log.levels.INFO)
    end, {})

    vim.api.nvim_create_user_command("AvanteUseGemini", function()
      require("avante").switch_provider("gemini")
      vim.notify("Switched to Gemini (paid)", vim.log.levels.INFO)
    end, {})
  end,
}
