-- n, v, i, t, x = mode names
-- default opts = 1
-- opts = 1 for noremap and silent
-- opts = 2 for not noremap and silent
-- opts = 3 for noremap and not silent
-- opts = 4 for not noremap and not silent
-- opts = 5 for expr and noremap and silent

local utils = require("core.utils")
local map = utils.map

-- Remap for dealing with word wrap
-- map({ "n", "x" }, "k", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', 5)
-- map({ "n", "x" }, "j", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', 5)
-- map({ "n", "v" }, "<Up>", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', 5)
-- map({ "n", "v" }, "<Down>", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', 5)

--Back to normal mode
map({ "i", "c" }, "jj", "<esc>", 2)

--Back to insert mode
map("v", "i", "<esc>i")

--Save file as the traditional way
map({ "n", "i", "v", "c" }, "<C-s>", "<esc>:w<cr>", 2)

--ctrl a to selected all text in file
map({ "n", "i", "v" }, "<C-a>", "<esc>ggVG")

--The arrow keys in the insert mode
map("i", "<C-j>", "<Down>")
map("i", "<C-k>", "<Up>")
map("i", "<C-h>", "<Left>")
map("i", "<C-l>", "<Right>")

--Change the buffer
map("n", "]b", ":bnext<cr>")
map("n", "[b", ":bNext<cr>")

--Go to the current path
map({ "n", "v" }, "cd", "<esc>:cd %:p:h<cr>:pwd<cr>", 3)

--Close Buffer
map({ "n", "v" }, "Q", "<esc>:bd<cr>")

--Open the link with default browser
map({ "n", "v" }, "gx", function()
	require("core.url-helpers").open_url()
end, { desc = "Open URL under cursor" })

--Clean searching
map({ "n", "v" }, "C", "<esc>:noh<cr>:set ignorecase<cr>")

--Resize Buffer
map("n", "<A-j>", ":resize +1<cr>")
map("n", "<A-k>", ":resize -1<cr>")
map("n", "<A-l>", ":vertical resize -1<cr>")
map("n", "<A-h>", ":vertical resize +1<cr>")

--Make all windows (almost) equally high and wide
map("n", "=", "<C-W>=")

--Change the layout to horizohkkntal
map("n", "gv", "<C-w>t<C-w>H")

--Change the layout to vertical
map("n", "gh", "<C-w>t<C-w>K")

-- Split horizontally
map("n", "<A-s>", function()
	local status_ok = utils.is_plugin_installed("focus.nvim") and vim.fn.exists("FocusSplitDown") ~= 0
	vim.api.nvim_command(status_ok and "FocusSplitDown" or "split")
end, { desc = "Split Down" })

-- Split vertically
map("n", "<A-v>", function()
	local status_ok = utils.is_plugin_installed("focus.nvim") and vim.fn.exists("FocusSplitRight") ~= 0
	vim.api.nvim_command(status_ok and "FocusSplitRight" or "vsplit")
end, { desc = "Split Right" })

--Move between windows
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

--Swap up one row
map("n", "<A-Up>", ":m .-2<CR>==")
map("v", "<A-Up>", ":m '<-2<CR>gv=gv")

--Swap down one row
map("n", "<A-Down>", ":m .+1<CR>==")
map("v", "<A-Down>", ":m '>+1<CR>gv=gv")
