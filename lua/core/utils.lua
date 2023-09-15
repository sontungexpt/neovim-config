local api = vim.api
local fn = vim.fn

local logger = require("core.logger")
local default_config = require("core.default-config")

local M = {}

M.load_config = function()
	return default_config
end

---
-- @tparam string command: The command to execute
-- @tparam table msg: The message to print on success or error
M.call_cmd = function(command, msg)
	local success, error_message = pcall(api.nvim_command, command)
	if success then
		if msg and msg.success then
			logger.info(msg.success)
		else
			logger.info("Success")
		end
	else
		if msg and msg.error then
			logger.error(msg.error .. ": " .. error_message)
		else
			logger.error("Error: " .. error_message)
		end
	end
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

---
-- default opts = 1
-- opts = 1 for noremap and silent
-- opts = 2 for not noremap and silent
-- opts = 3 for noremap and not silent
-- opts = 4 for not noremap and not silent
-- opts = 5 for expr and noremap and silent
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
	else
		opts = opts1
	end
	vim.keymap.set(mode, key, map_to, opts)
end

M.find_project_root = function(current_path)
	current_path = current_path or fn.expand("%:p:h")
	while current_path ~= "/" do
		for _, file in ipairs(default_config.root_files) do
			local file_path = fn.findfile(file, current_path)
			if file_path ~= "" then
				return current_path
			end
		end
		current_path = fn.fnamemodify(current_path, ":h")
	end
	return ""
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
	-- Reload options, mappings and plugins (this is managed automatically by lazy).
	-- Never reload autocmds to avoid issues.
	local was_modifiable = vim.opt.modifiable:get()
	if not was_modifiable then
		vim.opt.modifiable = true
	end

	local core_modules = { "core.options", "core.keymaps", "core.plugins-keymaps" }
	local modules = vim.tbl_filter(function(module)
		return module:find("^user%.")
	end, vim.tbl_keys(package.loaded))

	vim.tbl_map(require("plenary.reload").reload_module, vim.list_extend(modules, core_modules))
	local success = true
	for _, module in ipairs(core_modules) do
		local status_ok, fault = pcall(require, module)
		if not status_ok then
			api.nvim_err_writeln("Failed to load " .. module .. "\n\n" .. fault)
			success = false
		end
	end
	if not was_modifiable then
		vim.opt.modifiable = false
	end
	if not quiet then -- if not quiet, then notify of result.
		if success then
			logger.info("Nvim successfully reloaded")
		else
			logger.error("Error reloading Nvim...")
		end
	end
	api.nvim_command([[colorscheme tokyonight]])
	api.nvim_command([[let g:lightline = {'colorscheme': 'tokyonight'}]])
	vim.cmd.doautocmd("ColorScheme") -- sFor heirline.

	return success
end

return M
