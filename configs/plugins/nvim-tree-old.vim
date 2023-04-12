Plug 'nvim-tree/nvim-tree.lua'
Plug 'nvim-tree/nvim-web-devicons'


"-----------NvimTree----------"
" Mappings 
nnoremap <silent><C-b> :NvimTreeToggle<CR>
inoremap <silent><C-b> <ESC>:NvimTreeToggle<CR>
vnoremap <silent><C-b> <ESC>:NvimTreeToggle<CR>


function SetupNvimTree()
lua << EOF
-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1

vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- empty setup using defaults
  require("nvim-tree").setup {
    auto_reload_on_write = true,
    disable_netrw = false,
    hijack_cursor = false,
    hijack_netrw = false,
    hijack_unnamed_buffer_when_opening = false,
    ignore_buffer_on_setup = false,
    open_on_setup = false,
    open_on_setup_file = false,
    sort_by = "name",
    root_dirs = {},
    prefer_startup_root = false,
    sync_root_with_cwd = true,
    reload_on_bufenter = false,
    respect_buf_cwd = false,
    on_attach = "disable",
    remove_keymaps = false,
    select_prompts = false,
    view = {
      centralize_selection = false,
      cursorline = true,
      debounce_delay = 15,
      width = 28,
      hide_root_folder = false,
      side = "left",
      preserve_window_proportions = false,
      number = false,
      relativenumber = false,
      signcolumn = "yes",
      mappings = {
        custom_only = false,
        list = {
          { key = { "<CR>", "o", "<2-LeftMouse>" }, action = "edit" },
          { key = "<C-e>",                          action = "edit_in_place" },
          { key = "O",                              action = "edit_no_picker" },
          { key = { "cd" },                         action = "cd" },
          { key  = "v",                             action = "vsplit"},
          { key = "s",                              action = "split" },
          { key = "<C-t>",                          action = "tabnew" },
          { key = "<",                              action = "prev_sibling" },
          { key = ">",                              action = "next_sibling" },
          { key = "P",                              action = "parent_node" },
          { key = "<BS>",                           action = "close_node" },
          { key = "<Tab>",                          action = "preview" },
          { key = "K",                              action = "first_sibling" },
          { key = "J",                              action = "last_sibling" },
          { key = "C",                              action = "toggle_git_clean" },
          { key = "I",                              action = "toggle_git_ignored" },
          { key = "H",                              action = "toggle_dotfiles" },
          { key = "B",                              action = "toggle_no_buffer" },
          { key = "U",                              action = "toggle_custom" },
          { key = "R",                              action = "refresh" },
          { key = "a",                              action = "create" },
          { key = "D",                              action = "remove" },
          { key = "dd",                             action = "trash" },
          { key = "r",                              action = "rename" },
          { key = "<C-r>",                          action = "full_rename" },
          { key = "e",                              action = "rename_basename" },
          { key = "x",                              action = "cut" },
          { key = "yy",                             action = "copy" },
          { key = "p",                              action = "paste" },
          { key = "yn",                             action = "copy_name" },
          { key = "yt",                             action = "copy_path" },
          { key = "yp",                             action = "copy_absolute_path" },
          { key = "[e",                             action = "prev_diag_item" },
          { key = "[c",                             action = "prev_git_item" },
          { key = "-",                              action = "dir_up" },
          { key = "S",                              action = "system_open" },
          { key = "f",                              action = "live_filter" },
          { key = "F",                              action = "clear_live_filter" },
          { key = "q",                              action = "close" },
          { key = "W",                              action = "collapse_all" },
          { key = "E",                              action = "expand_all" },
          { key = "<C-f>",                              action = "search_node" },
          { key = ".",                              action = "run_file_command" },
          { key = "<C-k>",                          action = "toggle_file_info" },
          { key = "g?",                             action = "toggle_help" },
          { key = "m",                              action = "toggle_mark" },
          { key = "bmv",                            action = "bulk_move" },
        },
      },
      float = {
        enable = false,
        quit_on_focus_loss = true,
        open_win_config = {
          relative = "editor",
          border = "rounded",
          width = 30,
          height = 30,
          row = 1,
          col = 1,
        },
      },
    },
    renderer = {
      add_trailing = false,
      group_empty = false,
      highlight_git = false,
      full_name = false,
      --highlight_opened_files = "none",
      highlight_opened_files = "none",
      highlight_modified = "none",
      --root_folder_label = ":~:s?$?/..?",
      root_folder_label = ":~:s?$?/..?",
      indent_width = 2,
      indent_markers = {
        enable = false,
        inline_arrows = true,
        icons = {
          corner = "└",
          edge = "│",
          item = "│",
          bottom = "─",
          none = " ",
        },
      },
      icons = {
        webdev_colors = true,
        git_placement = "before",
        modified_placement = "after",
        padding = " ",
        symlink_arrow = " ➛ ",
        show = {
          file = true,
          folder = true,
          folder_arrow = true,
          git = true,
          modified = true,
        },
        glyphs = {
          default = "",
          symlink = "",
          bookmark = "",
          modified = "●",
          folder = {
            arrow_closed = "",
            arrow_open = "",
            default = "",
            open = "",
            empty = "",
            empty_open = "",
            symlink = "",
            symlink_open = "",
          },
          git = {
            unstaged = "✗",
            staged = "✓",
            unmerged = "",
            renamed = "➜",
            untracked = "★",
            deleted = "",
            ignored = "◌",
          },
        },
      },
      special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
      symlink_destination = true,
    },
    hijack_directories = {
      enable = true,
      auto_open = true,
    },
    update_focused_file = {
      enable = true,
      update_root = true,
      ignore_list = {},
    },
    ignore_ft_on_setup = {},
    system_open = {
      cmd = "",
      args = {},
    },
    diagnostics = {
      enable = false,
      show_on_dirs = false,
      show_on_open_dirs = true,
      debounce_delay = 50,
      severity = {
        min = vim.diagnostic.severity.HINT,
        max = vim.diagnostic.severity.ERROR,
      },
      icons = {
        hint = "",
        info = "",
        warning = "",
        error = "",
      },
    },
    filters = {
      dotfiles = true,
      git_clean = false,
      no_buffer = false,
      custom = {
        "dotfiles",
        "yay",
        "zsh_history_fix",
        "*.pdf",
        "*.ppt",
        "*.exe",
        "Android",
        "Data/$RECYCLE.BIN",
        "Data/Program",
        "Data/System Volume Information",
        "Data/EngBreaking",
        "Data/Game",
        "Data/found.000",
        "Data/IELTS - Links",
        "Data/Shmily",
        "Data/Ảnh cá nhân",
      },
      exclude = {".config"},
    },
    filesystem_watchers = {
      enable = true,
      debounce_delay = 50,
      ignore_dirs = {"node_modules",".git", ".cache", "target", "dist"},
    },
    git = {
      enable = true,
      ignore = true,
      show_on_dirs = true,
      show_on_open_dirs = true,
      timeout = 400,
    },
    modified = { 
      enable = false,
      show_on_dirs = true,
      show_on_open_dirs = true,
    },
    actions = {
      use_system_clipboard = true,
      change_dir = {
        enable = true,
        global = false,
        restrict_above_cwd = false,
      },
      expand_all = {
        max_folder_discovery = 300,
        exclude = {},
      },
      file_popup = {
        open_win_config = {
        col = 1,
        row = 1,
        relative = "cursor",
        border = "shadow",
        style = "minimal",
        },
      },
      open_file = {
        quit_on_open = false,
        resize_window = true,
        window_picker = {
          enable = true,
          picker = "default",
          chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
          exclude = {
            filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame", "exe"},
            buftype = { "nofile", "terminal", "help" },
          },
        },
      },
      remove_file = {
        close_window = true,
      },
    },
    trash = {
      --cmd = "gio trash",
      cmd = "trash-put",
    },
    live_filter = {
      prefix = "[FILTER]: ",
      always_show_folders = true,
    },
    tab = {
      sync = {
        open = false,
        close = false,
        ignore = {},
      },
    },
    notify = {
      threshold = vim.log.levels.INFO,
    },
    ui = {
      confirm = {
        remove = true,
        trash = true,
      },
    },
    log = {
      enable = false,
      truncate = false,
      types = {
        all = false,
        config = false,
        copy_paste = false,
        dev = false,
        diagnostics = false,
        git = false,
        profile = false,
        watcher = false,
      },
    },
  } 
EOF
endfunction


" Run setup option when neovim loaded
augroup NvimTreeOverrides
    autocmd!
    autocmd User PlugLoaded call SetupNvimTree()
augroup END
