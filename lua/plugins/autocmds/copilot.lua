local M = {}

M.has_copilot = function()
  return vim.fn.exists(":Copilot") == 2
end

M.has_copilot_auth = function()
  local config_path = vim.fn.stdpath("config")
  local copilot_path = string.sub(config_path, 1, -5) .. "/github-copilot"
  return vim.fn.isdirectory(copilot_path) == 1
end

M.create_autocmds = function()
  if not M.has_copilot() then
    return
  end

  vim.api.nvim_create_autocmd('VimEnter', {
    pattern = '',
    group = vim.api.nvim_create_augroup('CopilotAutoGroup', {}),
    callback = function()
      if not M.has_copilot_auth() then
        vim.cmd("Copilot auth")
      end
    end
  })
end

return M
