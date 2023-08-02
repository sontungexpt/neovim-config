local status_ok, wilder = pcall(require, "wilder")

if not status_ok then
	return
end

local colors = require("core.default-config").ui.colors

wilder.setup {
	modes = { ":", "/", "?" },
	next_key = "<Tab>",
	previous_key = "<S-Tab>",
	enable_cmdline_enter = 1,
}

local set_option = wilder.set_option
local popupmenu_devicons = wilder.popupmenu_devicons
local popupmenu_renderer = wilder.popupmenu_renderer
local popupmenu_palette_theme = wilder.popupmenu_palette_theme

set_option("use_python_remote_plugin", 0)

set_option("pipeline", {
	wilder.branch(
		wilder.cmdline_pipeline {
			fuzzy = 1,
			fuzzy_filter = wilder.lua_fzy_filter(),
		},
		wilder.vim_search_pipeline()
	),
})

local general_style = {
	-- 'single', 'double', 'rounded' or 'solid'
	border = "single",
	-- max height of the palette
	max_height = "80%",
	-- set to the same as 'max_height' for a fixed height window
	min_height = 0,
	-- 'top' or 'bottom' to set the location of the prompt
	prompt_position = "top",
	-- set to 1 to reverse the order of the list, use in combination with 'prompt_position'
	reverse = 0,
	left = { " ", popupmenu_devicons() },
	highlighter = {
		wilder.lua_fzy_highlighter(),
	},
	highlights = {
		accent = wilder.make_hl("WilderAccent", "Pmenu", {
			{ a = 1 },
			{ a = 1 },
			{ foreground = colors.pink },
		}),
	},
}

-- local create_styles = function(styles)
-- 	return vim.tbl_deep_extend("force", general_style or {}, styles or {})
-- end

local change_left_icons = function(styles, left)
	styles.left = left
	return styles
end

set_option(
	"renderer",
	wilder.renderer_mux {
		[":"] = popupmenu_renderer(
			popupmenu_palette_theme(change_left_icons(general_style, { " ", "  ", popupmenu_devicons() }))
		),
		["/"] = popupmenu_renderer(
			popupmenu_palette_theme(change_left_icons(general_style, { " ", "  ", popupmenu_devicons() }))
		),
		["?"] = popupmenu_renderer(
			popupmenu_palette_theme(change_left_icons(general_style, { " ", "  ", popupmenu_devicons() }))
		),
	}
)
