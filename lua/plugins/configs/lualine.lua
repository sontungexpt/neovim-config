local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	return
end
local colors = require("core.default-config").ui.colors
local section_separators = require("core.default-config").ui.lualine.options.section_separators
local component_separators = require("core.default-config").ui.lualine.options.component_separators

local diagnostics = {
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
}

local branch = {
	"branch",
	icon = " ",
	color = { fg = colors.pink },
	padding = { left = 2, right = 1 },
}

local diff = {
	"diff",
	colored = false,
	symbols = { added = " ", modified = " ", removed = " " },
}

local location = {
	"location",
	padding = 1,
}

local modes = {
	"mode",
	separator = section_separators,
}

local indent = function()
	return "" .. vim.api.nvim_buf_get_option(0, "shiftwidth")
end

local copilot = function()
	for _, client in pairs(vim.lsp.get_active_clients()) do
		if client.name == "copilot" then
			return "   "
		end
	end
	return ""
end

local my_servers = function()
	local buf_clients = vim.lsp.get_active_clients()
	local buf_ft = vim.bo.filetype

	if not buf_clients or #buf_clients == 0 then
		return "NO LSP  "
	end
	local server_names = {}

	for _, client in pairs(buf_clients) do
		local client_name = client.name
		if client_name ~= "null-ls" and client_name ~= "copilot" then
			local supports_ft = vim.tbl_contains(client.config.filetypes or {}, buf_ft)
			if supports_ft then
				table.insert(server_names, client_name)
			end
		end
	end

	local has_null_ls, null_ls = pcall(require, "null-ls")

	if has_null_ls then
		local null_ls_methods = {
			null_ls.methods.DIAGNOSTICS,
			null_ls.methods.DIAGNOSTICS_ON_OPEN,
			null_ls.methods.DIAGNOSTICS_ON_SAVE,
			null_ls.methods.FORMATTING,
		}

		local get_null_ls_sources = function(methods, name_only)
			local sources = require("null-ls.sources")
			local available_sources = sources.get_available(buf_ft)

			methods = type(methods) == "table" and methods or { methods }

			-- methods = nil or {}
			if #methods == 0 then
				if name_only then
					return vim.tbl_map(function(source)
						return source.name
					end, available_sources)
				end
				return available_sources
			end

			local source_results = {}

			for _, source in ipairs(available_sources) do
				for _, method in ipairs(methods) do
					if source.methods[method] then
						if name_only then
							table.insert(source_results, source.name)
						else
							table.insert(source_results, source)
						end
						break
					end
				end
			end

			return source_results
		end

		local null_ls_builtins = get_null_ls_sources(null_ls_methods, true)
		vim.list_extend(server_names, null_ls_builtins)
	end
	return table.concat(server_names, ", ")
end

lualine.setup {
	options = {
		globalstatus = true,
		icons_enabled = true,
		theme = "tokyonight",
		component_separators = component_separators,
		section_separators = section_separators,
		disabled_filetypes = { "lazy", "floaterm", "NvimTree", "packer", "mason", "toggleterm" },
		always_divide_middle = true,
	},
	sections = {
		lualine_a = {
			modes,
		},
		lualine_b = {
			{
				"filetype",
				icon_only = true,
				colored = true,
				padding = { left = 2 },
				color = { bg = "#272640" },
			},
			{
				"filename",
				padding = 1,
				separator = section_separators,
				color = { bg = "#272640", fg = colors.fg, gui = "bold" },
				file_status = true,
				newfile_status = false,
				path = 4,
				symbols = {
					modified = "●",
					readonly = " ",
					unnamed = "",
					newfile = " [New]",
				},
			},
		},
		lualine_c = {
			branch,
			{
				"diff",
			},
		},
		lualine_x = {
			diagnostics,
			{
				my_servers,
				color = { fg = colors.magenta },
			},
			{
				copilot,
				color = { fg = colors.white },
			},
			{
				function()
					return "Indent"
				end,
				separator = section_separators,
				color = { bg = colors.blue, fg = colors.black },
			},
			indent,
			{
				"encoding",
				separator = section_separators,
				padding = 1,
				color = { bg = colors.yellow, fg = colors.black },
			},
			location,
			{
				function()
					return ""
				end,
				separator = section_separators,
				color = { bg = colors.orange, fg = colors.black },
			},
		},
		lualine_y = {},
		lualine_z = {},
	},
}
