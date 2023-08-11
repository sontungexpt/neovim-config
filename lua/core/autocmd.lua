local api = vim.api
local autocmd = api.nvim_create_autocmd
local create_augroup = api.nvim_create_augroup

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
		api.nvim_set_current_dir(file_path)

		local nvim_folder = vim.fn.stdpath("config")

		if file_path:match("^" .. nvim_folder) then
			api.nvim_set_current_dir(nvim_folder)
		end
	end,
})

autocmd({ "BufWritePost" }, {
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

		local curr_dir = vim.fn.expand("%:p:h")
		local file_path = vim.fn.expand("%:p")
		local file_name = vim.fn.expand("%:t")

		local home_path = string.sub(vim.fn.stdpath("config"), 1, -13)
		local sys_scripts_dir = home_path .. "scripts/stilux/systems"
		local sys_build_dir = home_path .. "scripts/stilux/systems-build"

		if curr_dir:match("^" .. sys_scripts_dir) then
			local copy_file_path = sys_build_dir .. "/" .. file_name

			local command = string.format(
				"mkdir -p %s && cp %s %s && sed -i -e 's/\\(sudo \\)\\?yay -S \\(\\S.*\\)/eval \"$YAY \\2\"/g' %s && sed -i -e 's/\\(sudo \\)\\?pacman -S \\(\\S.*\\)/eval \"$PACMAN \\2\"/g' %s",
				sys_build_dir,
				file_path,
				copy_file_path,
				copy_file_path,
				copy_file_path
			)

			vim.fn.jobstart(command, {
				on_exit = function(_, exit_code, _)
					if exit_code == 0 then
						vim.schedule(function()
							check_and_insert_lines(copy_file_path)
						end)
					else
						print("Lỗi khi chạy lệnh hệ thống")
					end
				end,
			})
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
	group = create_augroup("EnableSyntax", {}),
	pattern = { "*.json" },
	command = "set filetype=jsonc",
})

--Enable syntax for .rasi files
autocmd({ "BufEnter" }, {
	group = create_augroup("EnableSyntax", {}),
	pattern = { "*.rasi" },
	command = "set filetype=rasi",
})

autocmd({ "BufEnter" }, {
	group = create_augroup("EnableSyntax", {}),
	pattern = "*.html",
	command = "set filetype=html",
})

autocmd({ "BufEnter" }, {
	group = create_augroup("EnableSyntax", {}),
	pattern = "*.env",
	callback = function(args)
		vim.diagnostic.disable(args.buf)
	end,
})
