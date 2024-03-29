local M = {}

M.ui = {
	colors = {
		bg = "#202328",
		fg = "#bbc2cf",
		yellow = "#ffc021",
		light_yellow = "#ffdf80",
		cyan = "#008080",
		darkblue = "#081633",
		black = "#000000",
		white = "#ffffff",
		green = "#67bf70",
		light_green = "#47d864",
		orange = "#FF8800",
		violet = "#a9a1e1",
		magenta = "#c678dd",
		blue = "#51afef",
		weight_blue = "#2f86eb",
		red = "#ee2c4a",
		light_red = "#ff6c6b",
		gray = "#5c6370",
		purple = "#c688eb",
		pink = "#eb7fdc",
		lualine_bg = "#1e2030",
		trans = "#00000000",
	},
	lualine = {
		rounded_seps = { left = "", right = "" },
		no_seps = { "", "" },
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

	-- java
	"gradlew",
	"mvnw",
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
