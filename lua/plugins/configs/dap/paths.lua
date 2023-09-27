local M = {}

M.get_adapter_mason_path = function(adapter_name, custom_path)
	return require("mason-registry").get_package(adapter_name):get_install_path()
		.. "/"
		.. (custom_path or adapter_name)
end

M.get_rust_debug_filepath = function()
	local find_project_root = require("core.utils").find_project_root
	local project_dir = find_project_root()

	-- check if project_dir end with / then remove it
	if string.sub(project_dir, -1) == "/" then
		project_dir = string.sub(project_dir, 1, -2)
	end

	local project_name = vim.fn.fnamemodify(project_dir, ":t")

	local debug_dir = project_dir .. "/target/debug/"
	return debug_dir .. project_name
end

return M
