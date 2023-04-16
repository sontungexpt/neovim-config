local config = require("core.utils").load_config()
local autocmd = vim.api.nvim_create_autocmd
local cmd = vim.cmd
local g = vim.g


-- Don't list quickfix buffers
autocmd("FileType", {
  pattern = "qf",
  callback = function()
    vim.opt_local.buflisted = false
  end,
})

-- Reload config on-save
-- autocmd("BufWritePost", {
--   pattern = vim.tbl_map(
--     vim.fs.normalize,
--     vim.fn.glob(vim.fn.stdpath "config" .. "/lua/**/*.lua", true, true, true)
--   ),
--   group = vim.api.nvim_create_augroup("ReloadConfig", {}),
--   callback = function(opts)
--     require("core.utils").source_config_file(vim.fn.stdpath "config" .. "/lua/")
--   end,
-- })

--Remove whitespace on save
autocmd('BufWritePre', {
  pattern = '',
  command = ":%s/\\s\\+$//e"
})

-- Move to relative line number when in visual mode
cmd([[ autocmd ModeChanged * if mode() == 'v' | set relativenumber | else | set norelativenumber | endif ]])
