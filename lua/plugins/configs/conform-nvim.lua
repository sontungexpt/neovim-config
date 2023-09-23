local status_ok, conform = pcall(require, "conform")
if not status_ok then
	return
end

local util = require("conform.util")

conform.setup {
	-- Map of filetype to formatters
	formatters_by_ft = {
		lua = { "stylua" },
		luau = { "stylua" },

		python = { "autopep8" },

		-- webdev
		javascript = { { "prettierd", "prettier" } },
		typescript = { { "prettierd", "prettier" } },
		javascriptreact = { { "prettierd", "prettier" } },
		typescriptreact = { { "prettierd", "prettier" } },
		json = { { "prettierd", "prettier" } },
		jsonc = { { "prettierd", "prettier" } },
		css = { { "prettierd", "prettier" } },
		html = { { "prettierd", "prettier" } },
		markdown = { { "prettierd", "prettier" } },

		["*"] = { "codespell" },
		c = { "clang_format" },
		cpp = { "clang_format" },
		cmake = { "clang_format" },

		rust = { "rustfmt" },

		sh = { "shfmt" },
		bash = { "shfmt" },
		zsh = { "shfmt" },

		toml = { "taplo" },
	},
	format_on_save = {
		lsp_fallback = true,
		timeout_ms = 500,
	},
	format_after_save = {
		lsp_fallback = true,
	},
	notify_on_error = true,
}

-- -- change null-ls extra args to conform
-- conform.formatters.prettierd = {
-- 	function()
-- 		return {
-- 			extra_args = function(params)
-- 				local Path = require("plenary.path")
-- 				local prettierdrc = Path:new(params.root .. "/" .. ".prettierdrc")

-- 				if prettierdrc:exists() and prettierdrc:is_file() then
-- 					return { "--config", prettierdrc:absolute() }
-- 				end
-- 				return {}
-- 			end,
-- 		}
-- 	end,
-- }
