if has('nvim')
  function! UpdateRemotePlugins(...)
    " Needed to refresh runtime files
    let &rtp=&rtp
    UpdateRemotePlugins
  endfunction
  Plug 'gelguy/wilder.nvim', { 'do': function('UpdateRemotePlugins') }
else
  Plug 'gelguy/wilder.nvim'
  "To use Python remote plugin features in Vim, can be skipped"
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif


"Default keys"

function SetupWilder()
  call wilder#setup({
    \ 'modes': [':', '/', '?'],
    \ 'next_key': '<Tab>',
    \ 'previous_key': '<S-Tab>',
    \ 'accept_key': '<Down>',
    \ 'reject_key': '<Up>',
    \ 'enable_cmdline_enter': 1,
  \ })
  call wilder#set_option('renderer', wilder#popupmenu_renderer(wilder#popupmenu_palette_theme({
    \ 'border': 'rounded',
    \ 'max_height': '75%',
    \ 'min_height': 0,
    \ 'prompt_position': 'top',
    \ 'reverse': 0,
    \ })))
endfunction


" Run the wilder setup options when neovim loaded
augroup WilderOvverides
    autocmd!
    autocmd User PlugLoaded call SetupWilder()
augroup END



