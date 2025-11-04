--[[
================================================================================
  LSP CONFIGURATION
================================================================================
  Language Server Protocol configuration for all supported languages

  Supported Languages:
    - C/C++ (clangd)
    - Python (pyright)
    - C# (omnisharp)
    - JavaScript/TypeScript (ts_ls)
    - Java (jdtls)
    - Go (gopls)
    - HTML/CSS (html, cssls)
    - YAML (yamlls)
    - Docker (dockerls)
    - Bash (bashls)
    - Lua (lua_ls)
    - JSON (jsonls)
    - Rust (rust_analyzer)
================================================================================
--]]

local lspconfig = require("lspconfig")
local mason_lspconfig = require("mason-lspconfig")

-- ============================================================================
-- DIAGNOSTIC CONFIGURATION
-- ============================================================================
vim.diagnostic.config({
  virtual_text = {
    prefix = "●",
    source = "if_many",
  },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
})

-- Diagnostic signs
local signs = {
  { name = "DiagnosticSignError", text = "" },
  { name = "DiagnosticSignWarn", text = "" },
  { name = "DiagnosticSignHint", text = "" },
  { name = "DiagnosticSignInfo", text = "" },
}

for _, sign in ipairs(signs) do
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

-- ============================================================================
-- LSP KEYMAPS (Applied when LSP attaches to buffer)
-- ============================================================================
local on_attach = function(client, bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }

  -- Navigation
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)

  -- Workspace
  vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
  vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
  vim.keymap.set("n", "<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, opts)

  -- Code actions
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
  vim.keymap.set("v", "<leader>ca", vim.lsp.buf.code_action, opts)

  -- Formatting
  vim.keymap.set("n", "<leader>cf", function()
    vim.lsp.buf.format({ async = true })
  end, opts)

  -- Diagnostics
  vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
  vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
  vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
  vim.keymap.set("n", "<leader>dl", vim.diagnostic.setloclist, opts)

  -- Telescope LSP pickers
  vim.keymap.set("n", "<leader>fd", ":Telescope lsp_definitions<CR>", opts)
  vim.keymap.set("n", "<leader>fi", ":Telescope lsp_implementations<CR>", opts)
  vim.keymap.set("n", "<leader>ft", ":Telescope lsp_type_definitions<CR>", opts)
  vim.keymap.set("n", "<leader>fs", ":Telescope lsp_document_symbols<CR>", opts)
  vim.keymap.set("n", "<leader>fS", ":Telescope lsp_workspace_symbols<CR>", opts)

  -- Highlight references on cursor hold
  if client.server_capabilities.documentHighlightProvider then
    vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })
    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
      buffer = bufnr,
      group = "lsp_document_highlight",
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd("CursorMoved", {
      buffer = bufnr,
      group = "lsp_document_highlight",
      callback = vim.lsp.buf.clear_references,
    })
  end

  -- Format on save (optional - uncomment if desired)
  -- if client.server_capabilities.documentFormattingProvider then
  --   vim.api.nvim_create_autocmd("BufWritePre", {
  --     buffer = bufnr,
  --     callback = function()
  --       vim.lsp.buf.format({ async = false })
  --     end,
  --   })
  -- end
end

-- ============================================================================
-- CAPABILITIES (for nvim-cmp)
-- ============================================================================
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- ============================================================================
-- MASON LSP CONFIG
-- ============================================================================
mason_lspconfig.setup({
  ensure_installed = {
    "lua_ls",        -- Lua
    "clangd",        -- C/C++
    "pyright",       -- Python (was "pyrght" in error - FIXED)
    "omnisharp",     -- C#
    "ts_ls",         -- TypeScript/JavaScript (was "tsserver" - FIXED)
    "jdtls",         -- Java
    "gopls",         -- Go
    "html",          -- HTML
    "cssls",         -- CSS (not "csslls")
    "yamlls",        -- YAML (not "yamls")
    "dockerls",      -- Docker
    "bashls",        -- Bash (not "bashlls")
    "jsonls",        -- JSON
    "rust_analyzer", -- Rust
  },
  automatic_installation = true,
})

-- ============================================================================
-- LANGUAGE SERVER CONFIGURATIONS
-- ============================================================================

-- Default configuration for all servers
local default_config = {
  on_attach = on_attach,
  capabilities = capabilities,
}

-- C/C++ (clangd)
lspconfig.clangd.setup(vim.tbl_extend("force", default_config, {
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--header-insertion=iwyu",
    "--completion-style=detailed",
    "--function-arg-placeholders",
  },
  filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
  root_dir = lspconfig.util.root_pattern(
    ".clangd",
    ".clang-tidy",
    ".clang-format",
    "compile_commands.json",
    "compile_flags.txt",
    "configure.ac",
    ".git"
  ),
}))

-- Python (pyright)
lspconfig.pyright.setup(vim.tbl_extend("force", default_config, {
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "basic",
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = "workspace",
      },
    },
  },
}))

-- C# (omnisharp)
lspconfig.omnisharp.setup(vim.tbl_extend("force", default_config, {
  cmd = { "omnisharp" },
  enable_roslyn_analyzers = true,
  organize_imports_on_format = true,
  enable_import_completion = true,
}))

-- TypeScript/JavaScript (ts_ls - formerly tsserver)
lspconfig.ts_ls.setup(vim.tbl_extend("force", default_config, {
  settings = {
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    },
    javascript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    },
  },
}))

-- Java (jdtls)
lspconfig.jdtls.setup(default_config)

-- Go (gopls)
lspconfig.gopls.setup(vim.tbl_extend("force", default_config, {
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
      gofumpt = true,
    },
  },
}))

-- HTML
lspconfig.html.setup(vim.tbl_extend("force", default_config, {
  filetypes = { "html", "htmldjango" },
}))

-- CSS
lspconfig.cssls.setup(default_config)

-- YAML
lspconfig.yamlls.setup(vim.tbl_extend("force", default_config, {
  settings = {
    yaml = {
      schemas = {
        ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
        ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "docker-compose*.yml",
        kubernetes = "/*.yaml",
      },
      format = { enable = true },
      validate = true,
      completion = true,
    },
  },
}))

-- Docker
lspconfig.dockerls.setup(default_config)

-- Bash
lspconfig.bashls.setup(default_config)

-- JSON
lspconfig.jsonls.setup(vim.tbl_extend("force", default_config, {
  settings = {
    json = {
      schemas = require("schemastore").json.schemas(),
      validate = { enable = true },
    },
  },
}))

-- Lua (for Neovim configuration)
lspconfig.lua_ls.setup(vim.tbl_extend("force", default_config, {
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      telemetry = {
        enable = false,
      },
    },
  },
}))

-- Rust
lspconfig.rust_analyzer.setup(vim.tbl_extend("force", default_config, {
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        allFeatures = true,
      },
      checkOnSave = {
        command = "clippy",
      },
    },
  },
}))

-- ============================================================================
-- ADDITIONAL HANDLERS
-- ============================================================================

-- Customize hover window
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = "rounded",
})

-- Customize signature help window
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = "rounded",
})
