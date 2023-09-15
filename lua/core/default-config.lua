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
		green = "#98be65",
		orange = "#FF8800",
		violet = "#a9a1e1",
		magenta = "#c678dd",
		blue = "#51afef",
		red = "#ec5f67",
		gray = "#6c776e",
		pink = "#eb7fdc",
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
M.root_files = {
	-- rust
	"Cargo.toml",
	"Cargo.lock",

	-- lua
	"stylua.toml",

	-- git
	".git",
	".gitignore",

	-- npm
	"package.json",
	"yarn.lock",

	-- c/c++
	"CMakeLists.txt",

	-- nvim config
	"lazy-lock.json",
}

-- config for lazy.nvim startup options
M.lazy_nvim = require("plugins.configs.lazy-nvim")

return M
