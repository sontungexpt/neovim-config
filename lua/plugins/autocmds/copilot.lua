local M = {}

M.has_copilot = function()
	return vim.fn.isdirectory(vim.fn.stdpath("data") .. "/lazy/copilot.lua")
end

M.has_copilot_auth = function()
	local config_path = vim.fn.stdpath("config")
	local copilot_path = string.sub(config_path, 1, -5) .. "/github-copilot"
	return vim.fn.isdirectory(copilot_path) == 1
end

M.create_autocmds = function()
	local status_ok, config = pcall(require, "plugins.configs.copilot")
	if (not status_ok) or (config.auto_check_auth == false) then
		return
	end

	if not M.has_copilot() then
		return
	end

	vim.api.nvim_create_autocmd("VimEnter", {
		pattern = "*",
		group = vim.api.nvim_create_augroup("CopilotAutoGroup", {}),
		callback = function()
			if not M.has_copilot_auth() then
				vim.cmd("Copilot auth")
			end
		end,
	})
end

return M
