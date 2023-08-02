local autocmd = vim.api.nvim_create_autocmd

-- Don't list quickfix buffers
autocmd("FileType", {
	pattern = "qf",
	command = "set nobuflisted",
})

-- auto change directory to config folder
autocmd({ "VimEnter" }, {
	pattern = { "*" },
	callback = function()
		local file_path = vim.fn.expand("%:p:h")
		vim.api.nvim_set_current_dir(file_path)

		local nvim_folder = vim.fn.stdpath("config")

		if file_path:match("^" .. nvim_folder) then
			vim.api.nvim_set_current_dir(nvim_folder)
		end
	end,
})

--Remove whitespace on save
autocmd("BufWritePre", {
	pattern = "*",
	command = ":%s/\\s\\+$//e",
})

-- Move to relative line number when in visual mode
autocmd("ModeChanged", {
	pattern = "*",
	command = "if mode() == 'v' | set relativenumber | else | set norelativenumber | endif",
})

--Enable syntax for .json files
autocmd({ "BufEnter" }, {
	group = vim.api.nvim_create_augroup("EnableSyntax", {}),
	pattern = { "*.json" },
	command = "set filetype=jsonc",
})

--Enable syntax for .rasi files
autocmd({ "BufEnter" }, {
	group = vim.api.nvim_create_augroup("EnableSyntax", {}),
	pattern = { "*.rasi" },
	command = "set filetype=rasi",
})

autocmd({ "BufEnter" }, {
	group = vim.api.nvim_create_augroup("EnableSyntax", {}),
	pattern = "*.html",
	command = "set filetype=html",
})

autocmd({ "BufEnter" }, {
	group = vim.api.nvim_create_augroup("EnableSyntax", {}),
	pattern = "*.env",
	callback = function(args)
		vim.diagnostic.disable(args.buf)
	end,
})
