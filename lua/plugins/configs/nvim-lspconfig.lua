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
  "emmet_ls",
  -- "vuels",

  --rust // uncomment below when you don't use packages rust-tools.nvim
  "rust_analyzer",

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

local function on_attach(client, bufnr)
  local function lspSymbol(name, icon)
    local hl = "DiagnosticSign" .. name
    vim.fn.sign_define(hl, {
      text = icon, numhl = hl, texthl = hl
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
end

local capabilities = vim.tbl_deep_extend(
  'force',
  lspconfig.util.default_config.capabilities or {},
  require('cmp_nvim_lsp').default_capabilities()
)

capabilities.offsetEncoding = { "utf-8" }

for _, lsp_server in ipairs(lsp_servers) do
  lspconfig[lsp_server].setup({
    on_attach = on_attach,
    capabilities = capabilities,
  })
end

lspconfig.emmet_ls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { 'html', 'typescriptreact', 'javascriptreact', 'css', 'sass', 'scss', 'less', 'javascript', 'typescript',
    'vue', 'vue-html', 'jsx', 'tsx' },
})
