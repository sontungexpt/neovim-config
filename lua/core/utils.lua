local api = vim.api
local fn = vim.fn

local logger = require("core.logger")
local default_config = require("core.default-config")

local M = {}

M.load_config = function()
	return default_config
end

---
--- @tparam string command: The command to execute
--- @tparam table msg: The message to print on success or error
M.call_cmd = function(command, msg, quiet)
	local success, error_message = pcall(api.nvim_command, command)
	if not quiet then
		if success then
			logger.info(msg and msg.success or command .. " execute success")
		else
			logger.error((msg and msg.error or "Error") .. ": " .. error_message)
		end
	end
	return success
end

M.is_plugin_installed = function(plugin_name)
	return fn.isdirectory(fn.stdpath("data") .. "/lazy/" .. plugin_name) == 1
end

M.lazy_load = function(plugin)
	api.nvim_create_autocmd({ "BufRead", "BufWinEnter", "BufNewFile" }, {
		group = api.nvim_create_augroup("BeLazyOnFileOpen" .. plugin, {}),
		callback = function()
			local file = fn.expand("%")
			local condition = file ~= "NvimTree_1" and file ~= "[lazy]" and file ~= ""

			if condition then
				api.nvim_del_augroup_by_name("BeLazyOnFileOpen" .. plugin)

				-- dont defer for treesitter as it will show slow highlighting
				-- This deferring only happens only when we do "nvim filename"
				if plugin ~= "nvim-treesitter" then
					vim.schedule(function()
						require("lazy").load { plugins = plugin }

						if plugin == "nvim-lspconfig" then
							api.nvim_command("silent! do FileType")
						end
					end, 0)
				else
					require("lazy").load { plugins = plugin }
				end
			end
		end,
	})
end

M.lazy_load_git_plugin = function(plugin)
	api.nvim_create_autocmd({ "BufRead" }, {
		group = api.nvim_create_augroup("LazyLoad" .. plugin, { clear = true }),
		callback = function()
			fn.system("git -C " .. '"' .. vim.fn.expand("%:p:h") .. '"' .. " rev-parse")
			if vim.v.shell_error == 0 then
				api.nvim_del_augroup_by_name("LazyLoad" .. plugin)
				vim.schedule(function()
					require("lazy").load { plugins = plugin }
				end)
			end
		end,
	})
end

---
-- default opts = 1
-- opts = 1 for noremap and silent
-- opts = 2 for not noremap and silent
-- opts = 3 for noremap and not silent
-- opts = 4 for not noremap and not silent
-- opts = 5 for expr and noremap and silent
-- opts = 6 for noremap and silent and nowait
M.map = function(mode, key, map_to, opts)
	local opts1 = { noremap = true, silent = true }
	opts = opts or 1
	if type(opts) == "table" then
		opts = vim.tbl_deep_extend("force", opts1, opts)
		vim.keymap.set(mode, key, map_to, opts)
		return
	end

	if opts == 1 then
		opts = opts1
	elseif opts == 2 then
		opts = { noremap = false, silent = true }
	elseif opts == 3 then
		opts = { noremap = true, silent = false }
	elseif opts == 4 then
		opts = { noremap = false, silent = false }
	elseif opts == 5 then
		opts = { expr = true, replace_keycodes = true, noremap = true, silent = true }
	elseif opts == 6 then
		opts = { noremap = true, silent = true, nowait = true }
	else
		opts = opts1
	end
	vim.keymap.set(mode, key, map_to, opts)
end

M.find_project_root = function(current_path)
	return vim.fs.dirname(vim.fs.find(default_config.root_files, { upward = true })[1])
end

M.is_same_array = function(table1, table2) -- O(n)
	if #table1 ~= #table2 then
		return false
	end

	local t1_counts = {}

	for _, v1 in ipairs(table1) do
		t1_counts[v1] = (t1_counts[v1] or 0) + 1
	end

	for _, v2 in ipairs(table2) do
		local count = t1_counts[v2] or 0
		if count == 0 then
			return false
		end
		t1_counts[v2] = count - 1
	end
	return true
end

M.find_unique_items = function(table1, table2)
	if #table2 == 0 then
		return table1
	end

	local not_exists = {}
	local t2_counts = {}

	for _, v2 in ipairs(table2) do
		t2_counts[v2] = (t2_counts[v2] or 0) + 1
	end

	for _, v1 in ipairs(table1) do
		local count = t2_counts[v1] or 0
		if count == 0 then
			table.insert(not_exists, v1)
		end
	end

	return not_exists
end

M.reload_config = function(quiet)
	-- Reload options, mappings
	local core_modules = { "core.options", "core.keymaps", "core.plugins-keymaps" }

	local failed_modules = {}
	for _, module in ipairs(core_modules) do
		package.loaded[module] = nil
		local status_ok, m = pcall(require, module)
		if not status_ok then
			table.insert(failed_modules, m)
		end
	end

	vim.cmd.doautocmd("ColorScheme")

	if not quiet then -- if not quiet, then notify of result.
		if #failed_modules == 0 then
			logger.info("Reloaded options and keymaps successfully")
		else
			logger.error("Error while reloading core modules: " .. table.concat(failed_modules, "\n"))
		end
	end
end

M.is_terminal = function(terminal_name)
	local term = vim.env.TERM or ""
	return term:lower() == terminal_name
end

M.switch_language_engine = function(engine)
	local current_engine = fn.system("ibus engine"):gsub("%s+", "")
	if current_engine ~= engine then
		local engines = fn.system("ibus list-engine"):gsub("%s+", "")
		if engines:find(engine) then
			fn.system("ibus engine " .. engine)
		else
			logger.error("Engine not found: " .. engine)
		end
	end
end

return M
