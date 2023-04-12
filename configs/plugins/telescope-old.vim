Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
Plug 'jvgrootveld/telescope-zoxide'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'nvim-telescope/telescope-project.nvim'
Plug 'nvim-telescope/telescope-media-files.nvim'

"  Plug 'BurntSushi/ripgrep'
"  Plug 'sharkdp/fd'

"----------TeleScope----------"

" Mappings
nnoremap <C-p>          <cmd>Telescope find_files<cr>
nnoremap <leader>fm     <cmd>Telescope media_files<cr>
nnoremap <leader>fg     <cmd>Telescope live_grep<cr>
nnoremap <leader>fb     <cmd>Telescope buffers<cr>
nnoremap <leader>fh     <cmd>Telescope help_tags<cr>
nnoremap <leader>fp     <cmd>Telescope project<cr>


function SetupTelescope()
lua << EOF
  local actions = require("telescope.actions")
  -- require('telescope').load_extension('media')
  require('telescope').load_extension('media_files')
  require('telescope').load_extension('zoxide')
  require('telescope').load_extension('project')
  require('telescope').load_extension('fzy_native')

  require('telescope').setup({
    defaults = {
      layout_config = {
        horizontal = {
          prompt_position = "top",
          preview_width = 0.55,
          results_width = 0.8,
        },
        vertical = {
          mirror = false,
        },
        width = 0.87,
        height = 0.9,
        preview_cutoff = 120
      },
      prompt_prefix = "   ",
      selection_caret = "  ",
      entry_prefix = "  ",
      initial_mode = "insert",
      selection_strategy = "reset",
      sorting_strategy = "ascending",
      layout_strategy = "horizontal",
      find_command = {
        'rg', '--no-heading', '--with-filename', '--line-number', '--column', '--smart-case'
      },
      mappings = {
        i = {
          ["<esc>"] = actions.close,
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
        }
      },
      file_ignore_patterns = {
        "^.git/",
        "^./.git/",
        "^node_modules/",
        "^vendor/",
      },
      file_sorter = require 'telescope.sorters'.get_fuzzy_file,
      generic_sorter = require 'telescope.sorters'.get_generic_fuzzy_sorter,
      path_display = { "smart" },
      winblend = 0,
      border = {},
      borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
      color_devicons = true,
      use_less = true,
      set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
      file_previewer = require 'telescope.previewers'.vim_buffer_cat.new,
      grep_previewer = require 'telescope.previewers'.vim_buffer_vimgrep.new,
      qflist_previewer = require 'telescope.previewers'.vim_buffer_qflist.new,
      buffer_previewer_maker = require 'telescope.previewers'.buffer_previewer_maker,
    },
    pickers = {
      find_files = {
          hidden = true
      }
    },
    extensions = {
      media_files = {
        media_files = {
          filetypes = { "png", "webp", "jpg", "jpeg", "webm", "pdf", "mp4" },
          find_cmd = "rg", -- find command (defaults to `fd`)
        },
      },
      media = {
        backend = "ueberzug", -- "ueberzug"|"viu"|"chafa"|"jp2a"|catimg
        hidden = false,
        cache_path = "/tmp/tele.media.cache",
      }
    }
  })
EOF
endfunction

" Run the telescope setup options when neovim loaded
augroup TelescopeOverrides
    autocmd!
    autocmd User PlugLoaded call SetupTelescope()
augroup END
