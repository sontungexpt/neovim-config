local options = {
  ensure_installed = "all",
  ignore_install = {},
  highlight = {
    enable = true,
    --disable ={"html","css"}
  },
  indent = {
    enable = true
  },
  additional_vim_regex_highlighting = false,
  autotag = {
    enable = true,
    filetypes = {
      "html",
      "xml",
      "jsx",
      "tsx",
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
    },
  },
  autopairs = {
    enable = true,
  },
  -- config for rainbow v1
  -- rainbow = {
  --   enable = true,
  --   disable = {
  --     "html",
  --     "javascript"
  --   },
  --   extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
  --   max_file_lines = nil, -- Do not enable for files with more than n lines, int
  --   colors = {
  --     "#ec5f67",
  --     "#FF8800",
  --     "#f9b71f",
  --     "#eddc38",
  --     "#ECBE7B",
  --     "#98be65",
  --     "#01AE6E",
  --     "#10e8c3",
  --     "#169ed8",
  --     "#2f73e2",
  --     "#1573e9",
  --     "#1d3ae6",
  --     "#013795",
  --     "#c678dd",
  --     "#b438f3",
  --     "#d906f2",
  --     "#f404b5",
  --     "#f00483"
  --   }, -- table of hex strings
  --   -- termcolors = {} -- table of colour name strings
  -- },
  rainbow = {
    enable = true,
    disable = {
      "html",
    },
    query = 'rainbow-parens',
    strategy = require('ts-rainbow').strategy.global,
  }
}

return options
