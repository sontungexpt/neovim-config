local api = vim.api
local fn = vim.fn
local cmd = api.nvim_command
local autocmd = api.nvim_create_autocmd
local augroup = api.nvim_create_augroup
local map = require("core.utils").map

autocmd({ "VimEnter", "VimLeave" }, {
	pattern = "*",
	command = "runtime! plugin/rplugin.vim",
	desc = "Update remote plugins",
})

autocmd({ "VimEnter", "VimLeave" }, {
	pattern = "*",
	command = "silent! UpdateRemotePlugins",
	desc = "Update remote plugins",
})

autocmd("TextYankPost", {
	command = "silent! lua vim.highlight.on_yank({higroup='IncSearch', timeout=120})",
	desc = "Highlight yanked text",
	group = augroup("YankHighlight", { clear = true }),
})

autocmd("FileType", {
	pattern = "qf",
	command = "set nobuflisted",
	desc = "Don't list quickfix buffers",
})

autocmd({ "VimEnter" }, {
	group = augroup("AutocdConfigFolder", { clear = true }),
	pattern = fn.stdpath("config") .. "/**",
	command = "cd " .. fn.stdpath("config"),
	desc = "Auto change directory to config folder",
})

-- generate build file for scripts in scripts/stilux/systems
autocmd({ "BufWritePost" }, {
	group = augroup("ScriptBuilder", { clear = true }),
	pattern = { "*.sh" },
	callback = function()
		local function check_and_insert_lines(file_name)
			local line1 = 'YAY="yay -S --answerclean All --noconfirm --needed"'
			local line2 = 'PACMAN="sudo pacman -S --noconfirm --needed"'
			local file = io.open(file_name, "r+")
			local lines = {}

			-- a index line begin from 1
			local line_index = 1
			local is_replaced = false
			if file then
				for line in file:lines() do
					if line_index > 1 then
						if not is_replaced and not (line:match("^%s*#")) then
							line = "\n" .. line1 .. "\n" .. line2 .. "\n\n" .. line
							is_replaced = true
						end
					end
					lines[line_index] = line
					line_index = line_index + 1
				end
				local new_content = table.concat(lines, "\n")
				file:seek("set")
				file:write(new_content)
				file:close()
			end
		end

		local curr_dir = fn.expand("%:p:h")
		local sys_scripts_dir = fn.expand("$HOME") .. "/scripts/stilux/systems"

		if curr_dir:match("^" .. sys_scripts_dir) then
			local file_path = fn.expand("%:p")
			local file_name = fn.expand("%:t")
			local sys_build_dir = fn.expand("$HOME") .. "/scripts/stilux/systems-build"
			local copy_file_path = sys_build_dir .. "/" .. file_name

			local command = string.format(
				"mkdir -p %s && cp %s %s && sed -i -e 's/\\(sudo \\)\\?yay -S\\( --needed\\)\\? \\(\\S.*\\)/eval \"$YAY \\3\"/g' %s && sed -i -e 's/\\(sudo \\)\\?pacman -S\\( --needed\\)\\? \\(\\S.*\\)/eval \"$PACMAN \\3\"/g' %s",
				sys_build_dir,
				file_path,
				copy_file_path,
				copy_file_path,
				copy_file_path
			)

			fn.jobstart(command, {
				on_exit = function(_, exit_code, _)
					if exit_code == 0 then
						vim.schedule(function()
							check_and_insert_lines(copy_file_path)
						end)
					else
						print("Error: " .. exit_code)
					end
				end,
			})
		end
	end,
})

autocmd("BufWritePre", {
	pattern = "*",
	command = ":%s/\\s\\+$//e",
	desc = "Remove whitespace on save",
})

autocmd("ModeChanged", {
	pattern = "*",
	command = "if mode() == 'v' | set relativenumber | else | set norelativenumber | endif",
	desc = "Move to relative line number when in visual mode",
})

autocmd({ "BufEnter" }, {
	pattern = "*.json",
	command = "set filetype=jsonc",
	desc = "Enable syntax for .json files",
})

autocmd({ "BufEnter" }, {
	pattern = { "*.rasi" },
	command = "set filetype=rasi",
	desc = "Enable syntax for .rasi files",
})

autocmd({ "BufEnter" }, {
	pattern = "*.html",
	command = "set filetype=html",
	desc = "Enable syntax for .html files",
})

autocmd({ "BufEnter" }, {
	pattern = "*.env",
	callback = function(args)
		vim.diagnostic.disable(args.buf)
	end,
	desc = "Disable diagnostic for .env files",
})

autocmd("VimEnter", {
	desc = "Customize right click contextual menu.",
	group = augroup("ContextualMenu", { clear = true }),
	callback = function()
		-- Disable right click message
		cmd([[aunmenu PopUp.How-to\ disable\ mouse]])
		-- cmd [[aunmenu PopUp.-1-]] -- You can remode a separator like this.
		cmd([[menu PopUp.Toggle\ \Breakpoint <cmd>:lua require('dap').toggle_breakpoint()<CR>]])
		cmd([[menu PopUp.Start\ \Debugger <cmd>:DapContinue<CR>]])
	end,
})

autocmd({ "BufWritePost" }, {
	desc = "When writing a buffer, :NvimReload if the buffer is a config file.",
	group = augroup("ReloadConfigFile", { clear = true }),
	pattern = {
		fn.stdpath("config") .. "/lua/core/options.lua",
		fn.stdpath("config") .. "/lua/core/keymaps.lua",
		fn.stdpath("config") .. "/lua/core/plugins-keymaps.lua",
	},
	command = "NvimReload",
})

autocmd("BufWinEnter", {
	desc = "Make q close help, man, quickfix, dap floats",
	callback = function(args)
		local buftype = api.nvim_get_option_value("buftype", { buf = args.buf })
		if vim.tbl_contains({ "help", "nofile", "quickfix" }, buftype) then
			map("n", "q", "<cmd>close<cr>", { buffer = args.buf, nowait = true })
		end
	end,
})

autocmd("CmdwinEnter", {
	desc = "Make q close command history (q: and q?)",
	command = "nnoremap <silent><buffer><nowait> q :close<CR>",
})

-- Toggle search highlighting on insert mode
autocmd({ "InsertEnter", "TermEnter" }, {
	desc = "Set no search highlighting when entering insert mode, or terminal",
	command = "set nohlsearch",
})

autocmd({ "InsertLeave", "TermLeave" }, {
	desc = "Set search highlighting when leaving insert mode, or terminal",
	command = "set hlsearch",
})

autocmd({ "FocusGained", "BufEnter", "TermResponse" }, {
	command = [[silent! if mode() != 'c' && !bufexists("[Command Line]") | checktime | endif]],
	desc = "Reload file if changed outside of nvim",
})

autocmd("FileType", {
	pattern = { "markdown" },
	desc = "Wrap text in markdown files",
	command = "setlocal wrap",
})
