local options = {
	-- ensure_installed = "all",
	ensure_installed = {
		-- popular langs
		"cpp",
		"c",
		"cmake",
		"c_sharp",
		"bash",
		"lua",
		"python",
		"go",
		"java",
		"rust",

		"dockerfile",
		"markdown",
		"markdown_inline",
		"sql",
		"rasi",
		"toml",

		-- git
		"gitignore",
		"git_rebase",
		"git_config",
		"gitattributes",
		"gitcommit",

		-- web dev
		"css",
		"html",
		"javascript",
		"typescript",
		"json",
		"tsx",
		"yaml",
		"xml",
		"vue",
		"svelte",
		"scss",
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
