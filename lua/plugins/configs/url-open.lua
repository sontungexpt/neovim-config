local options = {
	open_app = "default",
	open_only_when_cursor_on_url = false,
	highlight_url = {
		all_urls = {
			enabled = true,
			fg = "#2dd5ff", -- nil will use default color
			bg = nil, -- transparent
			underline = true,
		},
		cursor_move = {
			enabled = true,
			fg = "#199eff", -- nil will use default color
			bg = nil, -- transparent
			underline = true,
		},
	},
	deep_pattern = false,
	extra_patterns = {},
}

return options
