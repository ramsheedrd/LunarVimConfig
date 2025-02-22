table.insert(lvim.plugins, { "leoluz/nvim-dap-go" })

-- Ensure Installed By Mason
--  'chrome-debug-adapter',
--  'debugpy',
--  'delve',
--  'js-debug-adapter',

local dap = require("dap")
require('dap-go').setup()

lvim.builtin.dap.ui.config.layouts = {
  {
    elements = {
      { id = "repl", size = 1.0 }, -- Only REPL, taking full space
    },
    size = 0.4,                    -- 30% of the screen height
    position = "right",
  },
  -- You can keep a sidebar layout if needed, but make it optional
  {
    elements = {},
    size = 0,
    position = "left",
  },
}

dap.set_log_level("DEBUG")

local function get_python_path()
  -- Common virtual env directories
  local venv_dirs = { 'venv', '.venv' }
  for _, dir in ipairs(venv_dirs) do
    local python_path
    python_path = vim.fn.getcwd() .. '/' .. dir .. '/bin/python'
    if vim.fn.executable(python_path) == 1 then
      return python_path
    end
  end
  -- Fallback to system Python if no venv found
  return vim.fn.exepath('python3') or vim.fn.exepath('python')
end

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
    pythonPath = get_python_path(), -- Adjust as needed
  },
}

-- Adapter configuration for js-debug-adapter
dap.adapters["pwa-node"] = {
  type = "server",
  host = "localhost",
  port = "${port}",
  executable = {
    command = "node",
    args = {
      os.getenv("HOME") .. "/.local/share/lvim/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
      "${port}",
    },
  },
}

require("dap").configurations.javascript = {
  {
    type = "pwa-node",
    request = "launch",
    name = "Launch file",
    program = "${file}",
    cwd = "${workspaceFolder}",
  },
}

dap.adapters.chrome = {
  type = "executable",
  command = "node",
  -- command = "chrome-debug-adapter",
  args = { os.getenv("HOME") .. "/.local/share/lvim/mason/packages/chrome-debug-adapter/out/src/chromeDebug.js" }, -- TODO adjust
}

dap.configurations.typescriptreact = {
  {
    type = "chrome",
    request = "attach",
    program = "${file}",
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = "inspector",
    port = 9222,
    webRoot = "${workspaceFolder}",
  },
}

-- First run the react app then put the URL here
dap.configurations.javascriptreact = {
  {
    type = "chrome",
    request = "launch",
    name = "Launch react",
    -- program = "${file}",
    -- cwd = vim.fn.getcwd(),
    -- sourceMaps = true,
    -- protocol = "inspector",
    -- port = 9222,
    url = "http://localhost:3000",
    webRoot = "${workspaceFolder}",
  },
}
