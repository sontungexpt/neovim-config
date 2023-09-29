local colors = require("core.default-config").ui.colors
local section_separators = require("core.default-config").ui.lualine.options.section_separators

local encoding = function()
	-- get encoding and replace
	-- utf8 with  (U+F75E)
	-- utf16 with  (U+F75F)
	-- utf32 with  (U+F780)
	-- utf8mb4 with  (U+F781)
	-- utf16le with  (U+F782)
	-- utf16be with  (U+F783)
	-- https://www.nerdfonts.com/cheat-sheet
	local enc = vim.bo.fenc ~= "" and vim.bo.fenc or vim.o.enc
	if enc == "utf-8" then
		return ""
	elseif enc == "utf-16" then
		return ""
	elseif enc == "utf-32" then
		return ""
	elseif enc == "utf-8mb4" then
		return ""
	elseif enc == "utf-16le" then
		return ""
	elseif enc == "utf-16be" then
		return ""
	else
		return enc
	end
end

return {
	encoding,
	separator = section_separators,
	padding = 1,
	color = { bg = colors.yellow, fg = colors.black },
}
