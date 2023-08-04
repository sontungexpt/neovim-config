local M = {}

local utils = require("core.utils")

M.create_autocmds = function()
	if not utils.is_plugin_installed("nvim-highlight-colors") then
		return
	end

	vim.api.nvim_create_autocmd("BufEnter", {
		group = vim.api.nvim_create_augroup("HighlightColorsAutoGroup", {}),
		pattern = "*",
		command = "HighlightColorsOn",
	})
end

return M
