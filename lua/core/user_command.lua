local new_cmd = vim.api.nvim_create_user_command

local utils = require("core.utils")

new_cmd("NvimReload", function()
	utils.reload_config()
end, { nargs = 0 })

new_cmd("NvimCreatePluginAutocmdFile", function()
	utils.create_plugin_autocmd_file()
end, {})
