# ⌨️ Keybindings Reference

Complete guide to all keybindings in this Neovim configuration.

**Leader Key**: `<Space>`

---

## Quick Reference Card

### Essential Commands
| Key | Action |
|-----|--------|
| `<Space>` | Show all commands (Which-Key) |
| `:q` | Quit |
| `:w` | Save |
| `:wq` | Save and quit |
| `u` | Undo |
| `<C-r>` | Redo |

---

## Navigation

### Basic Movement
| Key | Action |
|-----|--------|
| `h/j/k/l` | Left/Down/Up/Right |
| `w` | Next word |
| `b` | Previous word |
| `0` | Start of line |
| `$` | End of line |
| `gg` | Top of file |
| `G` | Bottom of file |
| `{number}G` | Go to line number |
| `%` | Jump to matching bracket |

### Window Navigation
| Key | Action |
|-----|--------|
| `<C-h>` | Move to left window |
| `<C-j>` | Move to bottom window |
| `<C-k>` | Move to top window |
| `<C-l>` | Move to right window |

### Buffer Navigation
| Key | Action |
|-----|--------|
| `<S-l>` | Next buffer |
| `<S-h>` | Previous buffer |
| `<leader>bd` | Delete buffer |
| `<leader>bn` | Next buffer |
| `<leader>bp` | Previous buffer |

---

## File Operations

### File Explorer (Neo-tree)
| Key | Action |
|-----|--------|
| `<leader>e` | Toggle file explorer |
| `<C-n>` | Toggle file explorer |
| `<Space>` | Expand/collapse folder |
| `<CR>` | Open file |
| `a` | Add file |
| `d` | Delete file |
| `r` | Rename file |
| `y` | Copy file |
| `x` | Cut file |
| `p` | Paste file |
| `R` | Refresh |
| `?` | Show help |

### Telescope (Fuzzy Finder)
| Key | Action |
|-----|--------|
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep (find in files) |
| `<leader>fb` | Find buffers |
| `<leader>fh` | Find help tags |
| `<leader>fr` | Recent files |
| `<leader>fc` | Find commands |
| `<leader>fk` | Find keymaps |
| `<C-p>` | Find files (shortcut) |

---

## LSP (Code Intelligence)

### Code Navigation
| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gi` | Go to implementation |
| `gr` | Find references |
| `K` | Show hover documentation |
| `<C-k>` | Show signature help |
| `<leader>fd` | Telescope definitions |
| `<leader>fi` | Telescope implementations |
| `<leader>fs` | Telescope document symbols |

### Code Actions
| Key | Action |
|-----|--------|
| `<leader>rn` | Rename symbol |
| `<leader>ca` | Code actions |
| `<leader>cf` | Format code |
| `[d` | Previous diagnostic |
| `]d` | Next diagnostic |
| `<leader>e` | Show diagnostic float |
| `<leader>dl` | Diagnostic loclist |

### Workspace
| Key | Action |
|-----|--------|
| `<leader>wa` | Add workspace folder |
| `<leader>wr` | Remove workspace folder |
| `<leader>wl` | List workspace folders |

---

## Debugging (DAP)

### Debug Controls
| Key | Action |
|-----|--------|
| `<F5>` | Continue/Start debugging |
| `<F9>` | Toggle breakpoint |
| `<F10>` | Step over |
| `<F11>` | Step into |
| `<F12>` | Step out |
| `<leader>db` | Toggle breakpoint |
| `<leader>dB` | Conditional breakpoint |
| `<leader>dr` | Open REPL |
| `<leader>du` | Toggle debug UI |
| `<leader>dt` | Terminate debug session |
| `<leader>dh` | Hover (evaluate) |
| `<leader>de` | Evaluate expression |

---

## Git Integration

### Git Signs
| Key | Action |
|-----|--------|
| `<leader>gj` | Next hunk |
| `<leader>gk` | Previous hunk |
| `<leader>gp` | Preview hunk |
| `<leader>gr` | Reset hunk |
| `<leader>gs` | Stage hunk |
| `<leader>gu` | Undo stage hunk |
| `<leader>gb` | Blame line |
| `]c` | Next change |
| `[c` | Previous change |

### Git Commands
| Key | Action |
|-----|--------|
| `<leader>gg` | Open LazyGit |
| `:Git` | Fugitive git command |

---

## Editing

### Insert Mode
| Key | Action |
|-----|--------|
| `i` | Insert before cursor |
| `a` | Insert after cursor |
| `I` | Insert at line start |
| `A` | Insert at line end |
| `o` | New line below |
| `O` | New line above |
| `jk` or `kj` | Exit insert mode |

### Visual Mode
| Key | Action |
|-----|--------|
| `v` | Visual mode |
| `V` | Visual line mode |
| `<C-v>` | Visual block mode |
| `<` | Indent left (in visual) |
| `>` | Indent right (in visual) |
| `p` | Paste without yanking |

### Text Manipulation
| Key | Action |
|-----|--------|
| `d` | Delete (with motion) |
| `dd` | Delete line |
| `y` | Yank/copy (with motion) |
| `yy` | Yank line |
| `p` | Paste after |
| `P` | Paste before |
| `c` | Change (with motion) |
| `cc` | Change line |
| `.` | Repeat last command |
| `<A-j>` | Move line down |
| `<A-k>` | Move line up |

### Comments
| Key | Action |
|-----|--------|
| `gcc` | Toggle comment line |
| `gbc` | Toggle comment block |
| `gc{motion}` | Comment motion (e.g., `gcap`) |

### Surround
| Key | Action |
|-----|--------|
| `ys{motion}{char}` | Add surround |
| `ds{char}` | Delete surround |
| `cs{old}{new}` | Change surround |
| Example: `ysiw"` | Surround word with quotes |

---

## Window Management

### Splits
| Key | Action |
|-----|--------|
| `<leader>sv` | Split vertically |
| `<leader>sh` | Split horizontally |
| `<leader>sx` | Close split |
| `<C-Up>` | Increase height |
| `<C-Down>` | Decrease height |
| `<C-Left>` | Decrease width |
| `<C-Right>` | Increase width |

### Tabs
| Key | Action |
|-----|--------|
| `<leader>tn` | New tab |
| `<leader>tc` | Close tab |
| `<leader>to` | Close other tabs |
| `<leader>tl` | Next tab |
| `<leader>th` | Previous tab |

---

## Terminal

| Key | Action |
|-----|--------|
| `<leader>tf` | Toggle floating terminal |
| `<leader>th` | Toggle horizontal terminal |
| `<leader>tv` | Toggle vertical terminal |
| `<C-\>` | Toggle terminal |
| `<C-x>` | Exit terminal mode |

---

## Search and Replace

| Key | Action |
|-----|--------|
| `/pattern` | Search forward |
| `?pattern` | Search backward |
| `n` | Next search result |
| `N` | Previous search result |
| `*` | Search word under cursor |
| `<Esc>` | Clear search highlight |
| `:%s/old/new/g` | Replace in file |
| `:%s/old/new/gc` | Replace with confirm |

---

## Completion (Insert Mode)

| Key | Action |
|-----|--------|
| `<C-Space>` | Trigger completion |
| `<Tab>` | Next completion item |
| `<S-Tab>` | Previous completion item |
| `<CR>` | Confirm selection |
| `<C-e>` | Abort completion |
| `<C-n>` | Next item |
| `<C-p>` | Previous item |

---

## Treesitter Text Objects

| Key | Action |
|-----|--------|
| `af` | Around function |
| `if` | Inside function |
| `ac` | Around class |
| `ic` | Inside class |
| `]m` | Next function start |
| `[m` | Previous function start |

---

## Diagnostics and Errors

| Key | Action |
|-----|--------|
| `<leader>xx` | Toggle Trouble diagnostics |
| `<leader>xw` | Workspace diagnostics |
| `<leader>xd` | Document diagnostics |
| `[d` | Previous diagnostic |
| `]d` | Next diagnostic |

---

## Miscellaneous

| Key | Action |
|-----|--------|
| `<C-s>` | Save file |
| `<leader>q` | Quit |
| `<leader>Q` | Quit all (force) |
| `<leader>w` | Quick save |
| `<leader>h` | Clear search highlight |
| `<leader>z` | Zen mode (focus) |
| `:Mason` | LSP package manager |
| `:Lazy` | Plugin manager |
| `:checkhealth` | Check Neovim health |

---

## Tips

### Discovering Commands
- Press `<Space>` and wait - Which-Key will show available commands
- Type `<Space>f` to see all find commands
- Type `<Space>g` to see all git commands
- Type `<Space>d` to see all debug commands

### Custom Keybindings
Add your own in `nvim/lua/core/keymaps.lua`:
```lua
vim.keymap.set("n", "<leader>x", ":YourCommand<CR>", { desc = "Description" })
```

### Vim Motions Practice
- `vimtutor` - Built-in Vim tutorial
- Practice with: `d2w` (delete 2 words), `c3j` (change 3 lines down)
- Combine operators with motions: `{operator}{count}{motion}`

---

**Pro Tip**: Don't try to memorize everything! Use `<Space>` to discover commands as you need them. Muscle memory will build naturally.
