local api = vim.api
local fn = vim.fn
local autocmd = api.nvim_create_autocmd
local augroup = api.nvim_create_augroup

-- Highlight on yank
autocmd("TextYankPost", {
	group = augroup("YankHighlight", { clear = true }),
	callback = function()
		vim.highlight.on_yank { higroup = "IncSearch", timeout = "120" }
	end,
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
	group = augroup("contextual_menu", { clear = true }),
	callback = function()
		-- Disable right click message
		vim.api.nvim_command([[aunmenu PopUp.How-to\ disable\ mouse]])
		-- vim.api.nvim_command [[aunmenu PopUp.-1-]] -- You can remode a separator like this.
		vim.api.nvim_command(
			[[menu PopUp.Toggle\ \Breakpoint <cmd>:lua require('dap').toggle_breakpoint()<CR>]]
		)
		vim.api.nvim_command([[menu PopUp.Start\ \Debugger <cmd>:DapContinue<CR>]])
	end,
})

autocmd({ "BufWritePost" }, {
	desc = "When writing a buffer, :NvimReload if the buffer is a config file.",
	group = augroup("reload_if_buffer_is_config_file", { clear = true }),
	pattern = fn.stdpath("config") .. "/*.lua",
	command = "NvimReload",
})
