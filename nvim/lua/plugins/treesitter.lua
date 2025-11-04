--[[
================================================================================
  TREESITTER CONFIGURATION
================================================================================
  Advanced syntax highlighting and code understanding
================================================================================
--]]

require("nvim-treesitter.configs").setup({
  -- Install parsers for all supported languages
  ensure_installed = {
    "c",
    "cpp",
    "python",
    "c_sharp",
    "javascript",
    "typescript",
    "tsx",
    "java",
    "go",
    "html",
    "css",
    "scss",
    "json",
    "yaml",
    "toml",
    "lua",
    "vim",
    "vimdoc",
    "bash",
    "dockerfile",
    "markdown",
    "markdown_inline",
    "regex",
    "rust",
    "sql",
    "graphql",
    "http",
  },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  auto_install = true,

  -- Highlighting
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },

  -- Indentation
  indent = {
    enable = true,
    disable = { "python", "yaml" }, -- Better handled by LSP
  },

  -- Incremental selection
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<C-space>",
      node_incremental = "<C-space>",
      scope_incremental = "<C-s>",
      node_decremental = "<C-backspace>",
    },
  },

  -- Text objects
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["al"] = "@loop.outer",
        ["il"] = "@loop.inner",
        ["aa"] = "@parameter.outer",
        ["ia"] = "@parameter.inner",
      },
    },
    move = {
      enable = true,
      set_jumps = true,
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
    },
  },
})

-- Treesitter context (shows current function/class at top)
require("treesitter-context").setup({
  enable = true,
  max_lines = 0,
  min_window_height = 0,
  line_numbers = true,
  multiline_threshold = 20,
  trim_scope = "outer",
  mode = "cursor",
  separator = nil,
})
