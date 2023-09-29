local colors = require("core.default-config").ui.colors
local section_separators = require("core.default-config").ui.lualine.options.section_separators
local component_separators = require("core.default-config").ui.lualine.options.component_separators

-- Components
local file = require("plugins.configs.lualine.components.file")
local mode = require("plugins.configs.lualine.components.mode")
local indent = require("plugins.configs.lualine.components.indent")
local copilot = require("plugins.configs.lualine.components.copilot")
local location = require("plugins.configs.lualine.components.location")
local lsp_servers = require("plugins.configs.lualine.components.lsp_servers")
local progress_pos = require("plugins.configs.lualine.components.progress_pos")
local encoding = require("plugins.configs.lualine.components.encoding")
local diagnostics = require("plugins.configs.lualine.components.diagnostics")
local git = require("plugins.configs.lualine.components.git")

local options = {
	options = {
		theme = "tokyonight",
		globalstatus = true,
		icons_enabled = true,
		component_separators = component_separators,
		section_separators = section_separators,
		disabled_filetypes = {
			"lazy",
			"NvimTree",
			"mason",
			"toggleterm",
			"help",
			"TelescopePrompt",
		},
		always_divide_middle = true,
		refresh = { -- sets how often lualine should refresh it's contents (in ms)
			statusline = 1000, -- The refresh option sets minimum time that lualine tries
			tabline = 1000, -- to maintain between refresh. It's not guarantied if situation
			winbar = 1000, -- arises that lualine needs to refresh itself before this time
		},
	},
	sections = {
		lualine_a = {
			mode,
		},
		lualine_b = {
			file.type,
			file.name,
		},
		lualine_c = {
			git.branch,
			git.diff,
		},
		lualine_x = {
			diagnostics,
			lsp_servers,
			copilot,
			indent.icon,
			indent.value,
			encoding,
			location,
			progress_pos,
		},
		lualine_y = {},
		lualine_z = {},
	},
}

return options
