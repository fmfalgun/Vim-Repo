--[[
================================================================================
  LUALINE CONFIGURATION
================================================================================
  Beautiful and informative statusline
================================================================================
--]]

require("lualine").setup({
  options = {
    icons_enabled = true,
    theme = "auto",
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = {
      statusline = { "dashboard", "neo-tree", "Trouble" },
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = true,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    },
  },

  sections = {
    lualine_a = { "mode" },
    lualine_b = {
      "branch",
      "diff",
      {
        "diagnostics",
        sources = { "nvim_diagnostic" },
        symbols = { error = " ", warn = " ", info = " ", hint = " " },
      },
    },
    lualine_c = {
      {
        "filename",
        file_status = true,
        path = 1,
        symbols = {
          modified = "[+]",
          readonly = "[-]",
          unnamed = "[No Name]",
        },
      },
    },
    lualine_x = {
      {
        "filetype",
        colored = true,
        icon_only = false,
        icon = { align = "right" },
      },
      "encoding",
      {
        "fileformat",
        symbols = {
          unix = "",
          dos = "",
          mac = "",
        },
      },
    },
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },

  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },

  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = { "neo-tree", "toggleterm", "quickfix", "fugitive" },
})
