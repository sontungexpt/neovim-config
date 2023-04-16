local M = {}

M.options = {

}

M.ui = {
  dashboard = {
    load_on_startup = false,
    header = {
      "           ▄ ▄                   ",
      "       ▄   ▄▄▄     ▄ ▄▄▄ ▄ ▄     ",
      "       █ ▄ █▄█ ▄▄▄ █ █▄█ █ █     ",
      "    ▄▄ █▄█▄▄▄█ █▄█▄█▄▄█▄▄█ █     ",
      "  ▄ █▄▄█ ▄ ▄▄ ▄█ ▄▄▄▄▄▄▄▄▄▄▄▄▄▄  ",
      "  █▄▄▄▄ ▄▄▄ █ ▄ ▄▄▄ ▄ ▄▄▄ ▄ ▄ █ ▄",
      "▄ █ █▄█ █▄█ █ █ █▄█ █ █▄█ ▄▄▄ █ █",
      "█▄█ ▄ █▄▄█▄▄█ █ ▄▄█ █ ▄ █ █▄█▄█ █",
      "    █▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄█ █▄█▄▄▄█    ",
    },
    buttons = {
      { "  Find File",    "Spc f f", "Telescope find_files" },
      { "  Recent Files", "Spc f o", "Telescope oldfiles" },
      { "  Find Word",    "Spc f w", "Telescope live_grep" },
      { "  Bookmarks",    "Spc b m", "Telescope marks" },
      { "  Themes",       "Spc t h", "Telescope themes" },
      { "  Mappings",     "Spc c h", "NvCheatsheet" },
    },
  },
}

M.plugins = {}

-- config for lazy.nvim startup options
M.lazy_nvim = require "plugins.configs.lazy_nvim"

return M
