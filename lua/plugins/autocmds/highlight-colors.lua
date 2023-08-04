local M = {}

M.has_highlight_colors = function()
	return vim.fn.isdirectory(vim.fn.stdpath("data") .. "/lazy/nvim-highlight-colors")
end

M.create_autocmds = function()
	if not M.has_highlight_colors() then
		return
	end

	vim.api.nvim_create_autocmd("BufEnter", {
		group = vim.api.nvim_create_augroup("HighlightColorsAutoGroup", {}),
		pattern = "*",
		command = "HighlightColorsOn",
	})
end

return M
