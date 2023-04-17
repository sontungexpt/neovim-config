local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
  return
end

toggleterm.setup {
  -- size can be a number or function which is passed the current terminal
  size = function(term)
    if term.direction == "horizontal" then
      return 15
    elseif term.direction == "vertical" then
      return vim.o.columns * 0.4
    end
  end,
  open_mapping = [[<C-t>]],
  ---@diagnostic disable-next-line: unused-local
  on_open = function(term)
    local status_shade_ok, shade = pcall(require, "shade")
    if status_shade_ok then
      shade.toggle();
    end
  end,
  ---@diagnostic disable-next-line: unused-local
  on_close = function(term)
    local status_shade_ok, shade = pcall(require, "shade")
    if status_shade_ok then
      shade.toggle();
    end
  end,
  highlights = {
    -- highlights which map to a highlight group name and a table of it's values
    -- NOTE: this is only a subset of values,
    -- any group placed here will be set for the terminal window split
    Normal = { link = 'Normal'
    },
    NormalFloat = {
      link = 'Normal'
    },
    FloatBorder = {
      -- guifg = <VALUE-HERE>,
      -- guibg = <VALUE-HERE>,
      link = 'FloatBorder'
    },
  },
  -- hide the number column in toggleterm buffers
  hide_numbers = false,
  -- when neovim changes it current directory
  -- the terminal will change it's own when next it's opened
  autochdir = true,
  shade_filetypes = {},
  shade_terminals = false,
  -- the degree by which to darken to terminal colour,
  -- default: 1 for dark backgrounds, 3 for light
  shading_factor = 1,
  start_in_insert = true,
  insert_mappings = true,   -- whether or not the open mapping applies in insert mode
  persist_size = true,
  direction = 'horizontal', -- | 'horizontal' | 'window' | 'float',
  close_on_exit = true,     -- close the terminal window when the process exits
  shell = vim.o.shell,      -- change the default shell
  -- This field is only relevant if direction is set to 'float'
  float_opts = {
    border = 'single', -- single/double/shadow/curved
    width = math.floor(0.9 * vim.fn.winwidth(0)),
    height = math.floor(0.85 * vim.fn.winheight(0)),
    winblend = 3,
  },
  winbar = {
    enabled = true,
    name_formatter = function(term)
      return ""
    end
  },
}

function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', 'jj', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
  vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd([[
  augroup Terminal
    autocmd!
    autocmd TermOpen term://* lua set_terminal_keymaps()
    autocmd TermOpen term://* set nonumber norelativenumber
    autocmd TermEnter term://*toggleterm#* tnoremap <silent><c-t> <Cmd>exe v:count1 . "ToggleTerm"<CR>
  augroup END
]])
