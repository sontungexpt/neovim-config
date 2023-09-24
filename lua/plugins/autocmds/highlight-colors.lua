local M = {}

local utils = require("core.utils")
local config = require("core.default-config")
local api = vim.api

M.create_autocmds = function()
	if not utils.is_plugin_installed("nvim-highlight-colors") then
		return
	end

	api.nvim_create_autocmd("BufEnter", {
		group = api.nvim_create_augroup("HighlightColorsAutoGroup", {}),
		pattern = "*",
		callback = function()
			local file_name = api.nvim_buf_get_name(0)
			for _, pattern in ipairs(config.binary_file_patterns) do
				if file_name:match(pattern) then
					api.nvim_command("HighlightColorsOff")
					return
				end
			end
			api.nvim_command("HighlightColorsOn")
		end,
	})
end

return M
