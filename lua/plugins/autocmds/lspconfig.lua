local M = {}
M.lsp_exists = function()
  local lsp = vim.lsp
  if lsp == nil then
    return false
  end
  return true
end

M.create_autocmds = function()
  if not M.lsp_exists() then
    return
  end
  local autocmd = vim.api.nvim_create_autocmd
  autocmd(
    {
      'BufWritePost',
    },
    {
      group = vim.api.nvim_create_augroup('Lspconfig', {}),
      pattern = {
        ".prettierrc",
        ".prettierrc.json",
        ".prettierrc.yml",
        ".prettierrc.yaml",
        ".prettierrc.json5",
        ".prettierrc.js",
        ".prettierrc.cjs",
        ".prettierrc.toml",
        "prettier.config.js",
        "prettier.config.cjs",
      },
      callback = function()
        vim.cmd('LspRestart')
      end
    }
  )
end
return M
