local options = {
  ensure_installed = {
    --lua
    "lua_ls",

    -- bash
    "bashls",

    --rust
    -- "rust_analyzer",

    --python
    "pyright",

    --go
    --"golangci-lint-langserver",

    --java
    -- "jdtls",

    --ruby
    -- "ruby_ls",

    --C,C++,C#,Cmake
    "clangd",
    "cmake",
    -- "omnisharp",

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
    -- "vimls",

  },
  automatic_installation = true,
}

return options
