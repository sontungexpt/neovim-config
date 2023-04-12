Plug 'anuvyklack/animation.nvim'
Plug 'anuvyklack/middleclass'
Plug 'anuvyklack/windows.nvim'


"----------Winodws---------"
function SetupWindows()
lua<<EOF

  local function cmd(command)
      return table.concat({ '<Cmd>', command, '<CR>' })
  end
 -- Mappings
  vim.keymap.set('n', '<leader>wm', cmd 'WindowsMaximize')
  vim.keymap.set('n', '_', cmd 'WindowsMaximizeVertically')
  vim.keymap.set('n', '|', cmd 'WindowsMaximizeHorizontally')
  vim.keymap.set('n', '=', cmd 'WindowsEqualize')

  -- Setups
  vim.o.winwidth = 8
  vim.o.winminwidth = 8

  require("windows").setup({
      autowidth = {			--		       |windows.autowidth|
          enable = false,
          winwidth = 20,			--		 |windows.winwidth|
          filetype = {			--	     |windows.autowidth.filetype|
          help = 2,
        },
      },
      ignore = {				--			  |windows.ignore|
          buftype = { "quickfix", "NvimTree" },
          filetype = { "NvimTree", "neo-tree", "undotree", "gundo" }
      },
      animation = {
          enable = true,
          duration = 100,
          fps = 30,
          easing = "in_out_sine"
      },
  })
EOF
endfunction

" Run windows setup options when neovim loaded
augroup OverrideWindows
  autocmd!
  autocmd User PlugLoaded call SetupWindows()
augroup END
