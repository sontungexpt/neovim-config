-- default opts = 1
-- opts = 1 for noremap and silent
-- opts = 2 for not noremap and silent
-- opts = 3 for noremap and not silent
-- opts = 4 for not noremap and not silent
-- opts = 5 for expr and noremap and silent
local autocmd = vim.api.nvim_create_autocmd
local map = require("core.utils").map

--NvimTree
map({ "n", "i", "v", "c" }, "<C-b>", "<esc>:NvimTreeToggle<cr>")

-- Toggle Term
-- map({ "n", "i", "v" }, "<C-t>", "<ESC><Cmd>exe v:count1 . 'ToggleTerm'<CR>")

-- kill terminal buffer
map("t", "<C-q>", "<C-\\><C-n>:q!<cr>")
map("t", "<A-q>", "<C-\\><C-n>:q!<cr>")

--Telescope
--map({ "n", "i", "v" }, "<C-p>", "<esc>:Telescope find_files<cr>")

map("n", "<leader>fm", "<esc>:Telescope media_files<cr>")
map("n", "<leader>fg", "<esc>:Telescope live_grep<cr>")
map("n", "<leader>fb", "<esc>:Telescope buffers<cr>")
map("n", "<leader>fh", "<esc>:Telescope help_tags<cr>")
map("n", "<leader>fp", "<esc>:Telescope project<cr>")
map("n", "<leader>fc", "<esc>:Telescope neoclip<cr>")

-- Todo-comments
map("n", "<Leader>ft", ":TodoTelescope<cr>")
-- map("n", "]t", ":lua require('todo-comments').jump_next()<cr>")
-- map("n", "[t", ":lua require('todo-comments').jump_prev()<cr>")

map("n", "[t", function()
  local status_ok, todo_comments = pcall(require, "todo-comments")
  if status_ok then
    todo_comments.jump_prev()
  end
end, { desc = "Previous todo comment" })

map("n", "]t", function()
  local status_ok, todo_comments = pcall(require, "todo-comments")
  if status_ok then
    todo_comments.jump_next()
  end
end, { desc = "Next todo comment" })

map("n", "[T", function()
  local status_ok, todo_comments = pcall(require, "todo-comments")
  if status_ok then
    todo_comments.jump_prev({ keywords = { "ERROR", "WARNING" } })
  end
end, { desc = "Previous error/ warning comment" })

map("n", "]T", function()
  local status_ok, todo_comments = pcall(require, "todo-comments")
  if status_ok then
    todo_comments.jump_next({ keywords = { "ERROR", "WARNING" } })
  end
end, { desc = "Next error/ warning comment" })

--ccc (Color-picker)
map({ "n", "i", "v" }, "<A-c>", "<esc>:CccPick<cr>")

-- Bufferline
map("n", "<Leader>1", "<Cmd>BufferLineGoToBuffer 1<CR>")
map("n", "<Leader>2", "<Cmd>BufferLineGoToBuffer 2<CR>")
map("n", "<Leader>3", "<Cmd>BufferLineGoToBuffer 3<CR>")
map("n", "<Leader>4", "<Cmd>BufferLineGoToBuffer 4<CR>")
map("n", "<Leader>5", "<Cmd>BufferLineGoToBuffer 5<CR>")
map("n", "<Leader>6", "<Cmd>BufferLineGoToBuffer 6<CR>")
map("n", "<Leader>7", "<Cmd>BufferLineGoToBuffer 7<CR>")
map("n", "<Leader>8", "<Cmd>BufferLineGoToBuffer 8<CR>")
map("n", "<Leader>9", "<Cmd>BufferLineGoToBuffer 9<CR>")
map("n", "<Leader>$", "<Cmd>BufferLineGoToBuffer -1<CR>")

-- Markdown
map("n", "<Leader-p>", "<Cmd>MarkdownPreviewToggle<CR>")

-- LSP-saga
-- Only create keymap for lsp-saga if lsp is attached
autocmd('LspAttach', {
  desc = 'Lspsaga actions',
  callback = function()
    -- Floating terminal
    -- keymap({ "n", "t" }, "<A-d>", "<cmd>Lspsaga term_toggle<CR>")

    -- LSP finder
    map("n", "gf", "<cmd>Lspsaga lsp_finder<CR>")

    -- Code action
    map({ "n", "v" }, "<leader>sa", "<cmd>Lspsaga code_action<CR>")

    -- Rename all occurrences of the hovered word for the entire file
    map("n", "gr", "<cmd>Lspsaga rename<CR>")
    -- Rename all occurrences of the hovered word for the selected files
    -- keymap("n", "gr", "<cmd>Lspsaga rename ++project<CR>")

    -- Peek definition
    map("n", "gp", "<cmd>Lspsaga peek_definition<CR>")

    -- Go to definition
    map("n", "gd", "<cmd>Lspsaga goto_definition<CR>")

    -- Peek type definition
    map("n", "gt", "<cmd>Lspsaga peek_type_definition<CR>")

    -- Go to type definition
    -- keymap("n", "gt", "<cmd>Lspsaga goto_type_definition<CR>")
    -- To disable it just use ":Lspsaga hover_doc ++quiet"
    map("n", "K", "<cmd>Lspsaga hover_doc<CR>")
    -- If you want to keep the hover window in the top right hand corner,
    -- you can pass the ++keep argument
    -- Note that if you use hover with ++keep, pressing this key again will
    -- keymap("n", "K", "<cmd>Lspsaga hover_doc ++keep<CR>")

    -- Show line diagnostics
    map("n", "gl", "<cmd>Lspsaga show_line_diagnostics ++unfocus<CR>")
    -- focus to the floating window after showing the diagnostics
    -- map("n", "gl", "<cmd>Lspsaga show_line_diagnostics<CR>")

    -- Show buffer diagnostics
    map("n", "<leader>sb", "<cmd>Lspsaga show_buf_diagnostics<CR>")

    -- Show workspace diagnostics
    map("n", "<leader>sw", "<cmd>Lspsaga show_workspace_diagnostics<CR>")

    -- Show cursor diagnostics
    map("n", "<leader>sc", "<cmd>Lspsaga show_cursor_diagnostics<CR>")

    -- Diagnostic jump
    -- You can use <C-o> to jump back to your previous location
    map("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
    map("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>")

    -- Diagnostic jump with filters such as only jumping to an error
    map("n", "[e", function()
      require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
    end)
    map("n", "]e", function()
      require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
    end)

    ---- Toggle outline
    map("n", "<leader>so", "<cmd>Lspsaga outline<CR>")

    -- -- Call hierarchy
    -- map("n", "<Leader>ci", "<cmd>Lspsaga incoming_calls<CR>")
    -- map("n", "<Leader>co", "<cmd>Lspsaga outgoing_calls<CR>")
  end
})
