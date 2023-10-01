local M = {}
local utils = require("core.utils")

M.has_copilot_auth = function()
	local copilot_path = vim.fn.expand("$HOME") .. "/.config/github-copilot"
	return vim.fn.isdirectory(copilot_path) == 1
end

M.create_autocmds = function()
	local status_ok, config = pcall(require, "plugins.configs.copilot")
	if (not status_ok) or (config.auto_check_auth == false) then
		return
	end

	if not utils.is_plugin_installed("copilot.lua") then
		return
	end

	vim.api.nvim_create_autocmd({ "InsertEnter" }, {
		pattern = "*",
		group = vim.api.nvim_create_augroup("CopilotAutoGroup", {}),
		callback = function()
			if not M.has_copilot_auth() then
				vim.schedule(function()
					vim.api.nvim_command("Copilot auth")
				end)
			end
		end,
	})
end

return M
