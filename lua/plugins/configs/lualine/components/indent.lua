local M = {}

M.value = function()
	if vim.o.columns > 70 then
		return "" .. vim.api.nvim_buf_get_option(0, "shiftwidth")
	end
	return ""
end

M.icon = function()
	if vim.o.columns > 70 then
		return "Tab" .. ""
	end
	return ""
end

return M
