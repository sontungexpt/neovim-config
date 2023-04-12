Plug 'brenoprata10/nvim-highlight-colors'

"----------Highlight Color----------"
function SetHighlightColor()
lua <<EOF
  require("nvim-highlight-colors").setup {
    render = 'background', -- or 'foreground' or 'first_column'
    enable_named_colors = true,
    enable_tailwind = true
  }
EOF
endfunction


" Run the hightlight-colors setup options when neovim loaded
augroup HighlightColorOvverides
  autocmd!
  autocmd User PlugLoaded call SetHighlightColor()
augroup END

" Enable hightlight-colors when open neovim 
autocmd VimEnter * HighlightColorsOn


