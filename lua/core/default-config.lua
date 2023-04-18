local M = {}

M.ui = {
  colors = {
    bg = "#202328",
    fg = "#bbc2cf",
    yellow = "#ECBE7B",
    cyan = "#008080",
    darkblue = "#081633",
    black = "#000000",
    white = "#ffffff",
    green = "#98be65",
    orange = "#FF8800",
    violet = "#a9a1e1",
    magenta = "#c678dd",
    blue = "#51afef",
    red = "#ec5f67",
    gray = "#66615c",
    pink = "#eb7fdc",
  },
  lualine = {
    options = {
      float_separator = { left = "", right = "" },
      section_separators = { "", "" },
      component_separators = { "", "" },
    },
  },
}

-- config for lazy.nvim startup options
M.lazy_nvim = require "plugins.configs.lazy_nvim"

return M
