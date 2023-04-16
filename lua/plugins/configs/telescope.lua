local options = {
  extensions_list = {
    "media",
    "media_files",
    "zoxide",
    "project",
    "fzy_native",
    -- "neoclip",
  },
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
      'rg',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
    },
    mappings = {
      i = {
        ["<esc>"] = require("telescope.actions").close,
        ["<C-j>"] = require("telescope.actions").move_selection_next,
        ["<C-k>"] = require("telescope.actions").move_selection_previous,
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
    borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
    -- borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
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
}

return options
