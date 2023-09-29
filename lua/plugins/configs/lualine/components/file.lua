local colors = require("core.default-config").ui.colors
local section_separators = require("core.default-config").ui.lualine.options.section_separators
local M = {}

M.type = {
	"filetype",
	icon_only = true,
	colored = true,
	padding = { left = 2, right = 1 },
	color = { bg = colors.lualine_bg },
}

M.name = {
	"filename",
	padding = { right = 2 },
	separator = section_separators,
	color = { bg = colors.lualine_bg, fg = colors.orange, gui = "bold" },
	file_status = true,
	newfile_status = false,
	path = 0,
	symbols = {
		modified = "●",
		readonly = " ",
		unnamed = "",
		newfile = " [New]",
	},
}

return M
