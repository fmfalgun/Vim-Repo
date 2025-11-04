--[[
================================================================================
  AUTOCOMMANDS
================================================================================
  Automatic commands triggered by events
================================================================================
--]]

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- ============================================================================
-- GENERAL
-- ============================================================================

-- Highlight on yank
autocmd("TextYankPost", {
  group = augroup("HighlightYank", { clear = true }),
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
  end,
})

-- Remove trailing whitespace on save
autocmd("BufWritePre", {
  group = augroup("TrimWhitespace", { clear = true }),
  pattern = "*",
  command = [[%s/\s\+$//e]],
})

-- Auto-resize splits when window is resized
autocmd("VimResized", {
  group = augroup("ResizeSplits", { clear = true }),
  pattern = "*",
  command = "wincmd =",
})

-- Return to last edit position when opening files
autocmd("BufReadPost", {
  group = augroup("LastPosition", { clear = true }),
  pattern = "*",
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local line_count = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= line_count then
      vim.api.nvim_win_set_cursor(0, mark)
    end
  end,
})

-- Close some filetypes with 'q'
autocmd("FileType", {
  group = augroup("CloseWithQ", { clear = true }),
  pattern = {
    "qf", "help", "man", "notify", "lspinfo", "startuptime",
    "checkhealth", "fugitive", "git", "Trouble"
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

-- ============================================================================
-- LANGUAGE-SPECIFIC
-- ============================================================================

-- Python
autocmd("FileType", {
  group = augroup("PythonSettings", { clear = true }),
  pattern = "python",
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.expandtab = true
    vim.opt_local.colorcolumn = "88"  -- Black formatter default
  end,
})

-- JavaScript/TypeScript
autocmd("FileType", {
  group = augroup("JavaScriptSettings", { clear = true }),
  pattern = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.expandtab = true
  end,
})

-- Go
autocmd("FileType", {
  group = augroup("GoSettings", { clear = true }),
  pattern = "go",
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.expandtab = false  -- Go uses tabs
  end,
})

-- C/C++
autocmd("FileType", {
  group = augroup("CSettings", { clear = true }),
  pattern = { "c", "cpp", "h", "hpp" },
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.expandtab = true
    vim.opt_local.colorcolumn = "100"
  end,
})

-- Java
autocmd("FileType", {
  group = augroup("JavaSettings", { clear = true }),
  pattern = "java",
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.expandtab = true
  end,
})

-- HTML/CSS
autocmd("FileType", {
  group = augroup("WebSettings", { clear = true }),
  pattern = { "html", "css", "scss", "sass" },
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.expandtab = true
  end,
})

-- YAML
autocmd("FileType", {
  group = augroup("YAMLSettings", { clear = true }),
  pattern = { "yaml", "yml" },
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.expandtab = true
  end,
})

-- Docker
autocmd("FileType", {
  group = augroup("DockerSettings", { clear = true }),
  pattern = { "dockerfile", "docker-compose" },
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.expandtab = true
  end,
})

-- Markdown
autocmd("FileType", {
  group = augroup("MarkdownSettings", { clear = true }),
  pattern = "markdown",
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
    vim.opt_local.conceallevel = 2
  end,
})

-- ============================================================================
-- LSP
-- ============================================================================

-- Format on save (can be enabled per filetype)
autocmd("BufWritePre", {
  group = augroup("LspFormat", { clear = true }),
  pattern = { "*.go", "*.rs", "*.lua" },  -- Add languages you want auto-format
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})

-- ============================================================================
-- TERMINAL
-- ============================================================================

-- Start terminal in insert mode
autocmd("TermOpen", {
  group = augroup("TerminalSettings", { clear = true }),
  pattern = "*",
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.cmd("startinsert")
  end,
})

-- ============================================================================
-- PERFORMANCE
-- ============================================================================

-- Disable syntax highlighting for large files
autocmd("BufReadPre", {
  group = augroup("LargeFile", { clear = true }),
  pattern = "*",
  callback = function(args)
    local file_size = vim.fn.getfsize(args.file)
    if file_size > 1024 * 1024 then  -- 1MB
      vim.cmd("syntax off")
      vim.opt_local.foldmethod = "manual"
      vim.opt_local.undolevels = -1
    end
  end,
})

-- ============================================================================
-- MISC
-- ============================================================================

-- Check if file changed outside of Neovim
autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = augroup("Checktime", { clear = true }),
  command = "checktime",
})

-- Equalize splits when Neovim is resized
autocmd("VimResized", {
  group = augroup("ResizeEqualize", { clear = true }),
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})
