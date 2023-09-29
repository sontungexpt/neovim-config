local colors = require("core.default-config").ui.colors
local no_seps = require("core.default-config").ui.lualine.no_seps

return {
	"mode",
	separator = no_seps,
	icons_enabled = true,
	cond = function()
		return vim.o.columns > 70
	end,
}
