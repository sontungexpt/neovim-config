local M = {}

M.ignore_filetypes = { 'neo-tree', 'NvimTree' }
M.ignore_buftypes = { 'nofile', 'prompt', 'popup', "NvimTree" }
M.augroup = vim.api.nvim_create_augroup('FocusDisable', {})

M.is_installed = function()
  return vim.fn.exists(':FocusSplitRight') ~= 0
end

M.create_autocmds = function()
  if not M.is_installed() then
    return
  end

  vim.api.nvim_create_autocmd({ "BufEnter", "BufRead", "BufNewFile", "WinEnter" }, {
    group = M.augroup,
    callback = function(_)
      if vim.tbl_contains(M.ignore_buftypes, vim.bo.buftype) then
        vim.b.focus_disable = true
      end
    end,
    desc = 'Disable focus autoresize for BufType',
  })

  vim.api.nvim_create_autocmd({ "FileType" }, {
    group = M.augroup,
    callback = function(_)
      if vim.tbl_contains(M.ignore_filetypes, vim.bo.filetype) then
        vim.b.focus_disable = true
      end
    end,
    desc = 'Disable focus autoresize for FileType',
  })
end

return M
