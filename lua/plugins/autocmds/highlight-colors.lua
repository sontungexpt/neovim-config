local M = {}

M.has_highlight_colors = function()
  return vim.fn.exists(':HighlightColorsOn') == 2
end

M.create_autocmds = function()
  if not M.has_highlight_colors() then
    return
  end

  vim.api.nvim_create_autocmd('VimEnter', {
    group = vim.api.nvim_create_augroup('HighlightColorsAutoGroup', {}),
    pattern = '',
    command = 'HighlightColorsOn',
  })
end

return M
