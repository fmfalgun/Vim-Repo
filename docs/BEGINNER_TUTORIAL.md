# 🚀 Beginner Tutorial

**Welcome to Neovim!** This tutorial will get you productive in 5 minutes.

---

## 📝 Lesson 1: Opening and Exiting (2 minutes)

### Starting Neovim
```bash
# Open Neovim
nvim

# Open a specific file
nvim myfile.txt

# Open at specific line
nvim +42 myfile.txt
```

### Exiting Neovim
| Command | What it does |
|---------|--------------|
| `:q` | Quit (fails if unsaved changes) |
| `:q!` | Quit without saving (discard changes) |
| `:w` | Write (save) file |
| `:wq` | Write and quit |
| `ZZ` | Save and quit (shortcut) |

**Try it**: Open Neovim with `nvim`, then type `:q` and press Enter to quit.

---

## 🎯 Lesson 2: Modes (3 minutes)

Neovim has different modes for different tasks:

### Normal Mode (Default)
- For navigation and commands
- Press `Esc` to return to Normal mode
- This is where you spend most of your time

### Insert Mode
- For typing text
- Enter with: `i` (insert), `a` (append), `o` (new line)
- Exit with: `Esc` or `jk` or `kj`

### Visual Mode
- For selecting text
- Enter with: `v` (character), `V` (line), `Ctrl-v` (block)
- Then use movement keys to select

### Command Mode
- For running commands
- Enter with: `:` in Normal mode
- Example: `:w` to save

**Try it**:
1. Open `nvim test.txt`
2. Press `i` to enter Insert mode
3. Type "Hello, Neovim!"
4. Press `Esc` to return to Normal mode
5. Type `:wq` to save and quit

---

## 🧭 Lesson 3: Basic Navigation (5 minutes)

### Movement Keys
```
     k (up)
     ↑
h ← → l (left/right)
     ↓
    j (down)
```

**Why not arrow keys?** You can use them, but `hjkl` keeps your hands on the home row!

### Faster Movement
| Key | Action |
|-----|--------|
| `w` | Next word |
| `b` | Previous word |
| `0` | Start of line |
| `$` | End of line |
| `gg` | Top of file |
| `G` | Bottom of file |

**Try it**:
1. Open a file with multiple lines
2. Practice moving with `h`, `j`, `k`, `l`
3. Try `w` and `b` to jump by words
4. Press `gg` then `G` to jump to top/bottom

---

## ✏️ Lesson 4: Basic Editing (5 minutes)

### Entering Insert Mode
| Key | Action |
|-----|--------|
| `i` | Insert before cursor |
| `a` | Insert after cursor |
| `o` | New line below |
| `O` | New line above |

### Deleting Text
| Key | Action |
|-----|--------|
| `x` | Delete character |
| `dd` | Delete line |
| `dw` | Delete word |
| `d$` | Delete to end of line |

### Undo/Redo
| Key | Action |
|-----|--------|
| `u` | Undo |
| `Ctrl-r` | Redo |

**Try it**:
1. Open `nvim practice.txt`
2. Press `i` and type a sentence
3. Press `Esc`
4. Press `dd` to delete the line
5. Press `u` to undo

---

## 📁 Lesson 5: File Explorer (3 minutes)

### Opening File Explorer
- Press `Space` then `e` (or `Ctrl-n`)
- A file tree appears on the left

### Navigating Files
| Key | Action |
|-----|--------|
| `j/k` | Move up/down |
| `Enter` | Open file/folder |
| `Space` | Expand/collapse folder |
| `a` | Create new file |
| `d` | Delete file |
| `r` | Rename file |
| `q` | Close explorer |

**Try it**:
1. Press `Space` + `e`
2. Navigate with `j`/`k`
3. Press `Enter` on a file to open it
4. Press `q` to close

---

## 🔍 Lesson 6: Finding Files (3 minutes)

### Fuzzy File Finder
- Press `Space` + `f` + `f` (find files)
- Start typing the filename
- Use `↑`/`↓` or `Ctrl-j`/`Ctrl-k` to navigate
- Press `Enter` to open

### Find in Files (Grep)
- Press `Space` + `f` + `g`
- Type your search term
- Navigate and open results

**Try it**:
1. Press `Space ff`
2. Type part of a filename
3. See results filter in real-time
4. Press `Enter` to open

---

## 💡 Lesson 7: The Leader Key (2 minutes)

The **Leader key** is `Space`. It unlocks hundreds of commands!

### Discovery Mode
1. Press `Space`
2. Wait 1 second
3. A menu appears showing all available commands!

### Common Commands
| Keys | Action |
|------|--------|
| `Space ff` | Find files |
| `Space fg` | Find in files (grep) |
| `Space e` | File explorer |
| `Space w` | Save file |
| `Space q` | Quit |

**Try it**:
- Press `Space` and wait
- Explore the menu that appears
- Try pressing `Space f` to see all "find" commands

---

## 📝 Lesson 8: Editing Code (5 minutes)

### Writing Your First Program

**Python Example**:
1. Open: `nvim hello.py`
2. Press `i` to enter Insert mode
3. Type:
```python
def greet(name):
    print(f"Hello, {name}!")

greet("World")
```
4. Press `Esc`
5. Type `:w` to save

### Auto-completion
As you type, suggestions appear automatically!

- `Tab` or `Ctrl-n`: Next suggestion
- `Shift-Tab` or `Ctrl-p`: Previous suggestion
- `Enter`: Accept suggestion
- `Ctrl-e`: Close suggestions

**Try it**:
1. Start typing `pri` in a Python file
2. See `print` appear in suggestions
3. Press `Tab` then `Enter` to accept

---

## 🐛 Lesson 9: Your First Debug Session (5 minutes)

### Setting up Debugging

**Python Example**:
1. Open: `nvim debug_test.py`
2. Write a simple script:
```python
def add(a, b):
    result = a + b
    return result

answer = add(5, 3)
print(answer)
```
3. Place cursor on line 2 (`result = a + b`)
4. Press `F9` to set a breakpoint (you'll see a red dot)
5. Press `F5` to start debugging

### Debug Controls
| Key | Action |
|-----|--------|
| `F5` | Continue/Start |
| `F9` | Toggle breakpoint |
| `F10` | Step over |
| `F11` | Step into |
| `K` | Hover to inspect variables |

The debug UI will open showing:
- **Variables**: Current values
- **Stack**: Call stack
- **Watches**: Custom expressions
- **Console**: Output

**Try it**: Follow the example above and step through the code!

---

## 🎓 Lesson 10: Getting Help (2 minutes)

### Built-in Help
| Command | What it does |
|---------|--------------|
| `:help {topic}` | Open help for topic |
| `:checkhealth` | Check system health |
| `:Tutor` | Vim tutor (built-in tutorial) |

### Configuration Help
- Press `Space` and wait to see all commands
- `:Mason` - Install language servers
- `:Lazy` - Manage plugins

### This Configuration's Help
- `docs/KEYBINDINGS.md` - All shortcuts
- `docs/INSTALLATION.md` - Setup help
- `docs/languages/` - Language-specific guides

**Try it**: Type `:help navigation` and press Enter

---

## 🚀 Next Steps

### Practice These Core Skills
1. ✅ Move without arrow keys (`hjkl`, `w`, `b`, `gg`, `G`)
2. ✅ Switch between modes (`Esc`, `i`, `v`)
3. ✅ Save and quit (`:w`, `:q`, `:wq`)
4. ✅ Use the file explorer (`Space e`)
5. ✅ Find files (`Space ff`)

### Learn More
- 📖 Read [KEYBINDINGS.md](KEYBINDINGS.md) for all shortcuts
- 🎯 Check language-specific guides in `docs/languages/`
- 💻 Practice with real projects!

### Vim Tutor (Recommended!)
```bash
# Run the built-in Vim tutorial
:Tutor
```

---

## 🎯 Quick Reference Card

### Essential Commands
```
Modes:
  Esc     - Normal mode
  i       - Insert mode
  v       - Visual mode
  :       - Command mode

Movement:
  hjkl    - Left/Down/Up/Right
  w/b     - Word forward/backward
  gg/G    - Top/Bottom of file

Editing:
  dd      - Delete line
  yy      - Copy line
  p       - Paste
  u       - Undo
  Ctrl-r  - Redo

Files:
  :w      - Save
  :q      - Quit
  :wq     - Save and quit
  Space e - File explorer
  Space ff - Find files

Code:
  gd      - Go to definition
  K       - Show documentation
  Space ca - Code actions
  Space rn - Rename

Debug:
  F9      - Breakpoint
  F5      - Start/Continue
  F10     - Step over
```

---

## 💪 Challenge Yourself!

### Day 1: Basic Editing
- Create a new file
- Write 10 lines of text
- Practice deleting, copying, and pasting lines
- Save and quit without using the mouse

### Day 2: Navigation
- Open a large file
- Jump to the top and bottom
- Navigate by words
- Search for text with `/`

### Day 3: Code Editing
- Write a simple program in your favorite language
- Use auto-completion
- Navigate to function definitions with `gd`
- Format code with `Space cf`

### Day 4: Debugging
- Set breakpoints with `F9`
- Start debugging with `F5`
- Inspect variables
- Step through code

### Week 2: Build Your Workflow
- Customize keybindings in `nvim/lua/core/keymaps.lua`
- Explore plugins with `:Lazy`
- Install language servers with `:Mason`
- Read language-specific guides

---

## ❤️ Remember

**Don't get overwhelmed!**

- Vim/Neovim has a learning curve, but it's worth it
- Learn a little each day
- Use `Space` to discover commands
- The more you use it, the more natural it becomes

**You've got this!** 🚀

---

## 🆘 Stuck?

1. **Press `Space`** - See available commands
2. **Type `:help`** - Built-in help system
3. **Check `:checkhealth`** - Diagnose issues
4. **Read the docs** - `docs/` folder has everything

Welcome to the Neovim family! 🎉
