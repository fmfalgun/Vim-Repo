--[[
================================================================================
  CODEIUM CONFIGURATION
================================================================================
  Free AI code completion similar to GitHub Copilot

  FEATURES:
  - Inline code suggestions
  - Supports 70+ programming languages
  - Fast and reliable
  - Completely free

  SETUP:
  1. Restart Neovim
  2. Run :Codeium Auth
  3. Sign up at https://codeium.com (free)
  4. Copy your API key and paste it in Neovim

  KEYBINDINGS:
  - <Tab>      Accept suggestion
  - <C-]>      Next suggestion
  - <C-[>      Previous suggestion
  - <C-x>      Dismiss suggestion
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

      -- Workspace root detection
      workspace_root = {
        use_lsp = true,
        find_root = nil,
        paths = {
          ".git",
          ".svn",
          ".hg",
          ".root",
          "package.json",
        },
      },
    })

    -- Add codeium to nvim-cmp sources
    local cmp = require("cmp")
    local config = cmp.get_config()

    -- Insert codeium at high priority
    table.insert(config.sources, 1, {
      name = "codeium",
      priority = 900,
      max_item_count = 5,
    })

    cmp.setup(config)

    -- Update formatting to show codeium icon
    local formatting = config.formatting or {}
    local format_orig = formatting.format

    formatting.format = function(entry, vim_item)
      if format_orig then
        vim_item = format_orig(entry, vim_item)
      end

      if entry.source.name == "codeium" then
        vim_item.kind = " Codeium"
        vim_item.kind_hl_group = "CmpItemKindCodeium"
      end

      return vim_item
    end

    cmp.setup({ formatting = formatting })

    -- Custom keybindings
    vim.keymap.set("i", "<C-g>", function()
      return vim.fn["codeium#Accept"]()
    end, { expr = true, desc = "Accept Codeium suggestion" })

    vim.keymap.set("i", "<C-]>", function()
      return vim.fn["codeium#CycleCompletions"](1)
    end, { expr = true, desc = "Next Codeium suggestion" })

    vim.keymap.set("i", "<C-[>", function()
      return vim.fn["codeium#CycleCompletions"](-1)
    end, { expr = true, desc = "Previous Codeium suggestion" })

    vim.keymap.set("i", "<C-x>", function()
      return vim.fn["codeium#Clear"]()
    end, { expr = true, desc = "Clear Codeium suggestion" })
  end,
}
