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
  "denols",
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


-- keymap for lsp if not use lspsaga
-- vim.api.nvim_create_autocmd('LspAttach', {
--   desc = 'LSP actions',
--   callback = function()
--     local bufmap = function(mode, lhs, rhs)
--       local opts = { buffer = true }
--       vim.keymap.set(mode, lhs, rhs, opts)
--     end

--     -- Displays hover information about the symbol under the cursor
--     bufmap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')

--     -- Jump to the definition
--     bufmap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>')

--     -- Jump to declaration
--     bufmap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')

--     -- Lists all the implementations for the symbol under the cursor
--     bufmap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')

--     -- Jumps to the definition of the type symbol
--     bufmap('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>')

--     -- Lists all the references
--     bufmap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>')

--     -- Displays a function's signature information
--     bufmap('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>')

--     -- Renames all references to the symbol under the cursor
--     bufmap('n', '<leader>r', '<cmd>lua vim.lsp.buf.rename()<cr>')

--     -- Selects a code action available at the current cursor position
--     bufmap('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>')
--     bufmap('x', '<F4>', '<cmd>lua vim.lsp.buf.range_code_action()<cr>')

--     -- Show diagnostics in a floating window
--     bufmap('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')

--     -- Move to the previous diagnostic
--     bufmap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')

--     -- Move to the next diagnostic
--     bufmap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')
--   end
-- })

local sign = function(opts)
  vim.fn.sign_define(opts.name, {
    texthl = opts.name,
    text = opts.text,
    numhl = ''
  })
end

sign({ name = 'DiagnosticSignError', text = '' })
sign({ name = 'DiagnosticSignWarn', text = '' })
sign({ name = 'DiagnosticSignHint', text = '' })
sign({ name = 'DiagnosticSignInfo', text = '' })

vim.diagnostic.config({
  virtual_text = false,
  severity_sort = true,
  float = {
    border = 'single',
    source = 'always',
    focusable = true,
    style = "minimal",
    header = "",
    prefix = "",
    width = 65,
  },
})

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
  vim.lsp.handlers.hover,
  { border = 'single' }
)

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
  vim.lsp.handlers.signature_help,
  { border = 'single' }
)

vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics,
  {
    underline = true,
    virtual_text = {
      spacing = 5,
      severity_limit = 'Warning',
    },
    -- signs = function(namespace, bufnr)
    --   return vim.b[bufnr].show_signs == true
    -- end,
    update_in_insert = true,
  }
)
