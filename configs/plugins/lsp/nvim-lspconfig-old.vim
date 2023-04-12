Plug 'neovim/nvim-lspconfig'
" https://github.com/neovim/nvim-lspconfig


"----------lspconfig----------"
function SetupNvimLspconfig()
lua<<EOF
  local lspconfig = require('lspconfig')
  local lsp_defaults = lspconfig.util.default_config

  lsp_defaults.capabilities = vim.tbl_deep_extend(
    'force',
    lsp_defaults.capabilities,
    require('cmp_nvim_lsp').default_capabilities()
  )
  -- LSP Servers
  lspconfig.lua_ls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
  })

  lspconfig.clangd.setup({
    on_attach = on_attach,
    capabilities = capabilities,
  })

  lspconfig.vimls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
  })

  lspconfig.cmake.setup({
    on_attach = on_attach,
    capabilities = capabilities,
  })
  
  lspconfig.eslint.setup({
    on_attach = on_attach,
    capabilities = capabilities,
  })

  lspconfig.html.setup({
    on_attach = on_attach,
    capabilities = capabilities,
  })

  lspconfig.cssls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
  })

  lspconfig.tsserver.setup({
    on_attach = on_attach,
    capabilities = capabilities,
  })

  lspconfig.tailwindcss.setup({
    on_attach = on_attach,
    capabilities = capabilities,
  })

  lspconfig.vuels.setup({
    on_attach = on_attach,
    capabilities = capabilities,
  })

  lspconfig.pyright.setup({
    on_attach = on_attach,
    capabilities = capabilities,
  })

  vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP actions',
    callback = function()
      local bufmap = function(mode, lhs, rhs)
        local opts = {buffer = true}
        vim.keymap.set(mode, lhs, rhs, opts)
      end

      -- Displays hover information about the symbol under the cursor
      bufmap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')

      -- Jump to the definition
      bufmap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>')

      -- Jump to declaration
      bufmap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')

      -- Lists all the implementations for the symbol under the cursor
      bufmap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')

      -- Jumps to the definition of the type symbol
      bufmap('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>')

      -- Lists all the references 
      bufmap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>')

      -- Displays a function's signature information
      bufmap('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>')

      -- Renames all references to the symbol under the cursor
      bufmap('n', '<leader>r', '<cmd>lua vim.lsp.buf.rename()<cr>')

      -- Selects a code action available at the current cursor position
      bufmap('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>')
      bufmap('x', '<F4>', '<cmd>lua vim.lsp.buf.range_code_action()<cr>')

      -- Show diagnostics in a floating window
      bufmap('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')

      -- Move to the previous diagnostic
      bufmap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')

      -- Move to the next diagnostic
      bufmap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')
    end
  })

  local sign = function(opts)
  vim.fn.sign_define(opts.name, {
    texthl = opts.name,
    text = opts.text,
    numhl = ''
  })
  end

  sign({name = 'DiagnosticSignError', text = '✘'})
  sign({name = 'DiagnosticSignWarn', text = '▲'})
  sign({name = 'DiagnosticSignHint', text = '⚑'})
  sign({name = 'DiagnosticSignInfo', text = ''})

  vim.diagnostic.config({
    virtual_text = false,
    severity_sort = true,
    float = {
      border = 'rounded',
      source = 'always',
      focusable = true,
		  style = "minimal",
		  header = "",
		  prefix = "",
		  width = 40,
    },
  })

  vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
    vim.lsp.handlers.hover,
    {border = 'rounded'}
  )

  vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
    vim.lsp.handlers.signature_help,
    {border = 'rounded'}
  )
EOF
endfunction


augroup NvimLspconfigOverrides
  autocmd!
  autocmd User PlugLoaded call SetupNvimLspconfig()
augroup END
