local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	return
end
local colors = require("core.default-config").ui.colors
local section_separators = require("core.default-config").ui.lualine.options.section_separators
local component_separators = require("core.default-config").ui.lualine.options.component_separators

-- Components
local indent = require("plugins.configs.lualine.components.indent")
local copilot = require("plugins.configs.lualine.components.copilot")
local lsp_servers = require("plugins.configs.lualine.components.lsp_servers")
local progress_pos = require("plugins.configs.lualine.components.progress_pos")
local encoding = require("plugins.configs.lualine.components.encoding")

lualine.setup {
	options = {
		theme = "tokyonight",
		globalstatus = true,
		icons_enabled = true,
		component_separators = component_separators,
		section_separators = section_separators,
		disabled_filetypes = {
			"lazy",
			"floaterm",
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
			{
				"mode",
				separator = section_separators,
				icons_enabled = true,
				cond = function()
					return vim.api.nvim_get_option("columns") > 70
				end,
			},
		},
		lualine_b = {
			{
				"filetype",
				icon_only = true,
				colored = true,
				padding = { left = 2, right = 1 },
				color = { bg = colors.lualine_bg },
			},
			{
				"filename",
				padding = { right = 2 },
				separator = section_separators,
				color = { bg = colors.lualine_bg, fg = colors.orange, gui = "bold" },
				file_status = true,
				newfile_status = false,
				path = 0,
				symbols = {
					modified = "●",
					readonly = " ",
					unnamed = "",
					newfile = " [New]",
				},
			},
		},
		lualine_c = {
			{
				"branch",
				icon = " ",
				color = { fg = colors.pink },
				padding = { left = 1, right = 1 },
			},
			{
				"diff",
				colored = true,
				diff_color = {
					added = "DiagnosticSignInfo", -- Changes the diff's added color
					modified = "DiagnosticSignWarn", -- Changes the diff's modified color
					removed = "DiagnosticSignError", -- Changes the diff's removed color you
				},
				symbols = { added = " ", modified = " ", removed = " " },
			},
		},
		lualine_x = {
			{
				"diagnostics",
				sources = { "nvim_diagnostic" },
				symbols = {
					error = " ",
					warn = " ",
					hint = "󰌵 ",
					info = " ",
				},
				colored = true,
				diagnostics_color = {
					color_error = { fg = colors.red },
					color_warn = { fg = colors.yellow },
					color_info = { fg = colors.blue },
					color_hint = { fg = colors.green },
				},
				always_visible = false,
				update_in_insert = true,
			},
			{
				lsp_servers,
				color = { fg = colors.magenta },
			},
			{
				copilot,
				color = { fg = colors.white },
			},
			{
				function()
					if vim.api.nvim_get_option("columns") > 70 then
						return "Tab" .. ""
					end
					return ""
				end,
				padding = 1,
				separator = section_separators,
				color = { bg = colors.blue, fg = colors.black },
			},
			{
				indent,
			},
			{
				encoding,
				separator = section_separators,
				padding = 1,
				color = { bg = colors.yellow, fg = colors.black },
			},

			{
				"location",
				padding = 1,
				separator = section_separators,
			},

			{
				progress_pos,
				padding = 0,
				color = { bg = colors.lualine_bg, fg = colors.orange },
			},
		},
		lualine_y = {},
		lualine_z = {},
	},
}
