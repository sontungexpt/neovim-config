local indent = function()
	if vim.api.nvim_get_option("columns") > 70 then
		return "" .. vim.api.nvim_buf_get_option(0, "shiftwidth")
	end
	return ""
end

return indent
