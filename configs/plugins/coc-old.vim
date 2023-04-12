"  Plug 'neoclide/coc.nvim', {'branch': 'release'}
"  " https://github.com/neoclide/coc.nvim/wiki/Using-coc-extensions


"  let g:coc_global_extensions = [
"        \ 'coc-ultisnips',
"        \ 'coc-spell-checker',
"        \ 'coc-tsserver',
"        \ 'coc-git',
"        \ 'coc-highlight',
"        \ 'coc-eslint',
"        \ 'coc-prettier',
"        \ 'coc-flutter',
"        \ 'coc-angular',
"        \ 'coc-pyright',
"        \ 'coc-python',
"        \ 'coc-cmake',
"        \ 'coc-html',
"        \ 'coc-yaml',
"        \ 'coc-json',
"        \ 'coc-css',
"        \ 'coc-cssmodules',
"        \ 'coc-emmet',
"        \ 'coc-clangd',
"        \ 'coc-clang-format-style-options',
"        \ 'coc-ember',
"        \ 'coc-stylua',
"        \ 'coc-sumneko-lua',
"        \ 'coc-svg',
"        \ 'coc-sh',
"        \ ]


"  "Map Ctrl + Space để show list functions/biến autocomplete"
"  inoremap <silent><expr> <C-space> coc#refresh()

"  "Tự động import file của biến/function khi chọn và nhấn Tab"
"  inoremap <expr> <TAB> pumvisible() ? "\<C-y>" : "\<C-g>u\<TAB>"

"  "Hiển thị document cho function, biến:"
"  nnoremap <silent> K :call <SID>show_documentation()<CR>

"  "  nmap <leader>rn <Plug>(coc-rename)
"  nmap <leader>r <Plug>(coc-rename)

"  function! s:show_documentation()
"    if (index(['vim','help'], &filetype) >= 0)
"      execute 'h '.expand('<cword>')
"    elseif (coc#rpc#ready())
"      call CocActionAsync('doHover')
"    else
"      execute '!' . &keywordprg . " " . expand('<cword>')
"    endif
"  endfunction

"  "coc-prettier
"  command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')
"  let g:prettier#autoformat = 1

"  "Open coc-explorer and disable indentline plugin in it case 1"
"  "  autocmd FileType coc-explorer silent IndentLinesDisable
"  "  nnoremap <silent><C-b> :CocCommand explorer --position left<CR>
"  "  inoremap <silent><C-b> <ESC>:CocCommand explorer --position left<CR>
"  "  vnoremap <silent><C-b> <ESC>:CocCommand explorer --position left<CR>


"  "Open coc-explorer and disable indentline plugin in it case 2"
"  "  nnoremap <silent><C-b> :CocCommand explorer --position left<CR>\|:IndentLinesDisable<CR>
"  "  inoremap <silent><C-b> <ESC>:CocCommand explorer --position left<CR>\|:IndentLinesDisable<CR>
"  "  vnoremap <silent><C-b> <ESC>:CocCommand explorer --position left<CR>\|:IndentLinesDisable<CR>
