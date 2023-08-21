local options = {
	-- ensure_installed = "all",
	ensure_installed = {
		-- c/c++/cmake
		"cpp",
		"c",
		"cmake",

		"bash",
		"lua",
		"python",
		"rust",
		"toml",

		"dockerfile",
		"markdown",
		"markdown_inline",

		-- web dev
		"css",
		"html",
		"javascript",
		"json",
		"typescript",
		"yaml",
	},
	ignore_install = {},
	highlight = {
		enable = true,
		--disable ={"html","css"}
	},
	indent = {
		enable = true,
	},
	additional_vim_regex_highlighting = false,
	autotag = {
		enable = true,
		filetypes = {
			"html",
			"xml",
			"jsx",
			"tsx",
			"javascript",
			"javascriptreact",
			"typescript",
			"typescriptreact",
		},
	},
	autopairs = {
		enable = true,
	},
	context_commentstring = {
		enable = true,
	},
}

return options
