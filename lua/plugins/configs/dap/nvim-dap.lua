local status_ok, dap = pcall(require, 'dap')
if not status_ok then
  return
end

local codelldb_mason_path = vim.fn.stdpath('data') .. '/mason/packages/codelldb/codelldb'

if ~vim.fn.filereadable(codelldb_mason_path) == 0 then
  dap.adapters.codelldb = {
    type = 'server',
    host = '127.0.0.1',
    port = 13000,
  }

  dap.adapters.codelldb = {
    type = 'server',
    port = "${port}",
    executable = {
      command = codelldb_mason_path,
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
  dap.configurations.rust = dap.configurations.cpp
end

dap.adapters.python = function(cb, config)
  if config.request == 'attach' then
    ---@diagnostic disable-next-line: undefined-field
    local port = (config.connect or config).port
    ---@diagnostic disable-next-line: undefined-field
    local host = (config.connect or config).host or '127.0.0.1'
    cb({
      type = 'server',
      port = assert(port, '`connect.port` is required for a python `attach` configuration'),
      host = host,
      options = {
        source_filetype = 'python',
      },
    })
  else
    cb({
      type = 'executable',
      command = 'path/to/virtualenvs/debugpy/bin/python',
      args = { '-m', 'debugpy.adapter' },
      options = {
        source_filetype = 'python',
      },
    })
  end
end
