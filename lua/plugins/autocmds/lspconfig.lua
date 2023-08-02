local M = {}

M.lsp_exists = function()
	return vim.lsp ~= nil
end

M.create_autocmds = function()
	if not M.lsp_exists() then
		return
	end

	vim.api.nvim_create_autocmd("BufWritePost", {
		group = vim.api.nvim_create_augroup("LspconfigAutoGroup", {}),
		pattern = {
			".prettierrc",
			".prettierrc.json",
			".prettierrc.yml",
			".prettierrc.yaml",
			".prettierrc.json5",
			".prettierrc.js",
			".prettierrc.cjs",
			".prettierrc.toml",
			"prettier.config.js",
			"prettier.config.cjs",
		},
		command = "LspRestart",
	})
end

return M
