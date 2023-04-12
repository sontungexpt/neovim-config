Plug 'kylechui/nvim-surround'

"  Default Mappings
"  surr*ound_words             ysiw)           (surround_words)
"  *make strings               ys$"            "make strings"
"  [delete ar*ound me!]        ds]             delete around me!
"  remove <b>HTML t*ags</b>    dst             remove HTML tags
"  'change quot*es'            cs'"            "change quotes"
"  <b>or tag* types</b>        csth1<CR>       <h1>or tag types</h1>
"  delete(functi*on calls)     dsf             function calls


function SetUpNvimSurround()
lua<<EOF
    require("nvim-surround").setup({})
EOF
endfunction

" Run the setup options when neovim loaded
augroup OverrideNvimSurround
    autocmd!
    autocmd User PlugLoaded call SetUpNvimSurround()
augroup END


