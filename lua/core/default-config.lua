local M = {}

M.ui = {
	colors = {
		bg = "#202328",
		fg = "#bbc2cf",
		yellow = "#ECBE7B",
		cyan = "#008080",
		darkblue = "#081633",
		black = "#000000",
		white = "#ffffff",
		green = "#67bf70",
		orange = "#FF8800",
		violet = "#a9a1e1",
		magenta = "#c678dd",
		blue = "#51afef",
		red = "#ec5f67",
		gray = "#6c776e",
		pink = "#eb7fdc",
		lualine_bg = "#1e2030",
		trans = "#00000000",
	},
	lualine = {
		options = {
			float_separator = { left = "", right = "" },
			section_separators = { "", "" },
			component_separators = { "", "" },
		},
	},
}

-- File to identify project root
M.root_markers = {
	-- rust
	"Cargo.toml",

	-- lua
	"stylua.toml",

	-- git
	".git",

	-- npm
	"package.json",

	-- nvim config
	"lazy-lock.json",
}

M.binary_file_patterns = {
	"%.png$",
	"%.jpg$",
	"%.jpeg$",
	"%.pdf$",
	"%.zip$",
	"%.tar%.gz$",
	"%.tar$",
	"%.mp3$",
	"%.mp4$",
	"%.wav$",
	"%.ogg$",
	"%.mkv$",
	"%.avi$",
	"%.webm$",
	"%.iso$",
	"%.exe$",
	"%.dll$",
	"%.so$",
	"%.dylib$",
}

-- config for lazy.nvim startup options
M.lazy_nvim = require("plugins.configs.lazy-nvim")

return M
