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
    - Centralized logging to ~/.vim-logs/

  Author: Auto-generated Neovim Configuration
  License: MIT
================================================================================
--]]

-- ============================================================================
-- SUPPRESS NOISY STARTUP MESSAGES
-- ============================================================================
-- All errors go to ~/.vim-logs/ instead of console
vim.opt.shortmess:append("filmnrxoOtT")

-- Disable startup message
vim.opt.shortmess:append("I")

-- Reduce command-line messages
vim.opt.cmdheight = 0

-- ============================================================================
-- BOOTSTRAP LAZY.NVIM (Plugin Manager)
-- ============================================================================

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- ============================================================================
-- LEADER KEY
-- ============================================================================
-- Set leader key to space (must be set before loading plugins)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- ============================================================================
-- INITIALIZE LOGGING SYSTEM (LOAD FIRST!)
-- ============================================================================
local logging = require("core.logging")
logging.setup()

-- ============================================================================
-- ERROR HANDLER WRAPPER
-- ============================================================================
-- Wrap module loading in error handler
local function safe_require(module_name)
  local ok, result = pcall(require, module_name)
  if not ok then
    logging.error("init", "Failed to load module: " .. module_name, result)
    return nil
  end
  return result
end

-- ============================================================================
-- LOAD CORE CONFIGURATION
-- ============================================================================
safe_require("core.options")    -- General Neovim options
safe_require("core.keymaps")    -- Key mappings
safe_require("core.autocmds")   -- Auto commands

-- ============================================================================
-- LOAD PLUGIN CONFIGURATION
-- ============================================================================
safe_require("plugins")         -- Plugin setup and configuration

-- ============================================================================
-- STARTUP ERROR SUMMARY
-- ============================================================================
-- Show errors only if they exist (after 2 seconds to let plugins load)
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    -- Show startup error summary if any errors occurred
    logging.show_startup_errors()
  end,
})

-- ============================================================================
-- USER COMMANDS
-- ============================================================================
-- Open log directory
vim.api.nvim_create_user_command("VimLogs", function()
  logging.open_logs()
end, { desc = "Open Vim log directory" })

-- Show log stats
vim.api.nvim_create_user_command("VimLogStats", function()
  local stats = logging.get_stats()
  print(string.format(
    "Session: %s\nErrors: %d\nLog directory: %s",
    logging.current_session,
    stats.error_count,
    logging.session_dir
  ))
end, { desc = "Show log statistics" })

