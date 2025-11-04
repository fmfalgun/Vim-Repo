# 🤖 AI Coding Assistants

> **Transform your Neovim into an AI-powered development environment**

This guide covers setting up and using AI coding assistants in Neovim, including both free and paid options.

---

## 📋 Table of Contents

- [Overview](#overview)
- [Quick Start](#quick-start)
- [Available AI Assistants](#available-ai-assistants)
  - [Codeium (Free)](#1-codeium-free)
  - [Ollama + Local Models (Free)](#2-ollama--local-models-free)
  - [GitHub Copilot (Paid)](#3-github-copilot-paid)
  - [Avante.nvim (Multiple Backends)](#4-avantenvim-multiple-backends)
- [Setup Instructions](#setup-instructions)
- [Usage Guide](#usage-guide)
- [Comparison](#comparison)
- [Troubleshooting](#troubleshooting)

---

## Overview

AI coding assistants help you write code faster by:
- **Auto-completing code** as you type
- **Suggesting entire functions** based on comments
- **Explaining code** you don't understand
- **Reviewing and improving** your code
- **Generating code** from natural language descriptions

---

## Quick Start

### Automatic Setup (Recommended)

Run the interactive setup script:

```bash
cd ~/Vim-Repo
./scripts/setup-ai-assistant.sh
```

The script will:
1. Show you all available options
2. Explain pros/cons of each
3. Guide you through installation
4. Configure everything automatically

### Manual Setup

If you prefer manual setup, see the [Setup Instructions](#setup-instructions) below.

---

## Available AI Assistants

### 1. Codeium (Free) ⭐⭐⭐

**Best for:** Most users, everyday coding

#### Features
- ✅ **Completely free** forever
- ✅ Similar to GitHub Copilot
- ✅ Fast and reliable
- ✅ Supports 70+ programming languages
- ✅ Inline code suggestions
- ✅ Multi-line completions
- ❌ Requires internet connection
- ❌ Code is sent to cloud

#### How It Works
Codeium provides AI-powered code completion as you type. It suggests entire lines or blocks of code based on your context.

#### Setup
```bash
# 1. Run setup script
./scripts/setup-ai-assistant.sh
# Choose option 1

# 2. Restart Neovim
nvim

# 3. Authenticate
:Codeium Auth

# 4. Sign up at https://codeium.com (free)
# 5. Copy API key and paste in Neovim
```

#### Keybindings
| Key | Action |
|-----|--------|
| `<C-g>` | Accept suggestion |
| `<C-]>` | Next suggestion |
| `<C-[>` | Previous suggestion |
| `<C-x>` | Dismiss suggestion |

#### Example Usage
```python
# Type a comment and press Enter
def calculate_fibonacci(n):
    # Generate fibonacci sequence up to n
    # Codeium will suggest the entire function!
```

---

### 2. Ollama + Local Models (Free) ⭐⭐⭐

**Best for:** Privacy-conscious users, offline work

#### Features
- ✅ **100% local and private**
- ✅ No internet required (after setup)
- ✅ Your code never leaves your machine
- ✅ Multiple models available
- ✅ Chat interface + code completion
- ❌ Requires good hardware (8GB+ RAM)
- ❌ Slower than cloud solutions
- ❌ Large downloads (4-7GB per model)

#### Available Models

| Model | Size | Speed | Quality | Best For |
|-------|------|-------|---------|----------|
| **CodeLlama 7B** | 4GB | Fast | Good | General coding |
| **DeepSeek-Coder 6.7B** | 4GB | Medium | Excellent | Complex code |
| **Qwen2.5-Coder 7B** | 4GB | Medium | Very Good | Balanced use |
| **CodeGemma 7B** | 5GB | Medium | Good | Google ecosystem |

#### Setup
```bash
# 1. Run setup script
./scripts/setup-ai-assistant.sh
# Choose option 2

# 2. Script will:
#    - Install Ollama
#    - Download your chosen model
#    - Configure Neovim
#    - Set up keybindings

# 3. Restart Neovim
nvim
```

#### Keybindings
| Key | Action | Mode |
|-----|--------|------|
| `<leader>ai` | Open AI menu | Normal/Visual |
| `<leader>ac` | Chat with AI | Visual |
| `<leader>ag` | Generate code | Visual |
| `<leader>ae` | Enhance code | Visual |
| `<leader>ar` | Review code | Visual |
| `<leader>ax` | Explain code | Visual |
| `<leader>af` | Fix code | Visual |

#### Example Usage

**Generate Code:**
```
1. Type your requirement in a comment
2. Select the comment (Visual mode)
3. Press <leader>ag
4. AI will generate the code
```

**Review Code:**
```
1. Select your code (Visual mode)
2. Press <leader>ar
3. AI will provide review and suggestions
```

**Chat with AI:**
```
1. Select code you want to ask about
2. Press <leader>ac
3. Type your question
4. AI responds in a split window
```

---

### 3. GitHub Copilot (Paid)

**Best for:** Users with GitHub subscription

#### Features
- ✅ Best-in-class code completion
- ✅ Very fast and accurate
- ✅ Trained on massive codebase
- ✅ Multi-line completions
- ❌ **$10/month** (free for students/teachers)
- ❌ Code sent to GitHub servers

#### Setup
```bash
# 1. Subscribe at https://github.com/features/copilot
#    (Free for students and teachers)

# 2. Run setup script
./scripts/setup-ai-assistant.sh
# Choose option 4

# 3. Restart Neovim and authenticate
nvim
:Copilot setup

# 4. Follow authentication steps
```

#### Keybindings
| Key | Action |
|-----|--------|
| `<C-J>` | Accept suggestion |
| `<C-]>` | Next suggestion |
| `<C-[>` | Previous suggestion |
| `<M-]>` | Accept next word |
| `<M-\>` | Trigger Copilot |

#### Commands
```vim
:Copilot enable    " Enable Copilot
:Copilot disable   " Disable Copilot
:Copilot status    " Check status
:Copilot signout   " Sign out
```

---

### 4. Avante.nvim (Multiple Backends)

**Best for:** Advanced users who want flexibility

#### Features
- ✅ Chat interface for AI
- ✅ Supports multiple backends (Claude, GPT, Ollama, Gemini)
- ✅ Code diff view for suggestions
- ✅ Context-aware conversations
- ✅/❌ Free if using Ollama, paid for cloud APIs

#### Supported Backends

| Backend | Cost | Quality | Speed |
|---------|------|---------|-------|
| **Ollama** (local) | Free | Good | Medium |
| **Claude** (Anthropic) | Pay-per-use | Excellent | Fast |
| **ChatGPT** (OpenAI) | Pay-per-use | Excellent | Fast |
| **Gemini** (Google) | Pay-per-use | Very Good | Fast |

#### Setup for Ollama (Free)
```bash
# 1. Install Ollama
curl -fsSL https://ollama.com/install.sh | sh

# 2. Pull a model
ollama pull codellama:7b

# 3. Enable in Neovim config
# Edit: ~/.config/nvim/lua/plugins/ai/init.lua
# Uncomment: require("plugins.ai.avante")

# 4. Restart Neovim
```

#### Setup for Paid APIs
```bash
# Add to ~/.bashrc or ~/.zshrc:
export ANTHROPIC_API_KEY="your-claude-key"
export OPENAI_API_KEY="your-openai-key"
export GOOGLE_API_KEY="your-gemini-key"

# Then edit: ~/.config/nvim/lua/plugins/ai/avante.lua
# Change provider = "ollama" to your chosen provider
```

#### Keybindings
| Key | Action |
|-----|--------|
| `<leader>aa` | Ask AI |
| `<leader>ar` | Refresh suggestions |
| `<leader>ae` | Edit with AI |

#### Commands
```vim
:AvanteAsk         " Ask a question
:AvanteChat        " Open chat window
:AvanteEdit        " Edit with AI
:AvanteRefresh     " Refresh suggestions

" Switch providers
:AvanteUseOllama   " Use local Ollama
:AvanteUseClaude   " Use Claude API
:AvanteUseOpenAI   " Use ChatGPT API
:AvanteUseGemini   " Use Gemini API
```

---

## Setup Instructions

### Step 1: Run Setup Script

```bash
cd ~/Vim-Repo
./scripts/setup-ai-assistant.sh
```

### Step 2: Enable AI Plugin

Edit `~/.config/nvim/lua/plugins/ai/init.lua`:

```lua
-- Uncomment the AI assistant you want to use:

-- Option 1: Codeium (Free, Cloud)
require("plugins.ai.codeium")

-- Option 2: Ollama (Free, Local)
-- require("plugins.ai.ollama")

-- Option 3: GitHub Copilot (Paid)
-- require("plugins.ai.copilot")

-- Option 4: Avante.nvim (Multiple backends)
-- require("plugins.ai.avante")
```

### Step 3: Load AI Plugins in Main Config

Edit `~/.config/nvim/lua/plugins/init.lua` and add at the end, before the closing `})`:

```lua
  -- ============================================================================
  -- AI CODING ASSISTANTS
  -- ============================================================================
  -- Load AI assistant configurations
  require("plugins.ai.init"),
```

### Step 4: Restart Neovim

```bash
nvim
```

Plugins will auto-install on first launch.

---

## Usage Guide

### Using Code Completion (Codeium/Copilot)

1. **Start typing** your code
2. **Wait for suggestion** (appears in gray text)
3. **Accept with keybinding** (see each tool's keybindings above)
4. **Continue coding** - AI learns from your style

**Tips:**
- Write descriptive comments for better suggestions
- Accept suggestions with Tab or Ctrl+J
- Dismiss bad suggestions quickly
- AI learns from your coding patterns

### Using Chat-Based AI (Ollama/Avante)

1. **Select code** you want to work with (Visual mode)
2. **Press keybinding** for desired action:
   - `<leader>ag` to generate
   - `<leader>ae` to enhance
   - `<leader>ar` to review
   - `<leader>ac` to chat
3. **Read AI response** in split window
4. **Apply changes** if satisfied

**Tips:**
- Be specific in your requests
- Select relevant code context
- Review AI suggestions carefully
- Use chat for complex questions

---

## Comparison

### Which AI Assistant Should You Choose?

| Use Case | Recommendation |
|----------|----------------|
| **Just starting out** | Codeium (easiest setup) |
| **Privacy matters** | Ollama + Local Models |
| **Best quality** | GitHub Copilot (paid) |
| **Flexibility** | Both Codeium + Ollama |
| **Chat interface** | Avante.nvim + Ollama |
| **No internet** | Ollama (works offline) |
| **Low-end hardware** | Codeium (runs in cloud) |

### Feature Comparison

| Feature | Codeium | Ollama | Copilot | Avante |
|---------|---------|--------|---------|--------|
| **Cost** | Free | Free | $10/mo | Free/Paid |
| **Speed** | Fast | Medium | Very Fast | Medium |
| **Quality** | Very Good | Good | Excellent | Varies |
| **Privacy** | Cloud | Local | Cloud | Varies |
| **Offline** | ❌ | ✅ | ❌ | ✅ (Ollama) |
| **Chat** | ❌ | ✅ | ❌ | ✅ |
| **Completion** | ✅ | ⚠️ | ✅ | ⚠️ |

---

## Troubleshooting

### Codeium Issues

**Suggestions not appearing:**
```vim
:Codeium Auth        " Re-authenticate
:Lazy reload codeium.nvim
```

**API key invalid:**
1. Sign out from https://codeium.com
2. Sign in again
3. Get new API key
4. Run `:Codeium Auth` again

### Ollama Issues

**Ollama not running:**
```bash
# Check if Ollama is running
systemctl status ollama

# Start Ollama
systemctl start ollama

# Or run manually
ollama serve
```

**Model not found:**
```bash
# List installed models
ollama list

# Pull the model
ollama pull codellama:7b
```

**Out of memory:**
- Use smaller models (3B or 1B versions)
- Close other applications
- Upgrade RAM

**Slow responses:**
- Use faster model (CodeLlama instead of DeepSeek)
- Check GPU is being used (if available)
- Reduce model size

### GitHub Copilot Issues

**Authentication failed:**
```vim
:Copilot signout
:Copilot setup
" Follow new authentication flow
```

**Not suggesting:**
```vim
:Copilot status      " Check status
:Copilot enable      " Enable if disabled
```

### General Issues

**Plugins not loading:**
```vim
:Lazy sync           " Sync plugins
:Lazy clean          " Clean old plugins
:Lazy update         " Update all plugins
```

**Conflicts with existing completion:**
```lua
-- Edit completion settings in:
-- ~/.config/nvim/lua/plugins/completion.lua
-- Adjust priorities of completion sources
```

---

## Advanced Configuration

### Combining Multiple AI Assistants

You can use multiple AI assistants together:

```lua
-- In ~/.config/nvim/lua/plugins/ai/init.lua

-- Use Codeium for fast completion
require("plugins.ai.codeium")

-- AND Ollama for private chat
require("plugins.ai.ollama")
```

**Benefits:**
- Fast cloud completion (Codeium)
- Private local chat (Ollama)
- Best of both worlds

**Keybindings won't conflict:**
- Codeium: Auto-completion while typing
- Ollama: Manual activation with `<leader>a*`

### Customizing Prompts

Edit `~/.config/nvim/lua/plugins/ai/ollama.lua` to customize AI prompts:

```lua
-- Add custom prompts
gen.prompts["Document_Code"] = {
  prompt = "Add comprehensive documentation to:\n```$filetype\n$text\n```"
}

gen.prompts["Optimize_Code"] = {
  prompt = "Optimize the following code for performance:\n```$filetype\n$text\n```"
}
```

### Switching Models

For Ollama, you can use different models for different tasks:

```bash
# Download multiple models
ollama pull codellama:7b        # Fast completion
ollama pull deepseek-coder:6.7b # Better quality
ollama pull codellama:13b       # Best quality (if you have RAM)
```

Then switch in config:
```lua
-- ~/.config/nvim/lua/plugins/ai/ollama.lua
model = "deepseek-coder:6.7b"  -- Change this line
```

---

## Best Practices

### 1. Start with Codeium
- Easiest to set up
- No hardware requirements
- Learn how AI assistance works

### 2. Add Ollama for Privacy
- Once comfortable with AI
- If you have good hardware
- For sensitive code

### 3. Review AI Suggestions
- Don't blindly accept everything
- Understand what code does
- Learn from AI patterns

### 4. Use Appropriate Tools
- **Completion** (Codeium/Copilot): Routine coding
- **Chat** (Ollama): Complex questions
- **Review** (Ollama): Code quality checks

### 5. Maintain Security
- Don't share API keys
- Review code before committing
- Use local AI for sensitive projects

---

## Resources

### Documentation
- [Codeium Docs](https://codeium.com/docs)
- [Ollama Docs](https://ollama.com/docs)
- [GitHub Copilot Docs](https://docs.github.com/copilot)
- [Avante.nvim](https://github.com/yetone/avante.nvim)

### Model Information
- [Ollama Models](https://ollama.com/library)
- [CodeLlama](https://ollama.com/library/codellama)
- [DeepSeek Coder](https://ollama.com/library/deepseek-coder)
- [Qwen Coder](https://ollama.com/library/qwen2.5-coder)

### Community
- [Neovim Discord](https://discord.gg/neovim)
- [r/neovim](https://reddit.com/r/neovim)

---

## FAQ

**Q: Can I use multiple AI assistants at once?**
A: Yes! Codeium + Ollama works great together.

**Q: Which is better, Codeium or Copilot?**
A: Copilot has slightly better quality, but Codeium is free and very close in performance.

**Q: Is my code sent to AI servers?**
A: Codeium and Copilot: Yes. Ollama: No (100% local).

**Q: How much RAM do I need for Ollama?**
A: Minimum 8GB, recommended 16GB+ for best performance.

**Q: Can I use AI offline?**
A: Only Ollama works offline (after initial model download).

**Q: Are these AI assistants free forever?**
A: Codeium: Yes. Ollama: Yes. Copilot: No ($10/month).

**Q: Will AI replace programmers?**
A: No. AI is a tool to make you more productive, not a replacement.

---

## Summary

1. **Run setup script**: `./scripts/setup-ai-assistant.sh`
2. **Choose your AI**: Codeium (easy) or Ollama (private)
3. **Enable in config**: Edit `~/.config/nvim/lua/plugins/ai/init.lua`
4. **Restart Neovim**: Let plugins install
5. **Start coding**: Enjoy AI-powered development!

---

**Happy Coding with AI! 🚀**

*Remember: AI is a tool to help you code faster, but understanding what you're writing is still essential!*
