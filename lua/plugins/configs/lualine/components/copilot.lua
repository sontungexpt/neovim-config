local colors = require("core.default-config").ui.colors
local section_separators = require("core.default-config").ui.lualine.options.section_separators

return {
	function()
		return package.loaded["copilot_status"] and require("copilot_status").status_string() or ""
	end,
	cnd = function()
		return package.loaded["copilot_status"] and require("copilot_status").enabled()
	end,
	separator = section_separators,
	color = { bg = colors.lualine_bg, fg = colors.fg },
}
