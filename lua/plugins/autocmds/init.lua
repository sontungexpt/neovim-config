local files = vim.fn.glob(vim.fn.stdpath("config") .. "/lua/plugins/autocmds/*.lua", true, true)

for _, file in ipairs(files) do
	local filename = vim.fn.fnamemodify(file, ":t:r")

	if filename ~= "init" then
		local status_ok, plugin = pcall(require, "plugins.autocmds." .. filename)
		if status_ok and type(plugin.create_autocmds) == "function" then
			plugin.create_autocmds()
		end
	end
end
