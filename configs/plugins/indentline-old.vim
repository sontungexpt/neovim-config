Plug 'Yggdroot/indentLine'
" Plug 'xiyaowong/nvim-transparent'

"----------IndentLine---------"

let g:indentLine_char = '│'
" let g:indentLine_char_list = ['│', '╎', '┆', '┊']

" Leading space"
let g:indentLine_leadingSpaceEnabled = 1
let g:indentLine_leadingSpaceChar = '.'

" Conceal"
let g:indentLine_concealcursor = 'incv'
let g:indentLine_conceallevel = 2
let g:indentLine_setConceal = 1

" Color"
let g:indentLine_color_tty_light = 7
let g:indentLine_color_dark = 1
let g:indentLine_color_term = 239
let g:indentLine_color_gui = '#4b5154'

" This variable specify a list of file types.
" When opening these types of files, the plugin is disabled by
" default.
let g:indentLine_fileTypeExclude = ['text', 'sh', 'rasi']

" Default value is [] which means no file types are excluded.
" This variable specify a list of buffer types.
" When opening these types of buffers, the plugin is disabled
" by default.
let g:indentLine_bufTypeExclude = ['help', 'terminal','coc-explorer','NvimTree']

" This variable specify a list of buffer names, which can be
" regular expression. If the buffer's name fall into this list,
" the indentLine won't display.
let g:indentLine_bufNameExclude = [ '_.*', 
                                  \ 'NERD_tree.*', 
                                  \ 'nvim-tree.*', 
                                  \ 'nvim-tree', 
                                  \ 'coc-explorer',
                                  \ 'NvimTree_0',
                                  \ 'NvimTree_1', 
                                  \ 'NvimTree_2', 
                                  \ 'NvimTree_3', 
                                  \ 'NvimTree_4', 
                                  \ 'NvimTree_5', 
                                  \ 'NvimTree_6',
                                  \ 'NvimTree_7',
                                  \ 'NvimTree_8',
                                  \ 'NvimTree_9',
                                  \]







