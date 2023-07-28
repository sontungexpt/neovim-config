local status_ok, lspconfig = pcall(require, "lspconfig")

if not status_ok then
  return
end

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
  -- {
  --   name = "denols",
  -- },
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
        'html', 'typescriptreact',
        'javascriptreact', 'css', 'sass',
        'scss', 'less', 'javascript',
        'typescript', 'vue', 'vue-html', 'jsx', 'tsx'
      },
    }
  },
  -- {
  --   name = "vuels",
  -- },

  --rust // uncomment below when you don't use packages rust-tools.nvim
  {
    name = "rust_analyzer",
    config = {
      cmd = {
        "rustup", "run", "stable", "rust-analyzer",
      },
    }
  },

  -- vim
  -- {
  --   name = "vimls",
  -- },

  -- lua
  {
    name = "lua_ls",
  },

  -- go
  -- {
  --   name = "golangci_lint_ls",
  -- },

  -- ruby
  -- {
  --   name = "ruby_ls",
  -- },

  -- java
  -- {
  --   name = "jdtls",
  -- },

  -- python
  {
    name = "pyright",
  },
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

for _, server in ipairs(lsp_servers) do
  local config = server.config or {}
  config.on_attach = config.on_attach or on_attach
  config.capabilities = config.capabilities or capabilities
  lspconfig[server.name].setup(config)
end
