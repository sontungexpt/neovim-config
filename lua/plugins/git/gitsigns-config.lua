local status_ok, gitsigns = pcall(require, "gitsigns")
if not status_ok then
  return
end

gitsigns.setup {
  signs                        = {
    -- add          = { text = '│' },
    add          = { text = '+' },
    change       = { text = '│' },
    delete       = { text = '_' },
    topdelete    = { text = '‾' },
    changedelete = { text = '~' },
    untracked    = { text = '┆' },
  },
  signcolumn                   = true, -- Toggle with `:Gitsigns toggle_signs`
  numhl                        = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl                       = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff                    = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir                 = {
    interval = 1000,
    follow_files = true
  },
  attach_to_untracked          = true,
  current_line_blame           = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts      = {
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 500,
    ignore_whitespace = false,
  },
  current_line_blame_formatter = '<author>, <author_time:%d-%m-%Y> - <summary>',
  sign_priority                = 6,
  update_debounce              = 100,
  status_formatter             = nil, -- Use default
  max_file_length              = 40000, -- Disable if file is longer than this (in lines)
  preview_config               = {
    -- Options passed to nvim_open_win
    border = 'single',
    style = 'minimal',
    relative = 'cursor',
    row = 0,
    col = 1
  },
  yadm                         = {
    enable = false
  },
  on_attach                    = function(bufnr)
    local function map(mode, lhs, rhs, opts)
      opts = vim.tbl_extend('force', { noremap = true, silent = true }, opts or {})
      vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
    end
    -- Navigation
    map('n', ']g', "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", { expr = true })
    map('n', '[g', "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", { expr = true })
    map('n', '<leader>gs', ':Gitsigns stage_hunk<CR>')
    map('v', '<leader>gs', '<cmd>Gitsigns stage_buffer<CR>')
    map('n', '<leader>gr', ':Gitsigns reset_hunk<CR>')
    map('v', '<leader>gr', ':Gitsigns reset_hunk<CR>')
    map('n', '<leader>gu', '<cmd>Gitsigns undo_stage_hunk<CR>')
    map('n', '<leader>gR', '<cmd>Gitsigns reset_buffer<CR>')
    map('n', '<leader>gp', '<cmd>Gitsigns preview_hunk<CR>')
    map('n', '<leader>gb', '<cmd>lua require"gitsigns".blame_line{full=true}<CR>')
    map('n', '<leader>gd', '<cmd>Gitsigns diffthis<CR>')
    map('n', '<leader>gD', '<cmd>lua require"gitsigns".diffthis("~")<CR>')
    map('n', '<leader>gd', '<cmd>Gitsigns toggle_deleted<CR>')

    -- Text object
    -- map('o', 'ih', ':<C-U>Gitsigns select_hunk<CR>')
    -- map('x', 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  end
}

vim.cmd [[set statusline+=%{get(b:,'gitsigns_status','')}]]
