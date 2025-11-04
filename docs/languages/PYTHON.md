# 🐍 Python Development Guide

Complete guide for Python development with debugging and virtual environments.

---

## Setup

### Language Server
**pyright** is automatically installed via Mason.

### Debugger
**debugpy** via Mason (automatic).

### Python Installation
```bash
# Debian/Ubuntu
sudo apt-get install python3 python3-pip python3-venv

# Arch
sudo pacman -S python python-pip
```

---

## Features

### Auto-completion
- Intelligent suggestions as you type
- Works with imports, functions, methods
- Type hints improve suggestions

### Type Checking
- Pyright provides static type checking
- Add type hints for better suggestions:
```python
def greet(name: str) -> str:
    return f"Hello, {name}!"
```

### Import Management
- Auto-import suggestions
- Organize imports: `Space ca` → "Organize Imports"

---

## Virtual Environments

### Creating Virtual Environment
```bash
# Create venv
python3 -m venv .venv

# Activate
source .venv/bin/activate  # Linux/Mac
```

### Auto-detection
Neovim automatically detects `.venv` folders!

### Manual Selection
```vim
:VenvSelect
```

### Per-project Setup
```bash
cd my_project
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
nvim .
```

---

## Debugging

### Quick Start
1. Open Python file: `nvim script.py`
2. Set breakpoint: `F9`
3. Press `F5` to start debugging
4. Debug UI opens automatically

### Debug Controls
| Key | Action |
|-----|--------|
| `F5` | Continue/Start |
| `F9` | Toggle breakpoint |
| `F10` | Step over |
| `F11` | Step into |
| `F12` | Step out |
| `K` | Inspect variable (in debug mode) |

### Example Debug Session

**script.py**:
```python
def calculate_sum(numbers):
    total = 0
    for num in numbers:
        total += num  # Set breakpoint here (F9)
    return total

result = calculate_sum([1, 2, 3, 4, 5])
print(f"Sum: {result}")
```

1. Open file: `nvim script.py`
2. Place cursor on line 4
3. Press `F9` (breakpoint appears)
4. Press `F5` (debugging starts)
5. Variables panel shows `num`, `total`
6. Press `F10` to step through loop
7. Hover over variables to inspect

### Debug with Arguments
Press `F5` → Select "Launch file with arguments"

### Remote Debugging
```python
# In your code
import debugpy
debugpy.listen(5678)
debugpy.wait_for_client()
```

Then in Neovim:
```vim
:lua require('dap').continue()
" Select "Attach remote"
" Host: 127.0.0.1
" Port: 5678
```

---

## Code Actions

### Available Actions
- `Space ca`: Show code actions
  - Add import
  - Organize imports
  - Extract variable
  - Extract function

### Formatting
```vim
# Format current file
Space cf

# Install formatters:
pip install black isort
```

### Linting
Install linters:
```bash
pip install flake8 pylint mypy
```

Configure in Neovim (automatic via LSP).

---

## Testing

### pytest Integration
```bash
# Install pytest
pip install pytest

# Run tests
:!pytest

# Run specific test
:!pytest tests/test_mymodule.py
```

### Test Discovery
```vim
# Find test files
Space ff
" Type: test_
```

---

## Django Development

### Setup
```bash
pip install django
django-admin startproject mysite
cd mysite
nvim .
```

### Features
- Template syntax highlighting
- Model completion
- URL pattern completion

### Running Server
```vim
:TermExec cmd="python manage.py runserver"
```

---

## Common Workflows

### Starting a New Project
```bash
mkdir my_project
cd my_project
python3 -m venv .venv
source .venv/bin/activate
pip install package-name
pip freeze > requirements.txt
nvim main.py
```

### Data Science Setup
```bash
pip install numpy pandas matplotlib jupyter
nvim analysis.py
```

LSP provides:
- NumPy array method completion
- Pandas DataFrame suggestions
- Type information

---

## Troubleshooting

### LSP Not Working
```vim
:LspInfo
:Mason
" Ensure pyright is installed
```

### Wrong Python Version
```vim
:VenvSelect
" Select correct environment
```

### Import Not Found
```bash
# Ensure package is installed in active venv
pip list
pip install missing-package
```

### Debugger Not Starting
- Check Python path in debug config
- Ensure debugpy is installed:
```bash
pip install debugpy
```

---

## Pro Tips

### 1. Use Type Hints
```python
from typing import List, Dict, Optional

def process_data(items: List[str]) -> Dict[str, int]:
    return {item: len(item) for item in items}
```
Better completion and type checking!

### 2. Interactive REPL
```vim
# Start Python REPL in terminal
Space tf
# Then in terminal:
python
```

### 3. Quick Script Execution
```vim
:!python %
" Runs current file
```

### 4. Virtual Environment in Status
Status line shows active virtual environment!

---

## Example Full Workflow

### 1. Create Project
```bash
mkdir calculator
cd calculator
python3 -m venv .venv
source .venv/bin/activate
```

### 2. Create File
```bash
nvim calculator.py
```

### 3. Write Code
```python
from typing import List

def add(a: float, b: float) -> float:
    """Add two numbers."""
    return a + b

def multiply_list(numbers: List[float]) -> float:
    """Multiply all numbers in list."""
    result = 1.0
    for num in numbers:
        result *= num
    return result

if __name__ == "__main__":
    print(add(5, 3))
    print(multiply_list([2, 3, 4]))
```

### 4. Debug
1. Set breakpoint in `multiply_list` (F9)
2. Press F5
3. Step through with F10
4. Inspect `result` variable

### 5. Add Tests
```bash
nvim test_calculator.py
```

```python
import pytest
from calculator import add, multiply_list

def test_add():
    assert add(2, 3) == 5

def test_multiply_list():
    assert multiply_list([2, 3]) == 6
```

Run:
```bash
pytest
```

---

## Resources

- [Pyright Documentation](https://github.com/microsoft/pyright)
- [debugpy Documentation](https://github.com/microsoft/debugpy)
- [Python Type Hints](https://docs.python.org/3/library/typing.html)
