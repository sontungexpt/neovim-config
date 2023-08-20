-- All plugins have lazy=true by default,to load a plugin on startup just lazy=false
local default_plugins = {
	{
		-- dir = "/home/stilux/Data/My-Workspaces/nvim-extensions/url-open/",
		-- dev = true,
		"sontungexpt/url-open",
		branch = "mini",
		cmd = "OpenUrlUnderCursor",
		opts = function()
			return require("plugins.configs.url-open")
		end,
		config = function(_, opts)
			local status_ok, url_open = pcall(require, "url-open")
			if not status_ok then
				return
			end
			url_open.setup(opts)
		end,
	},

	{
		-- dir = "/home/stilux/Data/My-Workspaces/nvim-extensions/buffer-closer",
		-- dev = true,
		"sontungexpt/buffer-closer",
		event = "UIEnter",
		opts = function()
			return require("plugins.configs.buffer-closer")
		end,
		config = function(_, opts)
			local status_ok, buffer_closer = pcall(require, "buffer-closer")
			if not status_ok then
				return
			end
			buffer_closer.setup(opts)
		end,
	},

	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
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
			local status_ok, nvim_tree = pcall(require, "nvim-tree")
			if not status_ok then
				return
			end
			nvim_tree.setup(opts)
		end,
	},

	{
		"zbirenbaum/copilot.lua",
		build = function()
			vim.schedule(function()
				vim.api.nvim_command("Copilot auth")
			end)
		end,
		-- build = ":Copilot auth",
		cmd = "Copilot",
		event = "InsertEnter",
		opts = function()
			return require("plugins.configs.copilot")
		end,
		config = function(_, opts)
			local status_ok, copilot = pcall(require, "copilot")
			if not status_ok then
				return
			end
			copilot.setup(opts)
		end,
	},

	{
		"sontungexpt/focus.nvim",
		version = "*",
		event = "WinNew",
		cmd = {
			"FocusDisable",
			"FocusEnable",
			"FocusSplitNicely",
			"FocusSplitCycle",
			"FocusSplitCycleReverse",
			"FocusSplitLeft",
			"FocusSplitDown",
			"FocusSplitUp",
			"FocusSplitRight",
		},
		opts = function()
			return require("plugins.configs.nvim-focus")
		end,
		config = function(_, opts)
			local status_ok, focus = pcall(require, "focus")
			if not status_ok then
				return
			end
			focus.setup(opts)
		end,
	},

	{
		"nvim-telescope/telescope.nvim",
		cmd = {
			"Telescope",
			"TodoTelescope",
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-lua/popup.nvim",
			"jvgrootveld/telescope-zoxide",
			"nvim-telescope/telescope-fzy-native.nvim",
			"nvim-telescope/telescope-project.nvim",
			"nvim-telescope/telescope-media-files.nvim",
			-- 'dharmx/telescope-media.nvim',
			-- 'BurntSushi/ripgrep',
			-- 'sharkdp/fd'
		},
		opts = function()
			return require("plugins.configs.telescope")
		end,
		config = function(_, opts)
			local status_ok, telescope = pcall(require, "telescope")
			if not status_ok then
				return
			end

			-- load telescope extensions
			for _, ext in ipairs(opts.extensions_list) do
				telescope.load_extension(ext)
			end

			telescope.setup(opts)
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
			"TSBufEnable",
			"TSBufDisable",
			"TSModuleInfo",
		},
		build = ":TSUpdate",
		opts = function()
			return require("plugins.configs.nvim-treesitter")
		end,
		config = function(_, opts)
			local status_ok, nvim_treesitter = pcall(require, "nvim-treesitter.configs")
			if not status_ok then
				return
			end

			nvim_treesitter.setup(opts)
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
			local status_ok, highlight_colors = pcall(require, "nvim-highlight-colors")
			if not status_ok then
				return
			end
			highlight_colors.setup(opts)
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
			local status_ok, tokyonight = pcall(require, "tokyonight")
			if not status_ok then
				return
			end
			tokyonight.setup(opts)

			vim.api.nvim_command([[colorscheme tokyonight]])
			vim.api.nvim_command([[let g:lightline = {'colorscheme': 'tokyonight'}]])
		end,
	},

	{
		"gelguy/wilder.nvim",
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
		},
		keys = { "<C-t>" },
		config = function()
			require("plugins.configs.toggleterm")
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
			local status_ok, comment = pcall(require, "Comment")
			if not status_ok then
				return
			end
			comment.setup(opts)
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
			local status_ok, todo_comments = pcall(require, "todo-comments")
			if not status_ok then
				return
			end
			todo_comments.setup(opts)
		end,
	},

	{
		"windwp/nvim-autopairs",
		opts = function()
			return require("plugins.configs.nvim-autopairs")
		end,
		event = "InsertEnter",
		config = function(_, opts)
			local status_ok, autopairs = pcall(require, "nvim-autopairs")

			if not status_ok then
				return
			end

			autopairs.setup(opts)

			local cmp_status_ok, cmp = pcall(require, "cmp")
			if not cmp_status_ok then
				return
			end

			local cmp_autopairs_status_ok, cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")
			if not cmp_autopairs_status_ok then
				return
			end

			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done { map_char = { tex = "" } })
		end,
	},

	{
		"yamatsum/nvim-cursorline",
		lazy = false,
		opts = function()
			return require("plugins.configs.nvim-cursorline")
		end,
		config = function(_, opts)
			local status_ok, nvim_cursorline = pcall(require, "nvim-cursorline")
			if not status_ok then
				return
			end
			nvim_cursorline.setup(opts)
		end,
	},

	{
		"uga-rosa/ccc.nvim",
		cmd = { "CccPick" },
		opts = function()
			return require("plugins.configs.color-picker")
		end,
		config = function(_, opts)
			local status_ok, ccc = pcall(require, "ccc")
			if not status_ok then
				return
			end
			ccc.setup(opts)
		end,
	},

	{
		"neovim/nvim-lspconfig",
		init = function()
			require("core.utils").lazy_load("nvim-lspconfig")
		end,
		config = function()
			require("plugins.configs.nvim-lspconfig")
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
			return require("plugins.configs.lspsaga")
		end,
		config = function(_, opts)
			local status_ok, lspsaga = pcall(require, "lspsaga")
			if not status_ok then
				return
			end
			lspsaga.setup(opts)
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
		config = function()
			require("plugins.configs.lualine")
		end,
	},

	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		lazy = false,
		opts = function()
			return require("plugins.configs.bufferline").opts
		end,
		config = function(_, opts)
			local status_ok, bufferline = pcall(require, "bufferline")
			if not status_ok then
				return
			end
			bufferline.setup(opts)
		end,
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		init = function()
			require("core.utils").lazy_load("indent-blankline.nvim")
		end,
		opts = function()
			return require("plugins.configs.indent-blankline")
		end,
		config = function(opts)
			vim.wo.colorcolumn = "99999"
			local status_ok, indent_blankline = pcall(require, "indent_blankline")
			if not status_ok then
				return
			end
			indent_blankline.setup(opts)
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
		config = function()
			local status_ok, nvim_surround = pcall(require, "nvim-surround")
			if not status_ok then
				return
			end
			nvim_surround.setup {}
		end,
	},

	{
		"lewis6991/gitsigns.nvim",
		ft = { "gitcommit" },
		init = function()
			-- load gitsigns only when a git file is opened
			vim.api.nvim_create_autocmd({ "BufRead" }, {
				group = vim.api.nvim_create_augroup("GitSignsLazyLoad", { clear = true }),
				callback = function()
					vim.fn.system("git -C " .. '"' .. vim.fn.expand("%:p:h") .. '"' .. " rev-parse")
					if vim.v.shell_error == 0 then
						vim.api.nvim_del_augroup_by_name("GitSignsLazyLoad")
						vim.schedule(function()
							require("lazy").load { plugins = { "gitsigns.nvim" } }
						end)
					end
				end,
			})
		end,
		config = function()
			require("plugins.configs.gitsigns")
		end,
	},

	{
		"akinsho/git-conflict.nvim",
		version = "*",
		ft = { "gitcommit" },
		init = function()
			-- load git-conflict only when a git file is opened
			vim.api.nvim_create_autocmd({ "BufRead" }, {
				group = vim.api.nvim_create_augroup("GitConflictLazyLoad", { clear = true }),
				callback = function()
					vim.fn.system("git -C " .. '"' .. vim.fn.expand("%:p:h") .. '"' .. " rev-parse")
					if vim.v.shell_error == 0 then
						vim.api.nvim_del_augroup_by_name("GitConflictLazyLoad")
						vim.schedule(function()
							require("lazy").load { plugins = { "git-conflict.nvim" } }
						end)
					end
				end,
			})
		end,
		opts = function()
			return require("plugins.configs.git-conflict")
		end,
		config = function(_, opts)
			local present, conflict = pcall(require, "git-conflict")
			if not present then
				return
			end
			conflict.setup(opts)
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
			local status_ok, mason = pcall(require, "mason")
			if not status_ok then
				return
			end
			mason.setup(opts)
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
		"jose-elias-alvarez/null-ls.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		event = { "BufWritePre", "LspAttach" },
		config = function()
			require("plugins.configs.null-ls")
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
			require("which-key").setup(opts)
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
		config = function()
			require("plugins.configs.nvim-ufo")
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
			{
				"folke/neodev.nvim",
				config = function()
					local status_ok, neodev = pcall(require, "neodev")
					if not status_ok then
						return
					end

					neodev.setup {
						library = { plugins = { "nvim-dap-ui" }, types = true },
					}
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
