local colors = require("core.default-config").ui.colors
local section_separators = require("core.default-config").ui.lualine.options.section_separators

return {
	"mode",
	separator = section_separators,
	icons_enabled = true,
	cond = function()
		return vim.o.columns > 70
	end,
}
