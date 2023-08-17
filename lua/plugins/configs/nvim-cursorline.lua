local options = {
	cursorline = {
		enable = false,
		timeout = 400,
		number = false,
	},
	cursorword = {
		enable = true,
		min_length = 3,
		hl = { underline = true },
	},
}

return options
