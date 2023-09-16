local options = {
	open_app = "default",
	open_only_when_cursor_on_url = false,
	highlight_url = {
		enabled = true,
		cursor_only = true, -- highlight the url that canbe opened or highlight all urls
		fg = "#199bff",
		bg = nil, -- transparent
		underline = true,
	},
	deep_pattern = false,
	extra_patterns = {},
}

return options
