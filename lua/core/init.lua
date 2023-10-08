require("core.user_command")
require("core.providers")
require("core.options")
require("core.autocmd")
require("core.keymaps")
require("core.plugmaps")

-- add binaries installed by mason.nvim to path
local is_windows = vim.loop.os_uname().sysname == "Windows_NT"
vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin" .. (is_windows and ";" or ":") .. vim.env.PATH
