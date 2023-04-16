-- Map to a Lua function:
-- vim.keymap.set('n', 'lhs', function() print("real lua function") end)

-- Map to multiple modes:
-- vim.keymap.set({'n', 'v'}, '<leader>lr', vim.lsp.buf.references, { buffer=true })

-- Buffer-local mapping:
-- vim.keymap.set('n', '<leader>w', "<cmd>w<cr>", { silent = true, buffer = 5 })

-- Expr mapping:
-- vim.keymap.set('i', '<Tab>', function()
-- return vim.fn.pumvisible() == 1 and "<C-n>" or "<Tab>"
-- end, { expr = true })

-- <Plug> mapping:
-- vim.keymap.set('n', '[%', '<Plug>(MatchitNormalMultiBackward)')

-----------Mappings----------
-- n, v, i, t = mode names
-- default opts = 1
-- opts = 1 for noremap and silent
-- opts = 2 for not noremap and silent
-- opts = 3 for noremap and not silent
-- opts = 4 for not noremap and not silent
-- opts = 5 for expr and noremap and silent
local autocmd = vim.api.nvim_create_autocmd
local map = function(mode, key, map_to, opts)
  local keymap = vim.keymap.set
  local opts1 = { noremap = true, silent = true }
  opts = opts or 1
  if type(opts) == "table" then
    opts = vim.tbl_deep_extend("force", opts1, opts)
    keymap(mode, key, map_to, opts)
    return
  end

  if opts == 1 then
    opts = opts1
  elseif opts == 2 then
    opts = { noremap = false, silent = true }
  elseif opts == 3 then
    opts = { noremap = true, silent = false }
  elseif opts == 4 then
    opts = { noremap = false, silent = false }
  elseif opts == 5 then
    opts = { expr = true, replace_keycodes = true, noremap = true, silent = true }
  else
    opts = opts1
  end
  keymap(mode, key, map_to, opts)
end

--Back to normal mode
map({ "i", "c" }, "jj", "<esc>", 2)

--Back to insert mode
map("v", "i", "<esc>i", 2)

--Save file as the traditional way
map({ "n", "i", "v", "c" }, "<C-s>", "<esc>:w<cr>", 2)

--ctrl z to undo and move to normal mode
-- map({ "n", "i", "v" }, "<C-z>", "<esc>u")

--ctrl a to selected all text in file
map({ "n", "i", "v" }, "<C-a>", "<esc>ggVG", 1)

--The arrow keys in the insert mode
map("i", "<C-j>", "<Down>", 2)
map("i", "<C-k>", "<Up>", 2)
map("i", "<C-h>", "<Left>", 2)
map("i", "<C-l>", "<Right>", 2)

--Change the buffer
map("n", "]b", ":bnext<cr>")
map("n", "[b", ":bNext<cr>")

--Go to the current path
map({ "n", "v" }, "cd", "<esc>:cd %:p:h<cr>:pwd<cr>", 3)

--Close Buffer
map({ "n", "v" }, "Q", "<esc>:bd<cr>", 1)

--Open the link with default browser
map({ "n", "v" }, "gx", "<esc>:execute 'silent! !xdg-open ' . shellescape(expand('<cWORD>'), 1)<cr>", 1)

--Clean searching
map({ "n", "v" }, "C", "<esc>:noh<cr>:set ignorecase<cr>")

--Resize Buffer
map("n", "<A-j>", ":resize +1<cr>", 1)
map("n", "<A-k>", ":resize -1<cr>", 1)
map("n", "<A-l>", ":vertical resize -1<cr>", 1)
map("n", "<A-h>", ":vertical resize +1<cr>", 1)

--Layout
--Make all windows (almost) equally high and wide
map("n", "=", "<C-W>=", 1)

--Change the layout to horizohkkntal
map("n", "gv", "<C-w>t<C-w>H", 1)

--Change the layout to vertical
map("n", "gh", "<C-w>t<C-w>K", 1)

-- Split horizontally
map("n", "<A-s>", "<C-w>s", 1)

-- Split vertically
map("n", "<A-v>", "<C-w>v", 1)

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


-- Replace the word under the cursor if the word is not blank
-- vim.keymap.set('n', '<Leader>s', function()
--   if vim.fn.expand("<cword>") ~= "" then
--     return [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]]
--   end
-- end, { expr = true, noremap = true, silent = true })
