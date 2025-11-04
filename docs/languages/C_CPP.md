# 🔧 C/C++ Development Guide

Complete guide for C/C++ development with debugging.

---

## Setup

### Language Server
**clangd** is automatically installed via Mason.

Manual install:
```bash
# Debian/Ubuntu
sudo apt-get install clangd

# Arch
sudo pacman -S clang
```

### Debugger
**codelldb** or **cpptools** via Mason.

Manual install:
```bash
# Debian/Ubuntu
sudo apt-get install lldb gdb

# Arch
sudo pacman -S lldb gdb
```

---

## Features

### Auto-completion
- Type and get intelligent suggestions
- `Tab`: Accept completion
- `Ctrl-Space`: Trigger manually

### Go to Definition
- Place cursor on function/variable
- Press `gd`: Go to definition
- Press `gD`: Go to declaration

### Find References
- Press `gr`: Find all references
- Navigate with `j`/`k`, press `Enter` to jump

### Hover Documentation
- Press `K` over any symbol
- See documentation/signature

---

## Compiling

### Basic Compilation
```bash
# C
gcc -Wall -Wextra -g myprogram.c -o myprogram

# C++
g++ -Wall -Wextra -std=c++17 -g myprogram.cpp -o myprogram

# With debug symbols (-g flag is important!)
```

### Makefiles
Create `Makefile`:
```makefile
CC = gcc
CFLAGS = -Wall -Wextra -g
TARGET = myprogram

all: $(TARGET)

$(TARGET): main.c
\t$(CC) $(CFLAGS) -o $(TARGET) main.c

clean:
\trm -f $(TARGET)
```

Compile:
```bash
make
```

---

## Debugging

### Quick Start
1. Compile with `-g` flag
2. Open file: `nvim main.c`
3. Set breakpoint: `F9`
4. Start debug: `F5`
5. Configure on first run:
   - Select debugger: `codelldb`
   - Enter program path: `./myprogram`

### Debug Controls
| Key | Action |
|-----|--------|
| `F5` | Continue/Start |
| `F9` | Toggle breakpoint |
| `F10` | Step over |
| `F11` | Step into |
| `F12` | Step out |
| `Space du` | Toggle debug UI |

### Debug Configuration
Create `.vscode/launch.json` (optional):
```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "Debug C/C++",
      "type": "codelldb",
      "request": "launch",
      "program": "${workspaceFolder}/myprogram",
      "args": [],
      "cwd": "${workspaceFolder}"
    }
  ]
}
```

### Common Issues

**Breakpoints not hitting?**
- Compile with `-g` flag
- No optimization flags (`-O0` or remove `-O2`)

**Can't find executable?**
- Check path is correct
- Use absolute path: `/path/to/myprogram`

---

## Code Actions

### Format Code
- `Space cf`: Format current file
- Uses clang-format

Create `.clang-format`:
```yaml
BasedOnStyle: LLVM
IndentWidth: 4
ColumnLimit: 100
```

### Refactoring
- `Space rn`: Rename symbol
- `Space ca`: Show code actions

---

## LSP Commands

### In Neovim
```vim
:LspInfo            " Show LSP status
:LspRestart         " Restart LSP server
:Mason              " Install/manage LSP servers
```

---

## Example Workflow

### 1. Create Project
```bash
mkdir my_project
cd my_project
nvim main.c
```

### 2. Write Code
```c
#include <stdio.h>

int add(int a, int b) {
    return a + b;
}

int main() {
    int result = add(5, 3);
    printf("Result: %d\n", result);
    return 0;
}
```

### 3. Compile
```bash
gcc -Wall -g main.c -o myprogram
```

### 4. Debug
1. Open: `nvim main.c`
2. Set breakpoint on line 4 (press `F9`)
3. Press `F5`, select `codelldb`
4. Enter program: `./myprogram`
5. Debug UI opens
6. Press `F10` to step through
7. Hover over variables to inspect

---

## Pro Tips

- **Compile on save**: Use `:!make` or configure autocmd
- **Header/Source switch**: `:e %:r.h` (switch to header)
- **Include path issues**: Create `compile_commands.json`
- **Multi-file projects**: Use CMake or Makefiles

---

## Resources

- [clangd documentation](https://clangd.llvm.org/)
- [GDB Tutorial](https://www.gnu.org/software/gdb/documentation/)
- [LLDB Guide](https://lldb.llvm.org/use/tutorial.html)
