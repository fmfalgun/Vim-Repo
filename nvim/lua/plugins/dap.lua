--[[
================================================================================
  DAP (DEBUG ADAPTER PROTOCOL) CONFIGURATION
================================================================================
  Debugging configuration for all supported languages

  Supported Debuggers:
    - C/C++ (codelldb, cpptools)
    - Python (debugpy)
    - C# (netcoredbg)
    - JavaScript/TypeScript (node-debug2, chrome-debug)
    - Java (java-debug-adapter)
    - Go (delve)
    - Bash (bash-debug-adapter)

  Keybindings:
    <F5>  - Continue/Start debugging
    <F9>  - Toggle breakpoint
    <F10> - Step over
    <F11> - Step into
    <F12> - Step out
    <leader>db - Toggle breakpoint
    <leader>dB - Conditional breakpoint
    <leader>dr - Open REPL
    <leader>du - Toggle UI
    <leader>dt - Terminate
================================================================================
--]]

local dap = require("dap")
local dapui = require("dapui")
local mason_dap = require("mason-nvim-dap")

-- ============================================================================
-- DAP UI SETUP
-- ============================================================================
dapui.setup({
  icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
  mappings = {
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
    toggle = "t",
  },
  layouts = {
    {
      elements = {
        { id = "scopes", size = 0.25 },
        { id = "breakpoints", size = 0.25 },
        { id = "stacks", size = 0.25 },
        { id = "watches", size = 0.25 },
      },
      size = 40,
      position = "left",
    },
    {
      elements = {
        { id = "repl", size = 0.5 },
        { id = "console", size = 0.5 },
      },
      size = 10,
      position = "bottom",
    },
  },
  floating = {
    max_height = nil,
    max_width = nil,
    border = "rounded",
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
})

-- ============================================================================
-- MASON DAP SETUP
-- ============================================================================
mason_dap.setup({
  ensure_installed = {
    "python",      -- debugpy
    "cppdbg",      -- cpptools
    "delve",       -- Go
    "node2",       -- Node.js/JavaScript
    "coreclr",     -- C#/.NET
    "codelldb",    -- Rust/C/C++
    "bash",        -- Bash
  },
  automatic_installation = true,
  handlers = {},
})

-- ============================================================================
-- AUTO OPEN/CLOSE UI
-- ============================================================================
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

-- ============================================================================
-- VIRTUAL TEXT
-- ============================================================================
require("nvim-dap-virtual-text").setup({
  enabled = true,
  enabled_commands = true,
  highlight_changed_variables = true,
  highlight_new_as_changed = false,
  show_stop_reason = true,
  commented = false,
  only_first_definition = true,
  all_references = false,
  filter_references_pattern = "<module",
  virt_text_pos = "eol",
  all_frames = false,
  virt_lines = false,
  virt_text_win_col = nil,
})

-- ============================================================================
-- SIGNS
-- ============================================================================
vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticError", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointCondition", { text = "", texthl = "DiagnosticWarn", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "DiagnosticInfo", linehl = "", numhl = "" })
vim.fn.sign_define("DapLogPoint", { text = "", texthl = "DiagnosticInfo", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "", texthl = "DiagnosticOk", linehl = "DapStoppedLine", numhl = "" })

-- ============================================================================
-- C/C++ (using codelldb)
-- ============================================================================
dap.adapters.codelldb = {
  type = "server",
  port = "${port}",
  executable = {
    command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
    args = { "--port", "${port}" },
  },
}

dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
  },
  {
    name = "Attach to process",
    type = "codelldb",
    request = "attach",
    pid = require("dap.utils").pick_process,
    args = {},
  },
}

dap.configurations.c = dap.configurations.cpp

-- ============================================================================
-- PYTHON (using debugpy)
-- ============================================================================
dap.adapters.python = {
  type = "executable",
  command = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python",
  args = { "-m", "debugpy.adapter" },
}

dap.configurations.python = {
  {
    type = "python",
    request = "launch",
    name = "Launch file",
    program = "${file}",
    pythonPath = function()
      local venv = os.getenv("VIRTUAL_ENV")
      if venv then
        return venv .. "/bin/python"
      else
        return "/usr/bin/python3"
      end
    end,
  },
  {
    type = "python",
    request = "launch",
    name = "Launch file with arguments",
    program = "${file}",
    args = function()
      local args_string = vim.fn.input("Arguments: ")
      return vim.split(args_string, " +")
    end,
    pythonPath = function()
      local venv = os.getenv("VIRTUAL_ENV")
      if venv then
        return venv .. "/bin/python"
      else
        return "/usr/bin/python3"
      end
    end,
  },
  {
    type = "python",
    request = "attach",
    name = "Attach remote",
    connect = function()
      local host = vim.fn.input("Host [127.0.0.1]: ")
      host = host ~= "" and host or "127.0.0.1"
      local port = tonumber(vim.fn.input("Port [5678]: ")) or 5678
      return { host = host, port = port }
    end,
  },
}

-- ============================================================================
-- JAVASCRIPT/TYPESCRIPT (using node-debug2)
-- ============================================================================
dap.adapters.node2 = {
  type = "executable",
  command = "node",
  args = { vim.fn.stdpath("data") .. "/mason/packages/node-debug2-adapter/out/src/nodeDebug.js" },
}

dap.configurations.javascript = {
  {
    name = "Launch",
    type = "node2",
    request = "launch",
    program = "${file}",
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = "inspector",
    console = "integratedTerminal",
  },
  {
    name = "Attach to process",
    type = "node2",
    request = "attach",
    processId = require("dap.utils").pick_process,
  },
}

dap.configurations.typescript = dap.configurations.javascript

-- ============================================================================
-- GO (using delve)
-- ============================================================================
dap.adapters.delve = {
  type = "server",
  port = "${port}",
  executable = {
    command = vim.fn.stdpath("data") .. "/mason/bin/dlv",
    args = { "dap", "-l", "127.0.0.1:${port}" },
  },
}

dap.configurations.go = {
  {
    type = "delve",
    name = "Debug",
    request = "launch",
    program = "${file}",
  },
  {
    type = "delve",
    name = "Debug test",
    request = "launch",
    mode = "test",
    program = "${file}",
  },
  {
    type = "delve",
    name = "Debug test (go.mod)",
    request = "launch",
    mode = "test",
    program = "./${relativeFileDirname}",
  },
}

-- ============================================================================
-- C# (.NET) (using netcoredbg)
-- ============================================================================
dap.adapters.coreclr = {
  type = "executable",
  command = vim.fn.stdpath("data") .. "/mason/bin/netcoredbg",
  args = { "--interpreter=vscode" },
}

dap.configurations.cs = {
  {
    type = "coreclr",
    name = "launch - netcoredbg",
    request = "launch",
    program = function()
      return vim.fn.input("Path to dll: ", vim.fn.getcwd() .. "/bin/Debug/", "file")
    end,
  },
}

-- ============================================================================
-- JAVA (using java-debug-adapter)
-- ============================================================================
dap.configurations.java = {
  {
    type = "java",
    request = "attach",
    name = "Debug (Attach) - Remote",
    hostName = "127.0.0.1",
    port = 5005,
  },
  {
    type = "java",
    request = "launch",
    name = "Debug (Launch) - Current File",
    mainClass = "${file}",
  },
}

-- ============================================================================
-- BASH
-- ============================================================================
dap.adapters.bashdb = {
  type = "executable",
  command = vim.fn.stdpath("data") .. "/mason/packages/bash-debug-adapter/bash-debug-adapter",
  name = "bashdb",
}

dap.configurations.sh = {
  {
    type = "bashdb",
    request = "launch",
    name = "Launch file",
    showDebugOutput = true,
    pathBashdb = vim.fn.stdpath("data") .. "/mason/packages/bash-debug-adapter/extension/bashdb_dir/bashdb",
    pathBashdbLib = vim.fn.stdpath("data") .. "/mason/packages/bash-debug-adapter/extension/bashdb_dir",
    trace = true,
    file = "${file}",
    program = "${file}",
    cwd = "${workspaceFolder}",
    pathCat = "cat",
    pathBash = "/bin/bash",
    pathMkfifo = "mkfifo",
    pathPkill = "pkill",
    args = {},
    env = {},
    terminalKind = "integrated",
  },
}

-- ============================================================================
-- ADDITIONAL KEYBINDINGS
-- ============================================================================
-- Set conditional breakpoint
vim.keymap.set("n", "<leader>dC", function()
  vim.ui.input({ prompt = "Breakpoint condition: " }, function(condition)
    if condition then
      dap.set_breakpoint(condition)
    end
  end)
end, { desc = "Conditional Breakpoint" })

-- Set log point
vim.keymap.set("n", "<leader>dL", function()
  vim.ui.input({ prompt = "Log message: " }, function(message)
    if message then
      dap.set_breakpoint(nil, nil, message)
    end
  end)
end, { desc = "Log Point" })

-- Evaluate expression
vim.keymap.set("n", "<leader>de", function()
  vim.ui.input({ prompt = "Expression: " }, function(expr)
    if expr then
      dapui.eval(expr)
    end
  end)
end, { desc = "Evaluate Expression" })

-- Hover
vim.keymap.set("n", "<leader>dh", function()
  require("dap.ui.widgets").hover()
end, { desc = "Debugger Hover" })
