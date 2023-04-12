Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
"  https://github.com/nvim-treesitter/nvim-treesitter
Plug 'windwp/nvim-ts-autotag'
"  https://github.com/windwp/nvim-ts-autotag
Plug 'p00f/nvim-ts-rainbow'
"  https://github.com/p00f/nvim-ts-rainbow
Plug 'Fymyte/tree-sitter-rasi'
Plug 'j'
Plug 'Fymyte/rasi.vim'

"-----------Tree-sitter-----------"
function TreesitterSetup()
lua << EOF
  require('nvim-treesitter.configs').setup {
    ensure_installed = {
      "c",
      "cpp",
      "bash",
      "cmake",
      "go",
      "java",
      "json",
      "python",
      "regex",
      "rust",
      "toml",
      "tsx",
      "typescript",
      "yaml",
      "lua",
      "dart",
      "ruby",
      "html",
      "javascript",
      "css",
      "c_sharp",
      "vim",
      "markdown",
      "help",
      "rasi"
    },
    ignore_install = { },
    highlight = {
      enable = true,
      --disable ={"html","css"}
      --disable = {"html","javascript","css"}
    },
    indent = {
      enable = true
    },
    additional_vim_regex_highlighting = false,
    autotag = {
      enable = true,
      filetypes = { "html" , "xml" ,"jsx" },
    },
    rainbow = {
      enable = true,
      disable = {"html", "javascript"}, --list of languages you want to disable the plugin for
      extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
      max_file_lines = nil, -- Do not enable for files with more than n lines, int
      colors = {
        "#ce4a62",
        "#e78135",
        "#f9b71f",
        "#eddc38",
        "#EEDF10",
        "#01AE6E",
        "#10e8c3",
        "#169ed8",
        "#2f73e2",
        "#1c73e9",
        "#01519A",
        "#2d3ae6",
        "#802ef1",
        "#b438f3",
        "#d906f0",
        "#f404b4",
        "#f00483"
      }, -- table of hex strings
      -- termcolors = {} -- table of colour name strings
    }
  }
  vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics,
  {
      underline = true,
      virtual_text = {
        spacing = 5,
        severity_limit = 'Warning',
      },
      update_in_insert = true,
  })
EOF
endfunction


" Run tree-sitter setup options when neovim loaded
augroup TreesitterOverrides
  autocmd!
  autocmd User PlugLoaded call TreesitterSetup()
augroup END
