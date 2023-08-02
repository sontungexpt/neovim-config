local plugin_filenames = {
	"mason",
	"treesitter",
	"git-conflict",
	"highlight-colors",
	"lspconfig",
	"copilot",
	--'nvim-focus',
}

for _, plugin_name in ipairs(plugin_filenames) do
	local plugin_status_ok, plugin = pcall(require, "plugins.autocmds." .. plugin_name)
	if plugin_status_ok then
		plugin.create_autocmds()
	end
end
