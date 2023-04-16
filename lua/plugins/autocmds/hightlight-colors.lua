local M = {}

M.create_autocmds = function()
  local autocmd = vim.api.nvim_create_autocmd
  autocmd(
    {
      'BufReadPre',
      'BufReadPost',
      'BufRead',
      'FileReadPre',
      'VimEnter',
      'BufWritePost',
    },
    {
      group = vim.api.nvim_create_augroup('HightlightColors', {}),
      pattern = '*',
      -- all files
      callback = function()
        vim.cmd("HightligtColorsOn")
      end
    }
  )
end
return M
