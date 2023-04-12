local status_ok, fold_preview = pcall(require, "fold-preview")

if not status_ok then
  return
end

local map = fold_preview.mapping
local keymap = vim.keymap
keymap.amend = require('keymap-amend')

fold_preview.setup({
  default_keybindings = false,
  auto = 300,
  border = "single",
  -- another settings
})

keymap.amend('n', 'h', map.close_preview_open_fold)
keymap.amend('n', 'l', map.close_preview_open_fold)
keymap.amend('n', 'zo', map.close_preview)
keymap.amend('n', 'zc', map.close_preview_without_defer)
keymap.amend('n', 'zR', map.close_preview)
keymap.amend('n', 'zM', map.close_preview_without_defer)
