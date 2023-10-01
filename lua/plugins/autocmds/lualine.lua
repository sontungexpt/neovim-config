local utils = require("core.utils")
local api = vim.api

local M = {}

M.create_autocmds = function()
	if not utils.is_plugin_installed("lualine.nvim") then
		return
	end

	api.nvim_create_autocmd({ "VimEnter", "VimResized" }, {
		desc = "Enable the 'noshowmode' option when resizing the window width exceeds 70 if lualine is installed",
		callback = function()
			if vim.o.columns > 70 then
				vim.opt.showmode = false
			else
				vim.opt.showmode = true
			end
		end,
	})
end

return M
