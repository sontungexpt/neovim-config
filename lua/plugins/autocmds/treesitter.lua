-- local cmd = vim.cmd
-- local g = vim.g

local M = {}

M.create_autocmds = function()
  local autocmd = vim.api.nvim_create_autocmd

  autocmd({ 'BufEnter', 'BufAdd', 'BufNew', 'BufNewFile', 'BufWinEnter' }, {
    group = vim.api.nvim_create_augroup('TS_FOLD_WORKAROUND', {}),
    callback = function()
      vim.opt.foldmethod = 'expr'
      vim.opt.foldexpr   = 'nvim_treesitter#foldexpr()'
    end
  })
end
return M
