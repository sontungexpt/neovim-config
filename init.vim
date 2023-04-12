for f in split(glob('~/.config/nvim/configs/*.vim'), '\n')
   exe 'source' f
endfor


"host-provider"
let g:python3_host_prog = '/usr/bin/python3'
let g:ruby_host_prog = '~/.rbenv/versions/3.2.0/bin/neovim-ruby-host'
let g:loaded_perl_provider = 0

