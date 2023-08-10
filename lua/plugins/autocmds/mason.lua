local M = {}
local api = vim.api
local fn = vim.fn
local utils = require("core.utils")
local call_cmd = utils.call_cmd

M.is_mason_installed = function()
	local mason_path = fn.stdpath("data") .. "/mason"
	return fn.isdirectory(mason_path) == 1
end

M.print_installed_packages = function()
	local installed_packages = M.get_installed_packages()
	print("Installed mason packages:\n" .. "  -  " .. table.concat(installed_packages, "\n  -  "))
end

M.print_ensured_packages = function()
	local ensured_packages = require("plugins.configs.mason").ensure_installed
	print("Ensured mason packages:\n" .. "  -  " .. table.concat(ensured_packages, "\n  -  "))
end

M.get_installed_packages = function()
	local installed_packages = {}
	local package_path = fn.stdpath("data") .. "/mason/packages/"
	if fn.isdirectory(package_path) == 1 then
		local package_dirs = fn.glob(package_path .. "/*", true, true)
		for _, package_dir in ipairs(package_dirs) do
			local package_name = fn.fnamemodify(package_dir, ":t")
			table.insert(installed_packages, package_name)
		end
	end
	return installed_packages
end

M.had_changed = function()
	local ensured_packages = require("plugins.configs.mason").ensure_installed
	local installed_packages = M.get_installed_packages()
	return not utils.is_same_array(ensured_packages, installed_packages)
end

M.sync_packages = function()
	local ensured_packages = require("plugins.configs.mason").ensure_installed
	local installed_packages = M.get_installed_packages()
	local packages_to_remove = utils.find_unique_items(installed_packages, ensured_packages)
	local packages_to_install = utils.find_unique_items(ensured_packages, installed_packages)

	vim.schedule(function()
		if #packages_to_remove > 0 then
			local command = "MasonUninstall " .. table.concat(packages_to_remove, " ")
			call_cmd(command, {
				success = "Removed unused mason packages",
				error = "MasonUninstall error",
			})
		end
	end)
	vim.schedule(function()
		if #packages_to_install > 0 then
			local command = "MasonInstall " .. table.concat(packages_to_install, " ")
			call_cmd(command, {
				success = "Installed missing mason packages",
				error = "MasonInstall error",
			})
		end
	end)
	vim.schedule(function()
		if #packages_to_install > 0 or #packages_to_remove > 0 then
			call_cmd("MasonUpdate", {
				success = "Mason packages updated",
				error = "MasonUpdate error",
			})
		end
	end)
end

-- Custom cmd to ensure install all mason binaries listed
M.create_user_commands = function()
	if not M.is_mason_installed() then
		return
	end

	api.nvim_create_user_command("MasonShowInstalledPackages", function()
		vim.schedule(function()
			M.print_installed_packages()
		end)
	end, {})

	api.nvim_create_user_command("MasonShowEnsuredPackages", function()
		vim.schedule(function()
			M.print_ensured_packages()
		end)
	end, {})
end

-------------------- Auto commands --------------------
M.create_autocmds = function()
	if not M.is_mason_installed() then
		return
	end
	local enabled = require("plugins.configs.mason").auto_sync
	if not enabled then
		return
	end

	api.nvim_create_autocmd("UIEnter", {
		group = api.nvim_create_augroup("MasonAutoGroup", {}),
		pattern = "",
		callback = function()
			vim.schedule(function()
				if M.had_changed() then
					M.sync_packages()
				end
			end)
		end,
	})
end

return M
