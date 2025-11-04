--[[
================================================================================
  PLUGINS CONFIGURATION
================================================================================
  Modern plugin setup using lazy.nvim

  This file loads all plugin configurations
================================================================================
--]]

require("lazy").setup({

  -- ============================================================================
  -- COLORSCHEME
  -- ============================================================================
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha", -- latte, frappe, macchiato, mocha
        transparent_background = false,
        integrations = {
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          treesitter = true,
          notify = true,
          mini = { enabled = true },
          telescope = { enabled = true },
          which_key = true,
        },
      })
      vim.cmd.colorscheme("catppuccin")
    end,
  },

  -- Alternative colorschemes
  { "folke/tokyonight.nvim", lazy = true },
  { "EdenEast/nightfox.nvim", lazy = true },
  { "rebelot/kanagawa.nvim", lazy = true },

  -- ============================================================================
  -- LSP (Language Server Protocol)
  -- ============================================================================
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      require("plugins.lsp")
    end,
  },

  -- LSP package manager
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    config = function()
      require("mason").setup({
        ui = {
          border = "rounded",
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })
    end,
  },

  -- Bridge mason and lspconfig
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
  },

  -- JSON schemas for autocompletion
  { "b0o/schemastore.nvim", lazy = true },

  -- ============================================================================
  -- COMPLETION
  -- ============================================================================
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-buffer",       -- Buffer completions
      "hrsh7th/cmp-path",         -- Path completions
      "hrsh7th/cmp-cmdline",      -- Command line completions
      "hrsh7th/cmp-nvim-lsp",     -- LSP completions
      "hrsh7th/cmp-nvim-lua",     -- Neovim Lua API completions
      "saadparwaiz1/cmp_luasnip", -- Snippet completions
      "L3MON4D3/LuaSnip",         -- Snippet engine
      "rafamadriz/friendly-snippets", -- Snippet collection
    },
    config = function()
      require("plugins.completion")
    end,
  },

  -- ============================================================================
  -- TREESITTER (Syntax Highlighting)
  -- ============================================================================
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "nvim-treesitter/nvim-treesitter-context",
    },
    config = function()
      require("plugins.treesitter")
    end,
  },

  -- ============================================================================
  -- TELESCOPE (Fuzzy Finder)
  -- ============================================================================
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    version = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },
    config = function()
      require("plugins.telescope")
    end,
  },

  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
  },

  -- ============================================================================
  -- FILE EXPLORER
  -- ============================================================================
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    cmd = "Neotree",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("plugins.neo-tree")
    end,
  },

  -- ============================================================================
  -- DEBUGGING (DAP)
  -- ============================================================================
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "theHamsta/nvim-dap-virtual-text",
      "jay-babu/mason-nvim-dap.nvim",
    },
    config = function()
      require("plugins.dap")
    end,
  },

  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
  },

  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = { "mfussenegger/nvim-dap", "williamboman/mason.nvim" },
  },

  -- ============================================================================
  -- UI ENHANCEMENTS
  -- ============================================================================
  -- Statusline
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("plugins.ui.lualine")
    end,
  },

  -- Bufferline (tabs)
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("plugins.ui.bufferline")
    end,
  },

  -- Indentation guides
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    main = "ibl",
    config = function()
      require("ibl").setup({
        indent = { char = "│" },
        scope = { enabled = false },
      })
    end,
  },

  -- Dashboard
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("plugins.ui.dashboard")
    end,
  },

  -- Better notifications
  {
    "rcarriga/nvim-notify",
    config = function()
      vim.notify = require("notify")
      require("notify").setup({
        background_colour = "#000000",
        timeout = 3000,
      })
    end,
  },

  -- Icons
  { "nvim-tree/nvim-web-devicons", lazy = true },

  -- ============================================================================
  -- GIT INTEGRATION
  -- ============================================================================
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("plugins.git.gitsigns")
    end,
  },

  {
    "tpope/vim-fugitive",
    cmd = { "Git", "G", "Gdiffsplit", "Gvdiffsplit" },
  },

  {
    "kdheepak/lazygit.nvim",
    cmd = { "LazyGit", "LazyGitConfig", "LazyGitFilter" },
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  -- ============================================================================
  -- CODING ASSISTANCE
  -- ============================================================================
  -- Auto pairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup({})
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp = require("cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },

  -- Comments
  {
    "numToStr/Comment.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("Comment").setup()
    end,
  },

  -- Surround
  {
    "kylechui/nvim-surround",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("nvim-surround").setup()
    end,
  },

  -- Todo comments
  {
    "folke/todo-comments.nvim",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("todo-comments").setup()
    end,
  },

  -- ============================================================================
  -- NAVIGATION
  -- ============================================================================
  -- Flash (quick jump)
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    },
  },

  -- Which-key (keybinding helper)
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      require("plugins.which-key")
    end,
  },

  -- ============================================================================
  -- TERMINAL
  -- ============================================================================
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        size = 20,
        open_mapping = [[<c-\>]],
        hide_numbers = true,
        shade_terminals = true,
        start_in_insert = true,
        direction = "float",
        float_opts = {
          border = "curved",
        },
      })
    end,
  },

  -- ============================================================================
  -- LANGUAGE-SPECIFIC PLUGINS
  -- ============================================================================
  -- Go
  {
    "ray-x/go.nvim",
    ft = { "go", "gomod" },
    dependencies = { "ray-x/guihua.lua" },
    config = function()
      require("go").setup()
    end,
  },

  -- Rust
  {
    "simrat39/rust-tools.nvim",
    ft = "rust",
    dependencies = { "neovim/nvim-lspconfig" },
  },

  -- Python
  {
    "linux-cultist/venv-selector.nvim",
    ft = "python",
    dependencies = { "neovim/nvim-lspconfig" },
    config = function()
      require("venv-selector").setup()
    end,
  },

  -- ============================================================================
  -- DIAGNOSTICS
  -- ============================================================================
  {
    "folke/trouble.nvim",
    cmd = { "Trouble", "TroubleToggle" },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("trouble").setup()
    end,
  },

  -- ============================================================================
  -- UTILITIES
  -- ============================================================================
  -- Session management
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    config = function()
      require("persistence").setup()
    end,
  },

  -- Zen mode
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    config = function()
      require("zen-mode").setup()
    end,
  },

  -- Better quickfix
  {
    "kevinhwang91/nvim-bqf",
    ft = "qf",
  },

  -- Markdown preview
  {
    "iamcco/markdown-preview.nvim",
    ft = "markdown",
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },

  -- Color highlighter
  {
    "NvChad/nvim-colorizer.lua",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("colorizer").setup({
        filetypes = { "*" },
        user_default_options = {
          names = false,
        },
      })
    end,
  },

  -- Docker
  {
    "kkvh/vim-docker-tools",
    ft = { "dockerfile", "yaml", "yml" },
  },

}, {
  -- Lazy.nvim configuration
  ui = {
    border = "rounded",
    icons = {
      cmd = "⌘",
      config = "🛠",
      event = "📅",
      ft = "📂",
      init = "⚙",
      keys = "🗝",
      plugin = "🔌",
      runtime = "💻",
      source = "📄",
      start = "🚀",
      task = "📌",
      lazy = "💤 ",
    },
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
