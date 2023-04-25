local M = {}

M.has_highlight_colors = function()
  return vim.fn.exists(':HighlightColorsOn') == 2
end

M.create_autocmds = function()
  if not M.has_highlight_colors() then
    return
  end
  local create_autocmd = require('core.utils').create_autocmd
  create_autocmd('VimEnter', '', 'HighlightColorsAutoGroup', function()
    vim.cmd("HighlightColorsOn")
  end, false)
end
return M
