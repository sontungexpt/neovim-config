local status_ok, lspconfig = pcall(require, "lspconfig")

if not status_ok then
	return
end

local lsp = vim.lsp

local lsp_servers = {
	-- bash
	{
		name = "bashls",
	},

	-- cpp
	{
		name = "clangd",
	},
	{
		name = "cmake",
	},

	-- dev
	{
		name = "cssls",
	},
	{
		name = "eslint",
	},
	{
		name = "html",
	},
	{
		name = "jsonls",
	},
	{
		name = "tailwindcss",
	},
	{
		name = "tsserver",
	},
	{
		name = "emmet_ls",
		config = {
			filetypes = {
				"html",
				"typescriptreact",
				"javascriptreact",
				"css",
				"sass",
				"scss",
				"less",
				"javascript",
				"typescript",
				"vue",
				"vue-html",
				"jsx",
				"tsx",
			},
		},
	},

	--rust
	{
		name = "rust_analyzer",
		config = {
			cmd = {
				"rustup",
				"run",
				"stable",
				"rust-analyzer",
			},
		},
	},

	-- lua
	{
		name = "lua_ls",
		config = {
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
					workspace = {
						library = {
							[vim.fn.expand("$VIMRUNTIME/lua")] = true,
							[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
						},
						maxPreload = 100000,
						preloadFileSize = 10000,
					},
				},
			},
		},
	},

	-- python
	{
		name = "pyright",
	},
}

local function on_attach(client, bufnr)
	local function lspSymbol(name, icon)
		local hl = "DiagnosticSign" .. name
		vim.fn.sign_define(hl, {
			text = icon,
			numhl = hl,
			texthl = hl,
		})
	end

	lspSymbol("Error", " ")
	lspSymbol("Info", " ")
	lspSymbol("Hint", "󰌵 ")
	lspSymbol("Warn", " ")

	vim.diagnostic.config {
		virtual_text = {
			prefix = "●",
		},
		signs = true,
		underline = true,
		severity_sort = true,
		update_in_insert = false,
		float = {
			source = "always",
		},
	}

	lsp.handlers["textDocument/signatureHelp"] = lsp.with(lsp.handlers.signature_help, {
		border = "single",
		focusable = false,
		relative = "cursor",
	})

	lsp.handlers["textDocument/hover"] = lsp.with(lsp.handlers.hover, { border = "single" })

	lsp.handlers["textDocument/publishDiagnostics"] = lsp.with(lsp.diagnostic.on_publish_diagnostics, {
		underline = true,
		virtual_text = {
			spacing = 5,
			severity_limit = "Warning",
			prefix = "●",
		},
		update_in_insert = true,
	})
end

local capabilities = vim.tbl_deep_extend(
	"force",
	lspconfig.util.default_config.capabilities or {},
	require("cmp_nvim_lsp").default_capabilities()
)

capabilities.offsetEncoding = { "utf-8" }

for _, server in ipairs(lsp_servers) do
	local config = server.config or {}
	config.on_attach = config.on_attach or on_attach
	config.capabilities = config.capabilities or capabilities
	lspconfig[server.name].setup(config)
end
