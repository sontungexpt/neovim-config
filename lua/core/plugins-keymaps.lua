-- n, v, i, t = mode names
-- default opts = 1
-- opts = 1 for noremap and silent
-- opts = 2 for not noremap and silent
-- opts = 3 for noremap and not silent
-- opts = 4 for not noremap and not silent
-- opts = 5 for expr and noremap and silent
--
local api = vim.api
local autocmd = api.nvim_create_autocmd
local map = require("core.utils").map

--NvimTree
map({ "n", "i", "v", "c" }, "<C-b>", function()
	if vim.bo.filetype == "TelescopePrompt" then
		return
	end
	api.nvim_command("NvimTreeToggle")
end, { desc = "Toggle NvimTree" })

-- kill terminal buffer
map("t", "<C-q>", "<C-\\><C-n>:q!<cr>")
map("t", "<A-q>", "<C-\\><C-n>:q!<cr>")

--Telescope
map({ "n", "i", "v" }, "<C-p>", "<esc>:Telescope find_files<cr>", { desc = "Find files" })
map("n", "<leader>fm", "<esc>:Telescope media_files<cr>", { desc = "Find media files" })
map("n", "<leader>fg", "<esc>:Telescope live_grep<cr>", { desc = "Find word" })
map("n", "<C-f>", "<esc>:Telescope live_grep<cr>", { desc = "Find word" })
map("n", "<leader>fb", "<esc>:Telescope buffers<cr>", { desc = "Find buffers" })
map("n", "<leader>fh", "<esc>:Telescope help_tags<cr>", { desc = "Find help tags" })
map("n", "<leader>fp", "<esc>:Telescope project<cr>", { desc = "Find project" })

-- Todo-comments
map("n", "<Leader>ft", function()
	local buftype = api.nvim_buf_get_option(0, "buftype")
	api.nvim_command(buftype == "quickfix" and "bd" or "TodoQuickFix")
end, { desc = "Toggle todo quickfix" })

map("n", "<Leader>fc", function()
	local buftype = api.nvim_buf_get_option(0, "buftype")
	api.nvim_command(buftype == "quickfix" and "bd" or "GitConflictListQf")
end, { desc = "Toggle git conflict quickfix" })

map("n", "[t", function()
	local status_ok, todo_comments = pcall(require, "todo-comments")
	if status_ok then
		todo_comments.jump_prev()
	else
		print("Todo-comments not found")
	end
end, { desc = "Previous todo comment" })

map("n", "]t", function()
	local status_ok, todo_comments = pcall(require, "todo-comments")
	if status_ok then
		todo_comments.jump_next()
	else
		print("Todo-comments not found")
	end
end, { desc = "Next todo comment" })

map("n", "[T", function()
	local status_ok, todo_comments = pcall(require, "todo-comments")
	if status_ok then
		todo_comments.jump_prev { keywords = { "ERROR", "WARNING" } }
	else
		print("Todo-comments not found")
	end
end, { desc = "Previous error/ warning comment" })

map("n", "]T", function()
	local status_ok, todo_comments = pcall(require, "todo-comments")
	if status_ok then
		todo_comments.jump_next { keywords = { "ERROR", "WARNING" } }
	else
		print("Todo-comments not found")
	end
end, { desc = "Next error/ warning comment" })

--ccc (Color-picker)
map({ "n", "i", "v" }, "<A-c>", "<esc>:CccPick<cr>")

-- Bufferline
autocmd("VimEnter", {
	pattern = "",
	command = "nnoremap <silent><Space> <Cmd>exe 'BufferLineGoToBuffer ' . v:count1<CR>",
})

-- Markdown
map("n", "<Leader>p", "<Cmd>MarkdownPreviewToggle<CR>")

-- LSP-saga
-- Only create keymap for lsp-saga if lsp is attached
autocmd("LspAttach", {
	desc = "Lspsaga actions",
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
		-- map("n", "gt", "<cmd>Lspsaga goto_type_definition<CR>")

		map("n", "K", "<cmd>Lspsaga hover_doc<CR>")
		-- To disable it just use ":Lspsaga hover_doc ++quiet"
		-- If you want to keep the hover window in the top right hand corner,
		-- you can pass the ++keep argument
		-- Note that if you use hover with ++keep, pressing this key again will
		map("n", "<leader>sk", "<cmd>Lspsaga hover_doc ++keep<CR>")

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
		map("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
		map("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>")

		-- Diagnostic jump with filters such as only jumping to an error
		map("n", "[e", function()
			local status_ok, lspsaga_diagnostic = pcall(require, "lspsaga.diagnostic")
			if status_ok then
				lspsaga_diagnostic:goto_prev { severity = vim.diagnostic.severity.ERROR }
			else
				print("Lspsaga.diagnostic not found")
			end
		end)
		map("n", "]e", function()
			local status_ok, lspsaga_diagnostic = pcall(require, "lspsaga.diagnostic")
			if status_ok then
				lspsaga_diagnostic:goto_next { severity = vim.diagnostic.severity.ERROR }
			else
				print("Lspsaga.diagnostic not found")
			end
		end)

		---- Toggle outline
		map("n", "<leader>so", "<cmd>Lspsaga outline<CR>")

		-- -- Call hierarchy
		-- map("n", "<Leader>ci", "<cmd>Lspsaga incoming_calls<CR>")
		-- map("n", "<Leader>co", "<cmd>Lspsaga outgoing_calls<CR>")
	end,
})

local continue_debugging = require("plugins.configs.dap.utils").continue_debugging

-- dap
map("n", "<leader>du", function()
	require("dapui").toggle()
end, { desc = "Toggle DAP UI" })
map("n", "<leader>db", ":lua require'dap'.toggle_breakpoint()<CR>", { desc = "Toggle breakpoint" })
map("n", "<leader>di", ":lua require'dap'.step_into()<CR>", { desc = "Step into" })
map("n", "<leader>do", ":lua require'dap'.step_over()<CR>", { desc = "Step over" })
map("n", "<leader>dc", function()
	continue_debugging()
end, { desc = "Continue or start debugging" })
map(
	"n",
	"<leader>dd",
	":lua require 'dap'.disconnect()<CR>:lua require'dap'.close()<CR>",
	{ desc = "Disconnect from debugger" }
)
-- map("n", "<leader>dc", ":lua require'dap'.continue()<CR>")
map("n", "<F11>", ":lua require'dap'.step_into()<CR>", { desc = "Step into" })
map("n", "<F12>", ":lua require'dap'.step_over()<CR>", { desc = "Step over" })
map("n", "<F5>", function()
	continue_debugging()
end, { desc = "Continue or start debugging" })
map(
	"n",
	"<F4>",
	":lua require 'dap'.disconnect()<CR>:lua require'dap'.close()<CR>",
	{ desc = "Disconnect from debugger" }
)

map("n", "<Leader>dr", ":lua require('dap').repl.open()<CR>", { desc = "Open REPL" })
map("n", "<Leader>dl", ":lua require('dap').run_last()<CR>", { desc = "Run last" })
map({ "n", "v" }, "<Leader>dh", ":lua require('dap.ui.widgets').hover()<CR>", { desc = "Hover" })
map({ "n", "v" }, "<Leader>dp", ":lua require('dap.ui.widgets').preview()<CR>", { desc = "Preview" })
map("n", "<Leader>df", function()
	local widgets = require("dap.ui.widgets")
	widgets.centered_float(widgets.frames)
end, { desc = "Frames" })
map("n", "<Leader>ds", function()
	local widgets = require("dap.ui.widgets")
	widgets.centered_float(widgets.scopes)
end, { desc = "Scopes" })

-- wilder (this is more keymap to use wilder easily)
-- default keymap is set in plugins.configs.wilder
map("c", "<C-j>", "wilder#in_context() ? wilder#next() : '<Tab>'", 5)
map("c", "<C-k>", "wilder#in_context() ? wilder#previous() : '<S-Tab>'", 5)
