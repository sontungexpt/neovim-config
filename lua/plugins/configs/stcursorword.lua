local options = {
	max_word_length = 100, -- if cursorword length > max_word_length then not highlight
	min_word_length = 2, -- if cursorword length < min_word_length then not highlight
	excluded = {
		filetypes = {
			"TelescopePrompt",
		},
		buftypes = {
			-- "nofile",
			-- "terminal",
		},
		file_patterns = { -- pattern to match with the path of the file
			"%.png$",
		},
	},
	highlight = {
		underline = true,
		fg = nil,
		bg = nil,
	},
}

return options
