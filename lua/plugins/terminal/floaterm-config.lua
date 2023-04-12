--Floaterm appearance
vim.g.floaterm_wintype = "float"
-- vim.g.floaterm_title = "Terminal: $1/$2"
vim.g.floaterm_title = "$1/$2"
vim.g.floaterm_width = 0.9
vim.g.floaterm_height = 0.85
vim.g.floaterm_shell = "zsh"

--vim.cmd[[hi Floaterm guibg=black]]

--Set floating window border line color to cyan, and background to orange
vim.cmd [[hi FloatermBorder guifg=#ffffff]]
