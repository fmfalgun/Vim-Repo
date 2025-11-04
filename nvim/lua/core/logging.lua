--[[
================================================================================
  CENTRALIZED LOGGING SYSTEM
================================================================================
  All Neovim logs go to ~/.vim-logs/ directory
  Startup errors are shown with log file references
================================================================================
--]]

local M = {}

-- Log directory
M.log_dir = vim.fn.expand("~/.vim-logs")
M.current_session = os.date("%Y%m%d_%H%M%S")
M.session_dir = M.log_dir .. "/" .. M.current_session

-- Log levels
M.levels = {
  DEBUG = 1,
  INFO = 2,
  WARN = 3,
  ERROR = 4,
  CRITICAL = 5,
}

-- Current log level (can be changed in config)
M.current_level = M.levels.WARN

-- Initialize logging
M.setup = function()
  -- Create log directories
  vim.fn.mkdir(M.log_dir, "p")
  vim.fn.mkdir(M.session_dir, "p")

  -- Create session log file
  M.session_log = M.session_dir .. "/session.log"
  M.error_log = M.session_dir .. "/errors.log"
  M.plugin_log = M.session_dir .. "/plugins.log"
  M.lsp_log = M.session_dir .. "/lsp.log"

  -- Write session start
  M.write_to_file(M.session_log, string.format(
    "=== Neovim Session Started: %s ===\n",
    os.date("%Y-%m-%d %H:%M:%S")
  ))

  -- Set up autocmd to log session end
  vim.api.nvim_create_autocmd("VimLeavePre", {
    callback = function()
      M.write_to_file(M.session_log, string.format(
        "=== Neovim Session Ended: %s ===\n",
        os.date("%Y-%m-%d %H:%M:%S")
      ))
    end,
  })

  -- Keep only last 30 days of logs
  M.cleanup_old_logs()
end

-- Write to log file
M.write_to_file = function(file_path, content)
  local file = io.open(file_path, "a")
  if file then
    file:write(content)
    file:close()
  end
end

-- Log function
M.log = function(level, source, message, data)
  if type(level) == "string" then
    level = M.levels[level] or M.levels.INFO
  end

  if level < M.current_level then
    return
  end

  local level_names = { "DEBUG", "INFO", "WARN", "ERROR", "CRITICAL" }
  local level_name = level_names[level] or "UNKNOWN"

  local timestamp = os.date("%Y-%m-%d %H:%M:%S")
  local log_line = string.format(
    "[%s] [%s] [%s] %s\n",
    timestamp,
    level_name,
    source,
    message
  )

  -- Add data if provided
  if data then
    log_line = log_line .. "  Data: " .. vim.inspect(data) .. "\n"
  end

  -- Write to session log
  M.write_to_file(M.session_log, log_line)

  -- Write to error log if error or critical
  if level >= M.levels.ERROR then
    M.write_to_file(M.error_log, log_line)
  end
end

-- Specific log functions
M.debug = function(source, message, data)
  M.log(M.levels.DEBUG, source, message, data)
end

M.info = function(source, message, data)
  M.log(M.levels.INFO, source, message, data)
end

M.warn = function(source, message, data)
  M.log(M.levels.WARN, source, message, data)
end

M.error = function(source, message, data)
  M.log(M.levels.ERROR, source, message, data)
end

M.critical = function(source, message, data)
  M.log(M.levels.CRITICAL, source, message, data)
end

-- Log plugin errors
M.log_plugin_error = function(plugin_name, error_message)
  local timestamp = os.date("%Y-%m-%d %H:%M:%S")
  local log_line = string.format(
    "[%s] Plugin: %s\n  Error: %s\n\n",
    timestamp,
    plugin_name,
    error_message
  )

  M.write_to_file(M.plugin_log, log_line)
  M.write_to_file(M.error_log, log_line)
end

-- Log LSP errors
M.log_lsp_error = function(client_name, error_message)
  local timestamp = os.date("%Y-%m-%d %H:%M:%S")
  local log_line = string.format(
    "[%s] LSP Client: %s\n  Error: %s\n\n",
    timestamp,
    client_name,
    error_message
  )

  M.write_to_file(M.lsp_log, log_line)
  M.write_to_file(M.error_log, log_line)
end

-- Cleanup old logs (keep last 30 days)
M.cleanup_old_logs = function()
  local log_dirs = vim.fn.readdir(M.log_dir)
  local current_time = os.time()
  local thirty_days = 30 * 24 * 60 * 60 -- 30 days in seconds

  for _, dir in ipairs(log_dirs) do
    local full_path = M.log_dir .. "/" .. dir
    local stat = vim.loop.fs_stat(full_path)

    if stat and stat.type == "directory" then
      -- Check if directory is older than 30 days
      if current_time - stat.mtime.sec > thirty_days then
        -- Delete old log directory
        vim.fn.delete(full_path, "rf")
      end
    end
  end
end

-- Get log statistics
M.get_stats = function()
  local error_log_content = ""
  local error_count = 0

  if vim.fn.filereadable(M.error_log) == 1 then
    error_log_content = table.concat(vim.fn.readfile(M.error_log), "\n")
    -- Count errors (each error starts with a timestamp line)
    for _ in error_log_content:gmatch("%[%d%d%d%d%-%d%d%-%d%d") do
      error_count = error_count + 1
    end
  end

  return {
    session_dir = M.session_dir,
    error_count = error_count,
    has_errors = error_count > 0,
    error_log = M.error_log,
    session_log = M.session_log,
    plugin_log = M.plugin_log,
    lsp_log = M.lsp_log,
  }
end

-- Show startup errors (if any)
M.show_startup_errors = function()
  vim.defer_fn(function()
    local stats = M.get_stats()

    if stats.has_errors then
      -- Show error notification
      local message = string.format(
        "⚠️  %d error(s) detected during startup\n\n" ..
        "Log files:\n" ..
        "• Errors: %s\n" ..
        "• Plugins: %s\n" ..
        "• LSP: %s\n\n" ..
        "Copy and share these files if you need help!",
        stats.error_count,
        stats.error_log,
        stats.plugin_log,
        stats.lsp_log
      )

      vim.notify(message, vim.log.levels.WARN, {
        title = "Startup Errors Detected",
        timeout = 10000,
      })

      -- Also log to session
      M.info("startup", string.format("Startup completed with %d errors", stats.error_count))
    else
      -- Silent success - no notification
      M.info("startup", "Startup completed successfully with no errors")
    end
  end, 2000) -- Wait 2 seconds after startup to check
end

-- Export log path for commands
M.open_logs = function()
  vim.cmd("edit " .. M.session_dir)
end

return M
