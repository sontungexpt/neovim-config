"back to normal mode
imap <silent> jj <esc>
cmap <silent> jj <esc>
smap <silent> <C-e> <esc>

"back to insert mode
vmap i <esc>i

" Save file the traditional way
imap <C-s> <esc>:w<cr>
nmap <C-s> :w <cr>
vmap <C-s> <esc>:w<cr>
cmap <C-s> <esc>:w<cr>

"Move  to the commad mode when in visual mode
vmap : <esc>:

"The arrow keys in the insert mode"
imap <silent> <A-j> <Down>
imap <silent> <A-k> <Up>
imap <silent> <A-h> <Left>
imap <silent> <A-l> <Right>

"ctrl z to undo
inoremap <C-z> <C-O>u
nnoremap <C-z> u
vnoremap <C-z> <C-O>u

" ctrl a to selected all text in file
noremap <C-a> <esc>gg0v$G
inoremap <C-a> <esc>gg0v$G

"change the buffer"
nnoremap <silent> gt :bnext<CR>
nnoremap <silent> gT :bNext<CR>

" Go to the current path
nnoremap cd :cd %:p:h<CR>
vnoremap cd :cd %:p:h<CR>

" Close Buffer
nnoremap <silent> Q :bd<CR>
vnoremap <silent> Q :bd<CR>

" Open the link
nnoremap <silent> gx :execute 'silent! !xdg-open ' . shellescape(expand('<cWORD>'), 1)<cr>
vnoremap <silent> gx :execute 'silent! !xdg-open ' . shellescape(expand('<cWORD>'), 1)<cr>

" Clean searching
nnoremap <silent> C :noh<CR>
vnoremap <silent> C :noh<CR>

" Resize Buffer
noremap <silent> <C-j> :resize +1<CR>
noremap <silent> <C-k> :resize -1<CR>
noremap <silent> <C-l> :vertical resize -1<CR>
noremap <silent> <C-h> :vertical resize +1<CR>


" Layout
"change the layout to horizontal
noremap <silent> <leader>tv <C-w>t<C-w>H
"change the layout to vertical
noremap <silent> <leader>th <C-w>t<C-w>K

" Refresh nvim config
noremap <leader>c :sgource ~/.config/nvim/init.vim<CR>

