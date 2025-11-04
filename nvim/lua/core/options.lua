--[[
================================================================================
  NEOVIM OPTIONS
================================================================================
  General Neovim settings for optimal development experience
================================================================================
--]]

local opt = vim.opt

-- ============================================================================
-- GENERAL
-- ============================================================================
opt.mouse = "a"                         -- Enable mouse support
opt.clipboard = "unnamedplus"           -- Use system clipboard
opt.swapfile = false                    -- Disable swap files
opt.backup = false                      -- Disable backup files
opt.writebackup = false                 -- Disable backup before overwriting
opt.undofile = true                     -- Enable persistent undo
opt.undodir = vim.fn.stdpath("data") .. "/undo"  -- Undo directory
opt.updatetime = 300                    -- Faster completion (default: 4000ms)
opt.timeoutlen = 500                    -- Time to wait for mapped sequence
opt.completeopt = "menu,menuone,noselect"  -- Completion options

-- ============================================================================
-- UI/APPEARANCE
-- ============================================================================
opt.number = true                       -- Show line numbers
opt.relativenumber = true               -- Show relative line numbers
opt.cursorline = true                   -- Highlight current line
opt.signcolumn = "yes"                  -- Always show sign column
opt.termguicolors = true                -- True color support
opt.showmode = false                    -- Don't show mode (statusline does this)
opt.wrap = false                        -- Disable line wrap
opt.scrolloff = 8                       -- Lines to keep above/below cursor
opt.sidescrolloff = 8                   -- Columns to keep left/right of cursor
opt.pumheight = 10                      -- Popup menu height
opt.cmdheight = 1                       -- Command line height
opt.laststatus = 3                      -- Global statusline
opt.splitbelow = true                   -- Horizontal splits below
opt.splitright = true                   -- Vertical splits to the right
opt.colorcolumn = "100"                 -- Line length marker

-- ============================================================================
-- INDENTATION
-- ============================================================================
opt.expandtab = true                    -- Use spaces instead of tabs
opt.shiftwidth = 4                      -- Size of indent
opt.tabstop = 4                         -- Number of spaces per tab
opt.softtabstop = 4                     -- Number of spaces for <Tab>
opt.smartindent = true                  -- Smart auto-indenting
opt.autoindent = true                   -- Copy indent from current line

-- ============================================================================
-- SEARCH
-- ============================================================================
opt.ignorecase = true                   -- Ignore case in search
opt.smartcase = true                    -- Override ignorecase if uppercase used
opt.hlsearch = true                     -- Highlight search results
opt.incsearch = true                    -- Incremental search

-- ============================================================================
-- FOLDING
-- ============================================================================
opt.foldmethod = "expr"                 -- Use treesitter for folding
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldenable = false                  -- Don't fold by default
opt.foldlevel = 99                      -- High fold level

-- ============================================================================
-- ENCODING
-- ============================================================================
opt.encoding = "utf-8"                  -- UTF-8 encoding
opt.fileencoding = "utf-8"              -- File encoding

-- ============================================================================
-- PERFORMANCE
-- ============================================================================
opt.lazyredraw = false                  -- Don't redraw during macros (can cause issues)
opt.synmaxcol = 240                     -- Max column for syntax highlight

-- ============================================================================
-- WILDMENU (Command-line completion)
-- ============================================================================
opt.wildmenu = true                     -- Command-line completion
opt.wildmode = "longest:full,full"      -- Completion mode
opt.wildignore = "*.o,*.obj,*.pyc,*.class,*.swp,*.bak,*~"

-- ============================================================================
-- MISC
-- ============================================================================
opt.hidden = true                       -- Allow hidden buffers
opt.autoread = true                     -- Reload file if changed outside
opt.showcmd = true                      -- Show partial commands
opt.ruler = true                        -- Show cursor position
opt.confirm = true                      -- Confirm before closing unsaved
opt.virtualedit = "block"               -- Allow cursor in block mode
opt.conceallevel = 0                    -- Don't hide special chars (for markdown, json)
opt.title = true                        -- Set terminal title
opt.titlestring = "%<%F - nvim"         -- Terminal title format

-- ============================================================================
-- AUTO-COMPLETION & SUGGESTIONS
-- ============================================================================
opt.completeopt = "menu,menuone,noselect,noinsert"  -- Enhanced completion options
opt.shortmess:append("c")               -- Don't show completion messages
opt.pumblend = 10                       -- Popup menu transparency
opt.winblend = 10                       -- Floating window transparency

-- Create undo directory if it doesn't exist
local undo_dir = vim.fn.stdpath("data") .. "/undo"
if vim.fn.isdirectory(undo_dir) == 0 then
  vim.fn.mkdir(undo_dir, "p")
end
