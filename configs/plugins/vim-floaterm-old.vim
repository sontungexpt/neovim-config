Plug 'voldikss/vim-floaterm'

" Mappings
" Floaterm toggle"
let g:floaterm_keymap_toggle = '<C-t>'
nnoremap  <silent>   <C-t>            :FloatermToggle<CR>
inoremap  <silent>   <C-t>            <Esc>:FloatermToggle<CR>
vnoremap  <silent>   <C-t>            <Esc>:FloatermToggle<CR>
tnoremap  <silent>   <C-t>            <C-\><C-n>:FloatermToggle<CR>

"" Floaterm new"
let g:floaterm_keymap_new = '<C-n><C-t>'
noremap   <silent>   <C-n><C-t>      :FloatermNew<CR>
inoremap  <silent>   <C-n><C-t>      <Esc>:FloatermNew<CR>

"Floaterm next"
tnoremap  <silent> nnn  <C-\><C-n>   :FloatermNext<CR>

"Floaterm prev"
tnoremap  <silent> bbb <C-\><C-n>    :FloatermPrev<CR>

"Floaterm kill"
tnoremap  <silent> kk <C-\><C-n>     :FloatermKill<CR>\|:FloatermToggle<CR>


" Floaterm appearance"
let g:floaterm_wintype = 'float'
let g:floaterm_title = 'Terminal: $1/$2'
let g:floaterm_width = 0.9
let g:floaterm_shell ='zsh'


