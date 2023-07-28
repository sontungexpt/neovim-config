local status_ok, dap = pcall(require, 'dap')
if not status_ok then return end

local path_helpers = require('plugins.configs.dap.path')

vim.fn.sign_define("DapBreakpoint", { text = " ", texthl = "DapBreakpointColor", linehl = "", numhl = "" })
vim.cmd("highlight DapBreakpointColor guifg=#EC5241")

vim.fn.sign_define("DapStopped", { text = "󰜴 ", texthl = "DapStoppedColor", linehl = "", numhl = "" })
vim.cmd("highlight DapStoppedColor guifg=#98C379")

dap.adapters.codelldb = {
  type = 'server',
  host = '127.0.0.1',
  port = 13000
}

dap.adapters.codelldb = {
  type = 'server',
  port = "${port}",
  executable = {
    -- CHANGE THIS to your path!
    command = path_helpers.get_adapter_mason_path('codelldb'),
    args = { "--port", "${port}" },
  }
}

dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
  },
}
dap.configurations.c = dap.configurations.cpp

dap.configurations.rust = {
  {
    type = 'codelldb',
    name = 'Debug Rust',
    request = 'launch',
    program = function()
      return path_helpers.get_rust_debug_filepath()
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
  }
}
