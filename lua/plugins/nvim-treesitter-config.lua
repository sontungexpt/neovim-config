local status_ok, nvim_treesitter = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end

vim.api.nvim_create_autocmd({ 'BufEnter', 'BufAdd', 'BufNew', 'BufNewFile', 'BufWinEnter' }, {
  group = vim.api.nvim_create_augroup('TS_FOLD_WORKAROUND', {}),
  callback = function()
    vim.opt.foldmethod = 'expr'
    vim.opt.foldexpr   = 'nvim_treesitter#foldexpr()'
  end
})

nvim_treesitter.setup {
  ensure_installed = "all",
  ignore_install = {},
  highlight = {
    enable = true,
    --disable ={"html","css"}
    --disable = {"html","javascript","css"}
  },
  indent = {
    enable = true
  },
  additional_vim_regex_highlighting = false,
  autotag = {
    enable = true,
    filetypes = { "html", "xml", "jsx", "javascriptreact", "javascript", "typescriptreact", "typescript", "tsx" },
  },
  autopairs = {
    enable = true,
  },
  rainbow = {
    enable = true,
    disable = { "html", "javascript" }, --list of languages you want to disable the plugin for
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
    colors = {
      "#ec5f67",
      "#FF8800",
      "#f9b71f",
      "#eddc38",
      "#ECBE7B",
      "#98be65",
      "#01AE6E",
      "#10e8c3",
      "#169ed8",
      "#2f73e2",
      "#1c73e9",
      "#01519A",
      "#2d3ae6",
      "#c678dd",
      "#b438f3",
      "#d906f0",
      "#f404b4",
      "#f00483"
    }, -- table of hex strings
    -- termcolors = {} -- table of colour name strings
  }
}
vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(

  vim.lsp.diagnostic.on_publish_diagnostics,
  {
    underline = true,
    virtual_text = {
      spacing = 5,
      severity_limit = 'Warning',
    },
    update_in_insert = true,
  })
