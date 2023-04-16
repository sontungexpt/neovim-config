require("core.providers")
require("core.options")
require("core.autocmd")
require("core.keymaps")
require("core.plugins-keymaps")

-- add binaries installed by mason.nvim to path
local is_windows = vim.loop.os_uname().sysname == "Windows_NT"
vim.env.PATH = vim.env.PATH .. (is_windows and ";" or ":") .. vim.fn.stdpath "data" .. "/mason/bin"
