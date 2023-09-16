local indent = function()
	return "" .. vim.api.nvim_buf_get_option(0, "shiftwidth")
end

return indent
