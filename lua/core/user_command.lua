local create_user_command = vim.api.nvim_create_user_command
local schedule = vim.schedule

local utils = require("core.utils")

create_user_command("NvimReload", function()
	utils.reload_config()
end, {})
