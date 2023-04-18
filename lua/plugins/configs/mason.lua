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
    "blade-formatter",

    -- others
    "codespell",

    -- web-developments
    "prettierd",
    "eslint-lsp",
    "css-lsp",
    "html-lsp",
    "typescript-language-server",
    "deno",
    "emmet-ls",
    "json-lsp",
    "tailwindcss-language-server",


    -- debuggers
    -- "debugpy",
    "codelldb",
    -- "bash-debug-adapter",

  }, -- not an option from mason.nvim
  PATH = "skip",
  ui = {
    -- Whether to automatically check for new versions when opening the :Mason window.
    check_outdated_packages_on_open = true,
    -- Accepts same border values as |nvim_open_win()|.
    border = "single",
    -- - Width and height of the UI window.
    -- - Integer greater than 1 for fixed width.
    -- - Float in the range of 0-1 for a percentage of screen width.
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
