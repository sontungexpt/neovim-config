local status_ok, hightlight_colors = pcall(require, "nvim-highlight-colors")

if not status_ok then
  return
end

hightlight_colors.setup {
  render = 'background', -- or 'foreground' or 'first_column'
  enable_named_colors = true,
  enable_tailwind = true
}

vim.cmd([[
  augroup HightlightColors
  autocmd!
  autocmd  VimEnter, BufEnter, BufLeave *.* HightligtColorsOn
  augroup END
]])

