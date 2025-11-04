--[[
================================================================================
  GITHUB COPILOT CONFIGURATION
================================================================================
  Official GitHub Copilot plugin for Neovim

  FEATURES:
  - Best-in-class code completion
  - Trained on massive public codebase
  - Fast and accurate suggestions
  - Multi-line completions

  REQUIREMENTS:
  - Active GitHub Copilot subscription ($10/month)
  - Free for students and teachers
  - Sign up at: https://github.com/features/copilot

  SETUP:
  1. Restart Neovim
  2. Run :Copilot setup
  3. Follow the authentication steps
  4. Visit the URL and enter the code shown

  KEYBINDINGS:
  - <C-J>      Accept suggestion
  - <C-]>      Next suggestion
  - <C-[>      Previous suggestion
  - <M-]>      Next word
  - <M-[>      Previous word

  COMMANDS:
  - :Copilot setup      Initial setup and authentication
  - :Copilot enable     Enable Copilot
  - :Copilot disable    Disable Copilot
  - :Copilot status     Check Copilot status
  - :Copilot signout    Sign out
================================================================================
--]]

return {
  "github/copilot.vim",
  event = "InsertEnter",
  config = function()
    -- Don't use Tab for accepting suggestions (conflicts with completion)
    vim.g.copilot_no_tab_map = true

    -- File types to enable Copilot
    vim.g.copilot_filetypes = {
      ["*"] = true,
      ["gitcommit"] = false,
      ["gitrebase"] = false,
      ["markdown"] = true,
      ["yaml"] = true,
    }

    -- Copilot node command (use system Node.js)
    vim.g.copilot_node_command = "node"

    -- Custom keybindings
    -- Accept suggestion with Ctrl+J
    vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', {
      silent = true,
      expr = true,
      script = true,
    })

    -- Navigate suggestions
    vim.keymap.set("i", "<C-]>", "<Plug>(copilot-next)", { desc = "Next Copilot suggestion" })
    vim.keymap.set("i", "<C-[>", "<Plug>(copilot-previous)", { desc = "Previous Copilot suggestion" })

    -- Word-level navigation
    vim.keymap.set("i", "<M-]>", "<Plug>(copilot-accept-word)", { desc = "Accept next word" })
    vim.keymap.set("i", "<M-[>", "<Plug>(copilot-accept-line)", { desc = "Accept line" })

    -- Dismiss suggestion
    vim.keymap.set("i", "<C-e>", "<Plug>(copilot-dismiss)", { desc = "Dismiss Copilot" })

    -- Suggest (manually trigger)
    vim.keymap.set("i", "<M-\\>", "<Plug>(copilot-suggest)", { desc = "Trigger Copilot" })

    -- Add highlight groups
    vim.api.nvim_set_hl(0, "CopilotSuggestion", {
      fg = "#555555",
      italic = true,
    })

    -- Status line integration
    vim.g.copilot_status_formatter = function()
      local status = vim.fn["copilot#GetDisplayedSuggestion"]()
      if status.text ~= "" then
        return " Copilot"
      else
        return ""
      end
    end
  end,
}
