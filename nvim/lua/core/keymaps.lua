--[[
================================================================================
  KEYMAPS
================================================================================
  Custom key mappings for efficient navigation and editing

  Leader key: <Space>

  See docs/KEYBINDINGS.md for complete reference
================================================================================
--]]

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- ============================================================================
-- GENERAL
-- ============================================================================
-- Better escape
keymap("i", "jk", "<ESC>", opts)
keymap("i", "kj", "<ESC>", opts)

-- Save file
keymap("n", "<C-s>", ":w<CR>", opts)
keymap("i", "<C-s>", "<ESC>:w<CR>a", opts)

-- Quit
keymap("n", "<leader>q", ":q<CR>", opts)
keymap("n", "<leader>Q", ":qa!<CR>", opts)

-- Clear search highlight
keymap("n", "<Esc>", ":nohlsearch<CR>", opts)

-- ============================================================================
-- NAVIGATION
-- ============================================================================
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize windows with arrows
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Move lines up/down
keymap("n", "<A-j>", ":m .+1<CR>==", opts)
keymap("n", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", opts)
keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", opts)

-- ============================================================================
-- EDITING
-- ============================================================================
-- Better indenting
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Paste without yanking
keymap("v", "p", '"_dP', opts)

-- Delete without yanking
keymap("n", "<leader>d", '"_d', opts)
keymap("v", "<leader>d", '"_d', opts)

-- Select all
keymap("n", "<C-a>", "ggVG", opts)

-- ============================================================================
-- SPLITS
-- ============================================================================
keymap("n", "<leader>sv", ":vsplit<CR>", opts)  -- Split vertically
keymap("n", "<leader>sh", ":split<CR>", opts)   -- Split horizontally
keymap("n", "<leader>sx", ":close<CR>", opts)   -- Close split

-- ============================================================================
-- TABS
-- ============================================================================
keymap("n", "<leader>tn", ":tabnew<CR>", opts)      -- New tab
keymap("n", "<leader>tc", ":tabclose<CR>", opts)    -- Close tab
keymap("n", "<leader>to", ":tabonly<CR>", opts)     -- Close other tabs
keymap("n", "<leader>tl", ":tabnext<CR>", opts)     -- Next tab
keymap("n", "<leader>th", ":tabprevious<CR>", opts) -- Previous tab

-- ============================================================================
-- FILE EXPLORER (Neo-tree)
-- ============================================================================
keymap("n", "<leader>e", ":Neotree toggle<CR>", opts)
keymap("n", "<C-n>", ":Neotree toggle<CR>", opts)

-- ============================================================================
-- TELESCOPE (Fuzzy Finder)
-- ============================================================================
keymap("n", "<leader>ff", ":Telescope find_files<CR>", opts)
keymap("n", "<leader>fg", ":Telescope live_grep<CR>", opts)
keymap("n", "<leader>fb", ":Telescope buffers<CR>", opts)
keymap("n", "<leader>fh", ":Telescope help_tags<CR>", opts)
keymap("n", "<leader>fr", ":Telescope oldfiles<CR>", opts)
keymap("n", "<leader>fc", ":Telescope commands<CR>", opts)
keymap("n", "<leader>fk", ":Telescope keymaps<CR>", opts)
keymap("n", "<C-p>", ":Telescope find_files<CR>", opts)

-- ============================================================================
-- LSP (Language Server Protocol)
-- ============================================================================
-- These will be set up when LSP attaches to buffer
-- See lua/plugins/lsp.lua for LSP-specific keymaps

-- ============================================================================
-- DAP (Debugging)
-- ============================================================================
-- Debug keymaps (F-keys for debugging)
keymap("n", "<F5>", ":lua require('dap').continue()<CR>", opts)
keymap("n", "<F10>", ":lua require('dap').step_over()<CR>", opts)
keymap("n", "<F11>", ":lua require('dap').step_into()<CR>", opts)
keymap("n", "<F12>", ":lua require('dap').step_out()<CR>", opts)
keymap("n", "<F9>", ":lua require('dap').toggle_breakpoint()<CR>", opts)
keymap("n", "<leader>db", ":lua require('dap').toggle_breakpoint()<CR>", opts)
keymap("n", "<leader>dB", ":lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", opts)
keymap("n", "<leader>dr", ":lua require('dap').repl.open()<CR>", opts)
keymap("n", "<leader>dl", ":lua require('dap').run_last()<CR>", opts)
keymap("n", "<leader>du", ":lua require('dapui').toggle()<CR>", opts)
keymap("n", "<leader>dt", ":lua require('dap').terminate()<CR>", opts)

-- ============================================================================
-- GIT
-- ============================================================================
keymap("n", "<leader>gg", ":LazyGit<CR>", opts)
keymap("n", "<leader>gj", ":lua require('gitsigns').next_hunk()<CR>", opts)
keymap("n", "<leader>gk", ":lua require('gitsigns').prev_hunk()<CR>", opts)
keymap("n", "<leader>gp", ":lua require('gitsigns').preview_hunk()<CR>", opts)
keymap("n", "<leader>gr", ":lua require('gitsigns').reset_hunk()<CR>", opts)
keymap("n", "<leader>gs", ":lua require('gitsigns').stage_hunk()<CR>", opts)
keymap("n", "<leader>gu", ":lua require('gitsigns').undo_stage_hunk()<CR>", opts)
keymap("n", "<leader>gb", ":lua require('gitsigns').blame_line()<CR>", opts)

-- ============================================================================
-- TERMINAL
-- ============================================================================
keymap("n", "<leader>tf", ":ToggleTerm direction=float<CR>", opts)
keymap("n", "<leader>th", ":ToggleTerm direction=horizontal<CR>", opts)
keymap("n", "<leader>tv", ":ToggleTerm direction=vertical<CR>", opts)
keymap("t", "<C-x>", "<C-\\><C-n>", opts) -- Exit terminal mode

-- ============================================================================
-- COMMENTS
-- ============================================================================
-- These are handled by Comment.nvim plugin
-- gcc - Toggle comment line
-- gbc - Toggle comment block
-- gc{motion} - Comment motion

-- ============================================================================
-- CODE ACTIONS
-- ============================================================================
keymap("n", "<leader>ca", ":lua vim.lsp.buf.code_action()<CR>", opts)
keymap("n", "<leader>cf", ":lua vim.lsp.buf.format({ async = true })<CR>", opts)
keymap("v", "<leader>cf", ":lua vim.lsp.buf.format({ async = true })<CR>", opts)

-- ============================================================================
-- TROUBLE (Diagnostics)
-- ============================================================================
keymap("n", "<leader>xx", ":Trouble diagnostics toggle<CR>", opts)
keymap("n", "<leader>xw", ":Trouble workspace_diagnostics<CR>", opts)
keymap("n", "<leader>xd", ":Trouble document_diagnostics<CR>", opts)
keymap("n", "<leader>xq", ":Trouble quickfix<CR>", opts)
keymap("n", "<leader>xl", ":Trouble loclist<CR>", opts)

-- ============================================================================
-- WHICH-KEY (Shows available keybindings)
-- ============================================================================
-- Press <Space> and wait to see available commands

-- ============================================================================
-- CUSTOM LEADER MAPPINGS
-- ============================================================================
-- File operations
keymap("n", "<leader>fn", ":enew<CR>", opts)  -- New file
keymap("n", "<leader>fs", ":w<CR>", opts)     -- Save file
keymap("n", "<leader>fa", ":wa<CR>", opts)    -- Save all files

-- Buffer operations
keymap("n", "<leader>bd", ":bdelete<CR>", opts)     -- Delete buffer
keymap("n", "<leader>ba", ":%bd|e#|bd#<CR>", opts)  -- Delete all buffers except current
keymap("n", "<leader>bn", ":bnext<CR>", opts)       -- Next buffer
keymap("n", "<leader>bp", ":bprevious<CR>", opts)   -- Previous buffer

-- Quick access
keymap("n", "<leader>h", ":nohlsearch<CR>", opts)   -- Clear search highlight
keymap("n", "<leader>w", ":w<CR>", opts)            -- Quick save

-- Zen mode / Focus mode
keymap("n", "<leader>z", ":ZenMode<CR>", opts)

-- ============================================================================
-- COMMAND MODE
-- ============================================================================
-- Command-line mode mappings
keymap("c", "<C-a>", "<Home>", { noremap = true })
keymap("c", "<C-e>", "<End>", { noremap = true })
