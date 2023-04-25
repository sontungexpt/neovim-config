local M = {}

M.lsp_exists = function()
  return vim.lsp ~= nil
end

M.create_autocmds = function()
  if not M.lsp_exists() then
    return
  end
  local create_autocmd = require('core.utils').create_autocmd
  create_autocmd(
    'BufWritePost',
    {
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
    'LspconfigAutoGroup',
    function()
      vim.cmd('LspRestart')
    end,
    false
  )
end
return M
