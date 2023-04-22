local options = {
  ensure_installed = {
    -- lua
    "lua-language-server",
    "stylua",

    -- bash
    "bash-language-server",
    "shfmt",
    "shellcheck",

    -- c++
    "clangd",
    "clang-format",
    "cmake-language-server",
    "cmakelang",

    -- python
    "pyright",
    "autopep8",
    "flake8",
    -- "blade-formatter",

    -- others
    "codespell",

    -- web-developments
    "prettier",
    "eslint-lsp",
    "css-lsp",
    "html-lsp",
    "typescript-language-server",
    -- "deno",
    "emmet-ls",
    "json-lsp",
    "tailwindcss-language-server",

    -- debugger adapters
    -- "debugpy",
    -- "codelldb",
    -- "bash-debug-adapter",

  },
  PATH = "skip",
  ui = {
    check_outdated_packages_on_open = true,
    -- Accepts same border values as |nvim_open_win()|.
    border = "single",
    width = 0.8,
    height = 0.9,
    icons = {
      package_pending = " ",
      package_installed = " ",
      package_uninstalled = " ",
    },
    keymaps = {
      toggle_server_expand = "<CR>",
      install_server = "i",
      update_server = "u",
      check_server_version = "c",
      update_all_servers = "U",
      check_outdated_servers = "C",
      uninstall_server = "X",
      cancel_installation = "<C-c>",
      apply_language_filter = "<C-f>",
    },
  },
  max_concurrent_installers = 10,
}

return options
