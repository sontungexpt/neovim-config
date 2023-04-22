local status_ok, lspconfig = pcall(require, "lspconfig")

if not status_ok then
  return
end

local lsp_servers = {
  -- bash
  "bashls",

  -- cpp
  "clangd",
  "cmake",

  -- dev
  "cssls",
  -- "denols",
  "eslint",
  "html",
  "jsonls",
  "tailwindcss",
  "tsserver",
  -- "vuels",

  -- vim
  -- "vimls",

  -- lua
  "lua_ls",

  -- go
  -- "golangci_lint_ls",

  -- ruby
  -- "ruby_ls",

  -- java
  -- "jdtls",

  -- python
  "pyright",
}

local lsp_defaults = lspconfig.util.default_config

lsp_defaults.capabilities = vim.tbl_deep_extend(
  'force',
  lsp_defaults.capabilities,
  require('cmp_nvim_lsp').default_capabilities()
)

for _, lsp_server in ipairs(lsp_servers) do
  lspconfig[lsp_server].setup({
    on_attach = on_attach,
    capabilities = lsp_defaults.capabilities,
  })
end

local function lspSymbol(name, icon)
  local hl = "DiagnosticSign" .. name
  vim.fn.sign_define(hl, {
    text = icon, numhl = hl, texthl = hl
  })
end

lspSymbol("Error", "")
lspSymbol("Info", "")
lspSymbol("Hint", "")
lspSymbol("Warn", "")

vim.diagnostic.config {
  virtual_text = {
    prefix = "●",
  },
  signs = true,
  underline = true,
  severity_sort = true,
  update_in_insert = false,
  float = {
    source = 'always',
  },
}

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
  vim.lsp.handlers.signature_help,
  {
    border = "single",
    focusable = false,
    relative = "cursor",
  }
)
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
  vim.lsp.handlers.hover,
  { border = 'single' }
)

vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics,
  {
    underline = true,
    virtual_text = {
      spacing = 5,
      severity_limit = 'Warning',
      prefix = "●",
    },
    update_in_insert = true,
  }
)
