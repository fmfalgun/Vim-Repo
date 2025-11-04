--[[
================================================================================
  AI CODING ASSISTANTS
================================================================================
  Configuration for AI-powered code completion and generation

  SETUP INSTRUCTIONS:
  1. Run: ./scripts/setup-ai-assistant.sh
  2. Follow the interactive setup
  3. Restart Neovim

  AVAILABLE OPTIONS:
  - Codeium: Free cloud-based completion (recommended for most users)
  - Ollama: Free local AI models (recommended for privacy)
  - GitHub Copilot: Paid subscription required

  To enable an AI assistant, uncomment the corresponding require() line below
================================================================================
--]]

-- ============================================================================
-- AI ASSISTANT SELECTION
-- ============================================================================
-- Uncomment ONE or MORE of the following lines to enable AI assistants:

-- Option 1: Codeium (Free, Cloud) - Recommended for beginners
-- require("plugins.ai.codeium")

-- Option 2: Ollama + Local Models (Free, Local) - Recommended for privacy
-- require("plugins.ai.ollama")

-- Option 3: GitHub Copilot (Paid) - Requires subscription
-- require("plugins.ai.copilot")

-- Option 4: Avante.nvim (Chat interface with multiple backends)
-- require("plugins.ai.avante")

-- ============================================================================
-- NOTE:
-- If you haven't set up an AI assistant yet, run:
--   ./scripts/setup-ai-assistant.sh
-- ============================================================================

return {}
