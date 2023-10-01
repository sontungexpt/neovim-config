local setup_plugin = function(name, opts, callback, execute_callback_before_setup)
	local status_ok, plugin = pcall(require, name)
	if plugin then
		if callback then
			if execute_callback_before_setup then
				callback(plugin)
			end
			plugin.setup(opts)
			if not execute_callback_before_setup then
				callback(plugin)
			end
		else
			plugin.setup(opts)
		end
	end
end

-- All plugins have lazy=true by default,to load a plugin on startup just lazy=false
local default_plugins = {
	-- lazy.nvim
	{
		-- dir = "/home/stilux/Data/My-Workspaces/nvim-extensions/stcursorword",
		-- dev = true,
		"sontungexpt/stcursorword",
		init = function()
			require("core.utils").lazy_load("stcursorword")
		end,
		opts = function()
			return {} -- faster load if no have custom config
			-- return require("plugins.configs.stcursorword")
		end,
		config = function(_, opts)
			setup_plugin("stcursorword", opts)
		end,
	},

	{
		-- dir = "/home/stilux/Data/My-Workspaces/nvim-extensions/url-open",
		-- dev = true,
		"sontungexpt/url-open",
		branch = "mini",
		cmd = "URLOpenUnderCursor",
		init = function()
			require("core.utils").lazy_load("url-open")
		end,
		opts = function()
			return {} -- faster load if no have custom config
			-- return require("plugins.configs.url-open")
		end,
		config = function(_, opts)
			setup_plugin("url-open", opts)
		end,
	},

	{
		-- dir = "/home/stilux/Data/My-Workspaces/nvim-extensions/buffer-closer",
		-- dev = true,
		"sontungexpt/buffer-closer",
		cmd = "CloseRetiredBuffers",
		event = { "BufAdd", "FocusLost", "FocusGained" },
		opts = function()
			return {} -- faster load if no have custom config
			-- return require("plugins.configs.buffer-closer")
		end,
		config = function(_, opts)
			setup_plugin("buffer-closer", opts)
		end,
	},

	{
		"nvim-tree/nvim-tree.lua",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		cmd = {
			"NvimTreeToggle",
			"NvimTreeFocus",
			"NvimTreeOpen",
		},
		opts = function()
			return require("plugins.configs.nvim-tree").options
		end,
		config = function(_, opts)
			setup_plugin("nvim-tree", opts)
		end,
	},

	{
		"zbirenbaum/copilot.lua",
		build = ":Copilot auth",
		cmd = "Copilot",
		event = "InsertEnter",
		opts = function()
			return require("plugins.configs.copilot")
		end,
		config = function(_, opts)
			setup_plugin("copilot", opts)
		end,
	},

	{
		"jonahgoldwastaken/copilot-status.nvim",
		dependencies = { "zbirenbaum/copilot.lua" },
		event = "InsertEnter",
		opts = function()
			return require("plugins.configs.copilot-status")
		end,
		config = function(_, opts)
			setup_plugin("copilot_status", opts)
		end,
	},

	-- {
	-- 	-- dir = "/home/stilux/Data/My-Workspaces/nvim-extensions/focus.nvim",
	-- 	-- dev = true,
	-- 	"sontungexpt/focus.nvim",
	-- 	version = "*",
	-- 	event = "WinNew",
	-- 	cmd = {
	-- 		"FocusDisable",
	-- 		"FocusEnable",
	-- 		"FocusSplitNicely",
	-- 		"FocusSplitCycle",
	-- 		"FocusSplitCycleReverse",
	-- 		"FocusSplitLeft",
	-- 		"FocusSplitDown",
	-- 		"FocusSplitUp",
	-- 		"FocusSplitRight",
	-- 	},
	-- 	opts = function()
	-- 		return require("plugins.configs.nvim-focus")
	-- 	end,
	-- 	config = function(_, opts)
	-- 		local status_ok, focus = pcall(require, "focus")
	-- 		if status_ok then
	-- 			focus.setup(opts)
	-- 		end
	-- 	end,
	-- },

	{
		"nvim-telescope/telescope.nvim",
		cmd = {
			"Telescope",
			"TodoTelescope",
		},
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-media-files.nvim",
			"nvim-telescope/telescope-fzy-native.nvim",
			{
				"ahmedkhalf/project.nvim",
				opts = function()
					return require("plugins.configs.telescope.extensions.project-nvim")
				end,
				cmd = "ProjectRoot",
				config = function(_, opts)
					setup_plugin("project_nvim", opts)
				end,
			},
			-- "jvgrootveld/telescope-zoxide",
			-- "nvim-lua/popup.nvim",
			-- 'BurntSushi/ripgrep',
			-- 'sharkdp/fd'
		},
		opts = function()
			return require("plugins.configs.telescope")
		end,
		config = function(_, opts)
			setup_plugin("telescope", opts, function(telescope)
				-- load telescope extensions
				for _, ext in ipairs(opts.extensions_list) do
					telescope.load_extension(ext)
				end
			end)
		end,
	},

	{
		"windwp/nvim-ts-autotag",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
		ft = {
			"html",
			"javascript",
			"typescript",
			"javascriptreact",
			"typescriptreact",
			"svelte",
			"vue",
			"tsx",
			"jsx",
		},
	},

	{
		"VebbNix/lf-vim",
		ft = "lf",
	},

	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"HiPhish/rainbow-delimiters.nvim",
			-- "HiPhish/nvim-ts-rainbow2",
		},
		init = function()
			require("core.utils").lazy_load("nvim-treesitter")
		end,
		cmd = {
			"TSInstall",
			"TSInstallFromGrammar",
			"TSBufEnable",
			"TSBufDisable",
			"TSModuleInfo",
		},
		build = ":TSUpdate",
		opts = function()
			return require("plugins.configs.nvim-treesitter")
		end,
		config = function(_, opts)
			setup_plugin("nvim-treesitter.configs", opts)
		end,
	},

	{
		"brenoprata10/nvim-highlight-colors",
		cmd = {
			"HighlightColorsOn",
		},
		opts = function()
			return require("plugins.configs.highlight-colors")
		end,
		config = function(_, opts)
			setup_plugin("nvim-highlight-colors", opts)
		end,
	},

	{
		"folke/tokyonight.nvim",
		priority = 1000,
		lazy = false,
		opts = function()
			return require("plugins.configs.tokyonight")
		end,
		config = function(_, opts)
			setup_plugin("tokyonight", opts, function(tokyonight)
				vim.api.nvim_command([[colorscheme tokyonight]])
				vim.api.nvim_command([[let g:lightline = {'colorscheme': 'tokyonight'}]])
			end)
		end,
	},

	{
		"gelguy/wilder.nvim",
		build = ":UpdateRemotePlugins",
		event = "CmdlineEnter",
		dependencies = {
			"romgrk/fzy-lua-native",
		},
		config = function()
			require("plugins.configs.wilder")
		end,
	},

	{
		"akinsho/toggleterm.nvim",
		version = "*",
		cmd = {
			"ToggleTerm",
			"ToggleTermToggleAll",
			"TermExec",
		},
		keys = { "<C-t>" },
		opts = function()
			return require("plugins.configs.toggleterm")
		end,
		config = function(_, opts)
			setup_plugin("toggleterm", opts)
		end,
	},

	{
		"numToStr/Comment.nvim",
		dependencies = {
			"JoosepAlviste/nvim-ts-context-commentstring",
			"nvim-treesitter/nvim-treesitter",
		},
		keys = {
			{ "gcc", mode = "n", desc = "Comment toggle current line" },
			{ "gc", mode = { "n", "o" }, desc = "Comment toggle linewise" },
			{ "gc", mode = "x", desc = "Comment toggle linewise (visual)" },
			{ "gbc", mode = "n", desc = "Comment toggle current block" },
			{ "gb", mode = { "n", "o" }, desc = "Comment toggle blockwise" },
			{ "gb", mode = "x", desc = "Comment toggle blockwise (visual)" },
		},
		opts = function()
			return require("plugins.configs.comment")
		end,
		config = function(_, opts)
			setup_plugin("Comment", opts)
		end,
	},

	{
		"folke/todo-comments.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		init = function()
			require("core.utils").lazy_load("todo-comments.nvim")
		end,
		opts = function()
			return require("plugins.configs.todo-comments")
		end,
		config = function(_, opts)
			setup_plugin("todo-comments", opts)
		end,
	},

	{
		"windwp/nvim-autopairs",
		opts = function()
			return require("plugins.configs.nvim-autopairs")
		end,
		event = "InsertEnter",
		config = function(_, opts)
			setup_plugin("nvim-autopairs", opts, function(nvim_autopairs)
				local cmp_status_ok, cmp = pcall(require, "cmp")
				local cmp_autopairs_status_ok, cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")
				if cmp_status_ok and cmp_autopairs_status_ok then
					cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done { map_char = { tex = "" } })
				end
			end)
		end,
	},

	{
		"uga-rosa/ccc.nvim",
		cmd = { "CccPick" },
		opts = function()
			return require("plugins.configs.color-picker")
		end,
		config = function(_, opts)
			setup_plugin("ccc", opts)
		end,
	},

	{
		"mfussenegger/nvim-jdtls",
		ft = "java",
		-- conifg is in ftplugin/java.lua
	},

	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"lukas-reineke/lsp-format.nvim",
		},
		init = function()
			require("core.utils").lazy_load("nvim-lspconfig")
		end,
		config = function()
			require("plugins.configs.lsp.nvim-lspconfig")
		end,
	},

	{
		"glepnir/lspsaga.nvim",
		event = "LspAttach",
		dependencies = {
			{ "nvim-tree/nvim-web-devicons" },
			--Please make sure you install markdown and markdown_inline parser
			{ "nvim-treesitter/nvim-treesitter" },
		},
		opts = function()
			return require("plugins.configs.lsp.lspsaga")
		end,
		config = function(_, opts)
			setup_plugin("lspsaga", opts)
		end,
	},

	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		init = function()
			require("core.utils").lazy_load("lualine.nvim")
		end,
		opts = function()
			return require("plugins.configs.lualine")
		end,
		config = function(_, opts)
			setup_plugin("lualine", opts)
		end,
	},

	{
		"akinsho/bufferline.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		init = function()
			require("core.utils").lazy_load("bufferline.nvim")
		end,
		opts = function()
			return require("plugins.configs.bufferline")
		end,
		config = function(_, opts)
			setup_plugin("bufferline", opts)
		end,
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		version = "2.20.8",
		init = function()
			require("core.utils").lazy_load("indent-blankline.nvim")
		end,
		opts = function()
			return require("plugins.configs.indent-blankline")
		end,
		config = function(_, opts)
			setup_plugin("indent_blankline", opts, function(ibl)
				vim.wo.colorcolumn = "99999"
			end, true)
		end,
	},

	{
		"kylechui/nvim-surround",
		keys = {
			"ys",
			"ds",
			"cs",
		},
		opts = function()
			return require("plugins.configs.nvim-surround")
		end,
		config = function(_, opts)
			setup_plugin("nvim-surround", opts)
		end,
	},

	{
		"lewis6991/gitsigns.nvim",
		ft = { "gitcommit" },
		init = function()
			require("core.utils").lazy_load_git_plugin("gitsigns.nvim")
		end,
		opts = function()
			return require("plugins.configs.gitsigns")
		end,
		config = function(_, opts)
			setup_plugin("gitsigns", opts, function(gitsigns)
				vim.api.nvim_command([[set statusline+=%{get(b:,'gitsigns_status','')}]])
			end)
		end,
	},

	{
		"akinsho/git-conflict.nvim",
		version = "*",
		ft = { "gitcommit" },
		init = function()
			require("core.utils").lazy_load_git_plugin("git-conflict.nvim")
		end,
		opts = function()
			return require("plugins.configs.git-conflict")
		end,
		config = function(_, opts)
			setup_plugin("git-conflict", opts)
		end,
	},

	--Lsp + cmp
	{
		"williamboman/mason.nvim",
		build = function()
			require("plugins.autocmds.mason").sync_packages()
		end,
		init = function()
			require("plugins.autocmds.mason").create_user_commands()
		end,
		cmd = {
			"Mason",
			"MasonShowInstalledPackages",
			"MasonShowEnsuredPackages",
			"MasonInstall",
			"MasonUninstall",
			"MasonUninstallAll",
			"MasonUpdate",
			"MasonLog",
		},
		opts = function()
			return require("plugins.configs.mason")
		end,
		config = function(_, opts)
			setup_plugin("mason", opts)
		end,
	},

	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			{
				-- snippet plugin
				"L3MON4D3/LuaSnip",
				dependencies = "rafamadriz/friendly-snippets",
				opts = { history = true, updateevents = "TextChanged,TextChangedI" },
				config = function(_, opts)
					require("luasnip").config.set_config(opts)

					-- vscode format
					require("luasnip.loaders.from_vscode").lazy_load()
					require("luasnip.loaders.from_vscode").lazy_load { paths = vim.g.vscode_snippets_path or "" }

					-- snipmate format
					require("luasnip.loaders.from_snipmate").load()
					require("luasnip.loaders.from_snipmate").lazy_load { paths = vim.g.snipmate_snippets_path or "" }

					-- lua format
					require("luasnip.loaders.from_lua").load()
					require("luasnip.loaders.from_lua").lazy_load { paths = vim.g.lua_snippets_path or "" }

					vim.api.nvim_create_autocmd("InsertLeave", {
						callback = function()
							if
								require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
								and not require("luasnip").session.jump_active
							then
								require("luasnip").unlink_current()
							end
						end,
					})
				end,
			},

			-- cmp sources plugins
			{
				"saadparwaiz1/cmp_luasnip",
				"hrsh7th/cmp-nvim-lua",
				"hrsh7th/cmp-nvim-lsp",
				"hrsh7th/cmp-buffer",
				"hrsh7th/cmp-path",
			},
		},
		config = function()
			require("plugins.configs.cmp")
		end,
	},

	{
		-- "jose-elias-alvarez/null-ls.nvim",
		"nvimtools/none-ls.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		event = { "BufWritePre" },
		config = function()
			require("plugins.configs.lsp.null-ls")
		end,
	},

	{
		"iamcco/markdown-preview.nvim",
		ft = "markdown",
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
		config = function()
			require("plugins.configs.markdown-preview")
		end,
	},

	{
		"folke/which-key.nvim",
		keys = {
			"<leader>",
			"[",
			"]",
			'"',
			"'",
			"c",
			"v",
			"g",
		},
		opts = function()
			return require("plugins.configs.whichkey")
		end,
		config = function(_, opts)
			setup_plugin("which-key", opts)
		end,
	},

	{
		"kevinhwang91/nvim-ufo",
		keys = {
			{ "zc", mode = "n", desc = "Fold current line" },
			{ "zo", mode = "n", desc = "Unfold current line" },
			{ "za", mode = "n", desc = "Toggle fold current line" },
			{ "zA", mode = "n", desc = "Toggle fold all lines" },
			{ "zr", mode = "n", desc = "Unfold all lines" },
			{ "zR", mode = "n", desc = "Fold all lines" },
		},
		dependencies = "kevinhwang91/promise-async",
		opts = function()
			return require("plugins.configs.nvim-ufo")
		end,
		config = function(_, opts)
			setup_plugin("ufo", opts, function(ufo)
				vim.o.foldenable = true -- enable folding when plugin is loaded
			end, true)
		end,
	},

	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			{
				"mfussenegger/nvim-dap",
				dependencies = {
					{
						"theHamsta/nvim-dap-virtual-text",
						config = function()
							require("plugins.configs.dap.nvim-dap-virtual-text")
						end,
					},
				},
				config = function()
					require("plugins.configs.dap.nvim-dap")
				end,
			},
		},
		keys = {
			{
				"<leader>du",
				function()
					require("dapui").toggle {}
				end,
				desc = "Dap UI",
			},
			{
				"<leader>db",
				function()
					require("dap").toggle_breakpoint()
				end,
				desc = "Dap Breakpoint",
			},
		},
		config = function()
			require("plugins.configs.dap.nvim-dap-ui")
		end,
	},
}

local config = require("core.utils").load_config()

require("lazy").setup(default_plugins, config.lazy_nvim)

-- Because some auto commands need to sure that a command of plugin is exists
-- So we need to load all plugins first
-- Then we can create auto commands
require("plugins.autocmds")
