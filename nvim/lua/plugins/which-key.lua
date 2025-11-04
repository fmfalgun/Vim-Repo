--[[
================================================================================
  WHICH-KEY CONFIGURATION
================================================================================
  Displays available keybindings in a popup
================================================================================
--]]

local wk = require("which-key")

wk.setup({
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
  window = {
    border = "rounded",
    position = "bottom",
    margin = { 1, 0, 1, 0 },
    padding = { 2, 2, 2, 2 },
    winblend = 0,
  },
  layout = {
    height = { min = 4, max = 25 },
    width = { min = 20, max = 50 },
    spacing = 3,
    align = "left",
  },
  show_help = true,
  show_keys = true,
  triggers = "auto",
  triggers_blacklist = {
    i = { "j", "k" },
    v = { "j", "k" },
  },
})

-- Register key groups
wk.register({
  ["<leader>f"] = { name = "+find/telescope" },
  ["<leader>g"] = { name = "+git" },
  ["<leader>d"] = { name = "+debug" },
  ["<leader>c"] = { name = "+code" },
  ["<leader>b"] = { name = "+buffer" },
  ["<leader>t"] = { name = "+toggle/tab/terminal" },
  ["<leader>s"] = { name = "+split/session" },
  ["<leader>w"] = { name = "+workspace" },
  ["<leader>x"] = { name = "+diagnostics/trouble" },
  ["<leader>h"] = { name = "+git hunks" },
})
