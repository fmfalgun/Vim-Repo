--[[
================================================================================
  DASHBOARD CONFIGURATION
================================================================================
  Beautiful start screen
================================================================================
--]]

local db = require("dashboard")

db.setup({
  theme = "doom",
  config = {
    header = {
      "",
      "",
      "███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗",
      "████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║",
      "██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║",
      "██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║",
      "██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║",
      "╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝",
      "",
      "       🚀 Full-Stack Development Environment 🚀       ",
      "",
    },
    center = {
      {
        icon = "  ",
        icon_hl = "Title",
        desc = "Find File           ",
        desc_hl = "String",
        key = "f",
        keymap = "SPC f f",
        key_hl = "Number",
        action = "Telescope find_files",
      },
      {
        icon = "  ",
        icon_hl = "Title",
        desc = "Recent Files        ",
        desc_hl = "String",
        key = "r",
        keymap = "SPC f r",
        key_hl = "Number",
        action = "Telescope oldfiles",
      },
      {
        icon = "  ",
        icon_hl = "Title",
        desc = "Find Text           ",
        desc_hl = "String",
        key = "g",
        keymap = "SPC f g",
        key_hl = "Number",
        action = "Telescope live_grep",
      },
      {
        icon = "  ",
        icon_hl = "Title",
        desc = "File Explorer       ",
        desc_hl = "String",
        key = "e",
        keymap = "SPC e",
        key_hl = "Number",
        action = "Neotree toggle",
      },
      {
        icon = "  ",
        icon_hl = "Title",
        desc = "Configuration       ",
        desc_hl = "String",
        key = "c",
        keymap = "SPC f c",
        key_hl = "Number",
        action = "e ~/.config/nvim/init.lua",
      },
      {
        icon = "  ",
        icon_hl = "Title",
        desc = "Restore Session     ",
        desc_hl = "String",
        key = "s",
        keymap = "SPC s r",
        key_hl = "Number",
        action = "lua require('persistence').load()",
      },
      {
        icon = "  ",
        icon_hl = "Title",
        desc = "Quit                ",
        desc_hl = "String",
        key = "q",
        keymap = "SPC q",
        key_hl = "Number",
        action = "quit",
      },
    },
    footer = {
      "",
      "🎯 C • C++ • Python • C# • JavaScript • Java • Go • HTML • YAML • Docker 🎯",
      "",
    },
  },
})
