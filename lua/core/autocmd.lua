local autocmd = vim.api.nvim_create_autocmd

-- Don't list quickfix buffers
autocmd("FileType", {
  pattern = "qf",
  callback = function()
    vim.opt_local.buflisted = false
  end,
})

-- Support for command nvimconfig
autocmd("VimEnter", {
  pattern = { "*.lua", "*.vim" },
  callback = function()
    local current_path = vim.fn.expand("%:p")
    local config_path = vim.fn.stdpath "config"
    if current_path == config_path .. "/init.lua" or
        current_path == config_path .. "/init.vim" then
      vim.cmd("cd " .. "%:p:h")
    end
  end,
})

--Remove whitespace on save
autocmd('BufWritePre', {
  pattern = '',
  command = ":%s/\\s\\+$//e"
})

-- Move to relative line number when in visual mode
autocmd('ModeChanged', {
  pattern = '',
  command = "if mode() == 'v' | set relativenumber | else | set norelativenumber | endif"
})

--Enable syntax for .js files
-- autocmd({ "BufEnter", "BufRead", "BufNewFile" }, {
--   group = vim.api.nvim_create_augroup('EnableSyntax', {}),
--   pattern = { "*.js", "*.jsx" },
--   command = "set filetype=javascriptreact",
-- })

--Enable syntax for .json files
autocmd({ "BufEnter", "BufRead", "BufNewFile" }, {
  group = vim.api.nvim_create_augroup('EnableSyntax', {}),
  pattern = { "*.json" },
  command = "set filetype=jsonc",
})

--Enable syntax for .rasi files
autocmd({ "BufEnter", "BufRead", "BufNewFile" }, {
  group = vim.api.nvim_create_augroup('EnableSyntax', {}),
  pattern = { "*.rasi" },
  command = "set filetype=rasi",
})
