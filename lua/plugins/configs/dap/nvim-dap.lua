local status_ok, dap = pcall(require, 'dap')
if not status_ok then
  return
end

vim.fn.sign_define("DapBreakpoint", { text = " ", texthl = "DapBreakpointColor", linehl = "", numhl = "" })
vim.cmd("highlight DapBreakpointColor guifg=#EC5241")

vim.fn.sign_define("DapStopped", { text = "󰝤 ", texthl = "DapStoppedColor", linehl = "", numhl = "" })
vim.cmd("highlight DapStoppedColor guifg=#EC5241")

dap.adapters.codelldb = {
  type = 'server',
  host = '127.0.0.1',
  port = 13000
}

local codelldb_mason_path = vim.fn.stdpath('data') .. '/mason/packages/codelldb/codelldb'

dap.adapters.codelldb = {
  type = 'server',
  port = "${port}",
  executable = {
    -- CHANGE THIS to your path!
    command = codelldb_mason_path,
    args = { "--port", "${port}" },

    -- On windows you may have to uncomment this:
    -- detached = false,
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

local get_rust_debug_filepath = function()
  local project_dir = vim.fn.getcwd():match("(.*/)")
  -- check if project_dir end with / then remove it
  if string.sub(project_dir, -1) == "/" then
    project_dir = string.sub(project_dir, 1, -2)
  end

  local project_name = vim.fn.fnamemodify(project_dir, ':t')

  local debug_dir = project_dir .. '/target/debug/deps/'

  local files = vim.fn.glob(debug_dir .. '/*', true, true)
  for _, file in ipairs(files) do
    local file_name = vim.fn.fnamemodify(file, ':t')
    if string.match(file_name, "^" .. project_name .. "%-%x+$") then
      return debug_dir .. file_name
    end
  end

  return vim.fn.input(debug_dir, 'file')
end


dap.configurations.rust = {
  {
    type = 'codelldb',
    name = 'Debug Rust',
    request = 'launch',
    program = function()
      local filepath = get_rust_debug_filepath()
      return filepath
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
  }
}
