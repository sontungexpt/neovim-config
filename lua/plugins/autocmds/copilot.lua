-- auto check auth when vim starts
local M = {}

-- check if has command Copilot
M.has_copilot = function()
  return vim.fn.exists(":Copilot") == 2
end

M.has_copilot_auth = function()
  local config_path = vim.fn.stdpath("config")
  -- remove nvim from the path
  -- this is needed because the path is ~/.config/nvim
  -- and we want to check if ~/.config/copilot exists
  -- so we remove the last 5 characters
  local copilot_path = string.sub(config_path, 1, -5) .. "/github-copilot"
  -- check if the folder exists
  return vim.fn.isdirectory(copilot_path) == 1
end

M.create_autocmds = function()
  vim.api.nvim_create_autocmd({ 'VimEnter' },
    {
      group = vim.api.nvim_create_augroup('CopilotEnable', {}),
      pattern = '',
      callback = function()
        if not M.has_copilot() then
          return
        end
        if not M.has_copilot_auth() then
          vim.schedule(function()
            vim.cmd("Copilot auth")
          end)
        end
      end
    }
  )
end

return M
