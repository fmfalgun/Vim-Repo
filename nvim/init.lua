--[[
================================================================================
  NEOVIM CONFIGURATION - INIT.LUA
================================================================================

  Modern Neovim configuration with full-stack development support

  Supported Languages:
    - C/C++, Python, C#, JavaScript/TypeScript, Java, Go
    - HTML/CSS, YAML, Docker, Kubernetes, Hyperledger Fabric

  Features:
    - Native LSP (Language Server Protocol)
    - DAP (Debug Adapter Protocol) for all languages
    - Treesitter syntax highlighting
    - Modern UI with icons and statusline
    - Git integration
    - Fuzzy finding and file exploration

  Author: Auto-generated Neovim Configuration
  License: MIT
================================================================================
--]]

-- ============================================================================
-- BOOTSTRAP LAZY.NVIM (Plugin Manager)
-- ============================================================================

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  print("Installing lazy.nvim plugin manager...")
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
  print("lazy.nvim installed successfully!")
end
vim.opt.rtp:prepend(lazypath)

-- ============================================================================
-- LEADER KEY
-- ============================================================================
-- Set leader key to space (must be set before loading plugins)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- ============================================================================
-- LOAD CORE CONFIGURATION
-- ============================================================================
require("core.options")    -- General Neovim options
require("core.keymaps")    -- Key mappings
require("core.autocmds")   -- Auto commands

-- ============================================================================
-- LOAD PLUGIN CONFIGURATION
-- ============================================================================
require("plugins")         -- Plugin setup and configuration

-- ============================================================================
-- WELCOME MESSAGE
-- ============================================================================
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if vim.fn.argc() == 0 then
      print("🚀 Welcome to Neovim! Press <Space> to see available commands.")
    end
  end,
})
