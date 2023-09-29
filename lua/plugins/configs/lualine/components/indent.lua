local colors = require("core.default-config").ui.colors
local section_separators = require("core.default-config").ui.lualine.options.section_separators

local M = {}

M.value = {
	function()
		if vim.o.columns > 70 then
			return "" .. vim.api.nvim_buf_get_option(0, "shiftwidth")
		end
		return ""
	end,
	padding = 1,
	separator = section_separators,
	color = { bg = colors.lualine_bg, fg = colors.magenta },
}

M.icon = {
	function()
		if vim.o.columns > 70 then
			return "Tab" .. ""
		end
		return ""
	end,

	padding = 1,
	separator = section_separators,
	color = { bg = colors.blue, fg = colors.black },
}

return M
