local colors = require("core.default-config").ui.colors

local M = {}

M.branch = {
	"branch",
	icon = " ",
	color = { fg = colors.pink },
	padding = { left = 1, right = 1 },
}

M.diff = {
	"diff",
	colored = true,
	diff_color = {
		added = "DiagnosticSignInfo", -- Changes the diff's added color
		modified = "DiagnosticSignWarn", -- Changes the diff's modified color
		removed = "DiagnosticSignError", -- Changes the diff's removed color you
	},
	symbols = { added = " ", modified = " ", removed = " " },
}

return M
