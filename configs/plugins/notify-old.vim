Plug 'rcarriga/nvim-notify'
" https://github.com/rcarriga/nvim-notify

function SetupNotify()
lua<<EOF
  vim.notify = require("notify")
EOF
endfunction
