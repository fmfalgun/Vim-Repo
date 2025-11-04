--[[
================================================================================
  OLLAMA + GEN.NVIM CONFIGURATION
================================================================================
  Local AI models for code generation and chat

  FEATURES:
  - 100% local and private
  - No internet required (after setup)
  - Multiple models available (CodeLlama, DeepSeek, Qwen)
  - Chat interface for code questions
  - Code generation and enhancement

  REQUIREMENTS:
  - Ollama installed (https://ollama.com)
  - At least 8GB RAM
  - Downloaded AI model (run: ollama pull codellama:7b)

  SETUP:
  1. Install Ollama: curl -fsSL https://ollama.com/install.sh | sh
  2. Download a model: ollama pull codellama:7b
  3. Restart Neovim

  KEYBINDINGS:
  - <leader>ai  Open AI menu (normal/visual)
  - <leader>ac  Chat with AI (visual mode)
  - <leader>ag  Generate code (visual mode)
  - <leader>ae  Enhance code (visual mode)
  - <leader>ar  Review code (visual mode)
  - <leader>ax  Explain code (visual mode)

  AVAILABLE MODELS:
  - codellama:7b       Fast, good for code (4GB)
  - deepseek-coder     Best coding model (4GB)
  - qwen2.5-coder      Balanced quality (4GB)
  - codegemma:7b       Google's model (5GB)
================================================================================
--]]

return {
  "David-Kunz/gen.nvim",
  cmd = "Gen",
  keys = {
    { "<leader>ai", ":Gen<CR>", mode = { "n", "v" }, desc = "AI Menu" },
    { "<leader>ac", ":Gen Chat<CR>", mode = "v", desc = "AI Chat" },
    { "<leader>ag", ":Gen Generate<CR>", mode = "v", desc = "AI Generate Code" },
    { "<leader>ae", ":Gen Enhance_Code<CR>", mode = "v", desc = "AI Enhance Code" },
    { "<leader>ar", ":Gen Review_Code<CR>", mode = "v", desc = "AI Review Code" },
    { "<leader>ax", ":Gen Explain_Code<CR>", mode = "v", desc = "AI Explain Code" },
  },
  config = function()
    local gen = require("gen")

    gen.setup({
      model = "codellama:7b", -- Change this to your preferred model
      host = "localhost",
      port = "11434",
      display_mode = "split", -- split, float, horizontal
      show_prompt = true,
      show_model = true,
      no_auto_close = false,
      init = function(options)
        -- Start ollama serve if not running
        pcall(io.popen, "ollama serve > /dev/null 2>&1 &")
      end,
      command = function(options)
        local body = {
          model = options.model,
          stream = true,
        }
        return "curl --silent --no-buffer -X POST http://"
          .. options.host
          .. ":"
          .. options.port
          .. "/api/chat -d $body"
      end,
      debug = false,
    })

    -- Custom prompts
    gen.prompts["Elaborate_Text"] = { prompt = "Elaborate the following text:\n$text" }
    gen.prompts["Fix_Code"] = { prompt = "Fix the following code. Only ouput the result in format ```$filetype\n...\n```:\n```$filetype\n$text\n```" }
    gen.prompts["Explain_Code"] = { prompt = "Explain the following code:\n```$filetype\n$text\n```" }
    gen.prompts["Review_Code"] = { prompt = "Review the following code and make concise suggestions:\n```$filetype\n$text\n```" }
    gen.prompts["Enhance_Code"] = { prompt = "Enhance the following code, add comments and improve readability:\n```$filetype\n$text\n```" }
    gen.prompts["Change_Code"] = { prompt = "Regarding the following code, $input:\n```$filetype\n$text\n```" }
    gen.prompts["Generate"] = { prompt = "Generate code for the following:\n$input" }
    gen.prompts["Chat"] = { prompt = "$input" }
    gen.prompts["Ask"] = { prompt = "Regarding the following text, $input:\n$text" }

    -- Add to which-key menu
    local wk_ok, wk = pcall(require, "which-key")
    if wk_ok then
      wk.register({
        ["<leader>a"] = {
          name = "AI Assistant",
          i = { "<cmd>Gen<CR>", "Interactive Menu" },
          c = { "<cmd>Gen Chat<CR>", "Chat", mode = { "n", "v" } },
          g = { "<cmd>Gen Generate<CR>", "Generate Code", mode = { "n", "v" } },
          e = { "<cmd>Gen Enhance_Code<CR>", "Enhance Code", mode = { "n", "v" } },
          r = { "<cmd>Gen Review_Code<CR>", "Review Code", mode = { "n", "v" } },
          x = { "<cmd>Gen Explain_Code<CR>", "Explain Code", mode = { "n", "v" } },
          f = { "<cmd>Gen Fix_Code<CR>", "Fix Code", mode = { "n", "v" } },
        },
      })
    end
  end,
}
