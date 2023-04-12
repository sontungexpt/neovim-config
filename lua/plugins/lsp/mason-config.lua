local mason_status_ok, mason = pcall(require, "mason")
if not mason_status_ok then
  return
end

mason.setup {
  ui = {
    icons = {
      package_pending = " ",
      package_installed = " ",
      package_uninstalled = " ",
    },
  },
  ensure_installed = {
    "prettierd",
    "clang-format",
    "codespell",
    "codelldb"
  }
}

local mason_lspconfig_status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status_ok then
  return
end

mason_lspconfig.setup {
  ensure_installed = {
    --lua
    "lua_ls",

    -- bash
    "bashls",

    --rust
    "rust_analyzer",

    --python
    "pyright",

    --go
    --"golangci-lint-langserver",

    --java
    "jdtls",

    --ruby
    "ruby_ls",

    --C,C++,C#,Cmake
    "clangd",
    "cmake",
    "omnisharp",

    -- web dev
    "cssls",
    "html",
    "eslint",
    "tsserver",
    "denols",
    "emmet_ls",
    "jsonls",
    "tailwindcss",

    --vim
    "vimls",

  },
  automatic_installation = true,
}
