--[[
================================================================================
  WHICH-KEY CONFIGURATION
================================================================================
  Displays available keybindings in a popup
  Updated for which-key v3.0+ API
================================================================================
--]]

local wk = require("which-key")

-- Setup which-key with v3.0+ configuration
wk.setup({
  preset = "modern",
  delay = 500,
  plugins = {
    marks = true,
    registers = true,
    spelling = {
      enabled = true,
      suggestions = 20,
    },
    presets = {
      operators = true,
      motions = true,
      text_objects = true,
      windows = true,
      nav = true,
      z = true,
      g = true,
    },
  },
  win = {
    border = "rounded",
    padding = { 2, 2, 2, 2 },
  },
  layout = {
    height = { min = 4, max = 25 },
    width = { min = 20, max = 50 },
    spacing = 3,
    align = "left",
  },
  show_help = true,
  show_keys = true,
})

-- Register key groups (v3.0+ format)
wk.add({
  { "<leader>f", group = "find/telescope" },
  { "<leader>g", group = "git" },
  { "<leader>d", group = "debug" },
  { "<leader>c", group = "code" },
  { "<leader>b", group = "buffer" },
  { "<leader>t", group = "toggle/tab/terminal" },
  { "<leader>s", group = "split/session" },
  { "<leader>w", group = "workspace" },
  { "<leader>x", group = "diagnostics/trouble" },
  { "<leader>h", group = "git hunks" },
  { "<leader>a", group = "AI assistant" },
})
