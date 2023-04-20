local M = {}

M.create_autocmds = function()
  local autocmd = vim.api.nvim_create_autocmd
  autocmd(
    {
      'BufRead',
      'VimEnter',
      'BufNew',
      'BufNewFile',
    },
    {
      group = vim.api.nvim_create_augroup('HightlightColors', {}),
      pattern = '*',
      callback = function()
        vim.cmd("HightligtColorsOn")
      end
    }
  )
end
return M
