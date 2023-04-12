"leader key"
"  let mapleader = "\<Space>"

filetype plugin on
filetype plugin indent on

"syntax"
syntax enable
syntax on

"line number"
set number

"encoding"
set encoding=UTF-8
set mouse=a
set mousemoveevent

set incsearch
set hlsearch

"tabs & indentation"
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set autoindent
set smartindent
set smarttab

"line wrapping"
set nowrap

"no backup files"
set noswapfile
set nobackup
set nowritebackup

"search settings"
set ignorecase
set smartcase

"cursor line"
set cursorline
set cursorcolumn

"appearance"
set termguicolors
set t_Co=256
set background=dark
set signcolumn=yes

"list"
set list
set listchars=tab:▸\ ,trail:·

"clipboard"
set clipboard+=unnamedplus
set go+=a  " Visual selection automatically copied to the clipboard

"split window"
set splitbelow
set splitright

set updatetime=300

set wildignore+=*.pyc,*.o,*.obj,*.svn,*.swp,*.class,*.hg,*.DS_Store,*.min.*

" Enable syntax for .json files
autocmd BufRead,BufNewFile *.json set filetype=jsonc


