local api = vim.api
local map = require("core.utils").map

local options = {
	-- size can be a number or function which is passed the current terminal
	size = function(term)
		if term.direction == "horizontal" then
			return 15
		elseif term.direction == "vertical" then
			return vim.o.columns * 0.4
		end
	end,
	open_mapping = [[<C-t>]],
	on_open = function(term)
		-- mappings
		local bufnr = term.bufnr
		map("n", "q", "<cmd>close<CR>", { buffer = bufnr })
		map("t", "<esc>", [[<C-\><C-n>]], { buffer = bufnr })
		map("t", "jj", [[<C-\><C-n>]], { buffer = bufnr })
		map("t", "<C-h>", [[<Cmd>wincmd h<CR>]], { buffer = bufnr })
		map("t", "<C-j>", [[<Cmd>wincmd j<CR>]], { buffer = bufnr })
		map("t", "<C-k>", [[<Cmd>wincmd k<CR>]], { buffer = bufnr })
		map("t", "<C-l>", [[<Cmd>wincmd l<CR>]], { buffer = bufnr })
		map("t", "<C-w>", [[<C-\><C-n><C-w>]], { buffer = bufnr })
		map("t", "<C-t>", [[<Cmd>exe v:count1 . "ToggleTerm"<CR>]], { buffer = bufnr })

		api.nvim_command("startinsert")
	end,
	on_close = function(term)
		api.nvim_command("stopinsert")
	end,
	highlights = {
		-- highlights which map to a highlight group name and a table of it's values
		-- NOTE: this is only a subset of values,
		-- any group placed here will be set for the terminal window split
		Normal = {
			link = "Normal",
		},
		NormalFloat = {
			link = "Normal",
		},
		FloatBorder = {
			-- guifg = <VALUE-HERE>,
			-- guibg = <VALUE-HERE>,
			link = "FloatBorder",
		},
	},
	-- hide the number column in toggleterm buffers
	hide_numbers = true,
	-- when neovim changes it current directory
	-- the terminal will change it's own when next it's opened
	autochdir = true,
	shade_filetypes = {},
	shade_terminals = false,
	-- the degree by which to darken to terminal colour,
	-- default: 1 for dark backgrounds, 3 for light
	shading_factor = 1,
	start_in_insert = true,
	insert_mappings = true, -- whether or not the open mapping applies in insert mode
	persist_size = true,
	direction = "horizontal", -- | 'horizontal' | 'horizontal' | 'tab' | 'float',,
	close_on_exit = true, -- close the terminal window when the process exits
	shell = vim.o.shell, -- change the default shell
	auto_scroll = true,
	-- This field is only relevant if direction is set to 'float'
	float_opts = {
		border = "single", -- single/double/shadow/curved
		width = math.floor(0.9 * vim.fn.winwidth(0)),
		height = math.floor(0.85 * vim.fn.winheight(0)),
		winblend = 3,
	},
	winbar = {
		enabled = false,
		name_formatter = function(term) --  term: Terminal
			return ""
		end,
	},
}

return options
