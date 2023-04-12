Plug 'uga-rosa/ccc.nvim'
"  https://github.com/uga-rosa/ccc.nvim

" Mappings
nnoremap <silent> <A-c> :CccPick<cr>

"----------ccc.nvim----------"
function SetUpCCC()
lua<<EOF
    local ccc = require("ccc")
	local mapping = ccc.mapping
	ccc.setup({
		-- Your favorite settings
	})
EOF
endfunction


" Run ccc setup options when neovim loaded
augroup CCCOverrides
    autocmd!
    autocmd User PlugLoaded call SetUpCCC()
augroup END
