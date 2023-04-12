--Automatically install packer if it's not exist
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
    vim.cmd [[PackerSync]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

--Automatically run :PackerCompile whenever plugins.lua is updated
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
    autocmd VimEnter * PackerInstall
  augroup end
]])

local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

packer.init {
  max_jobs = nil, -- Limit the number of simultaneous jobs. nil means no limit
  auto_clean = true, -- During sync(), remove unused plugins
  compile_on_sync = true, -- During sync(), run packer.compile()
  disable_commands = false, -- Disable creating commands
  opt_default = false, -- Default to using opt (as opposed to start) plugins
  auto_reload_compiled = true, -- Automatically reload the compiled file after creating it.
  preview_updates = false, -- If true, always preview updates before choosing which plugins to update, same as `PackerUpdate --preview`.
  display = {
    -- An optional function to open a window for packer's display
    open_fn = function()
      return require('packer.util').float { border = "single" }
    end,
    jworking_sym = '⟳', -- The symbol for a plugin being installed/updated
    error_sym = '', -- The symbol for a plugin with an error in installation/updating
    done_sym = '', -- The symbol for a plugin which has completed installation/updating
    removed_sym = '', -- The symbol for an unused plugin which was removed
    moved_sym = '→', -- The symbol for a plugin which was moved (e.g. from opt to start)
    header_sym = '━', -- The symbol for the header line in packer's display
    show_all_info = true, -- Should packer show all update details automatically?
    prompt_border = 'double', -- Border style of prompt popups.
    keybindings = { -- Keybindings for the display window
      quit = 'q',
      toggle_update = 'u', -- only in preview
      continue = 'c', -- only in preview
      toggle_info = '<CR>',
      diff = 'd',
      prompt_revert = 'r',
    }
  },
  autoremove = true, -- Remove disabled or unused plugins without prompting the user
}

return packer.startup(function(use)
  use 'wbthomason/packer.nvim'

  -----------My plugins here----------

  -- nvim-tree
  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icons
    },
    tag = 'nightly', -- optional, updated every week. (see issue #1193)
    config = function()
      require("plugins.nvim-tree-config")
    end,
  }

  -- nvim-treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    requires = {
      'Fymyte/tree-sitter-rasi',
      'p00f/nvim-ts-rainbow',
      'windwp/nvim-ts-autotag',
      'Fymyte/rasi.vim',
    },
    run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end,
    config = function()
      require("plugins.nvim-treesitter-config")
    end,
  }

  -- Hightlight-colors
  use {
    'brenoprata10/nvim-highlight-colors',
    config = function()
      require("plugins.hightlight-colors-config")
    end
  }

  -- TokyoNight Theme
  use {
    'folke/tokyonight.nvim',
    config = function()
      require("plugins.ui.tokyonight-config")
    end,
  }

  -- Lspconfig
  use {
    'neovim/nvim-lspconfig',
    config = function()
      require("plugins.lsp.nvim-lspconfig-config")
    end,
  }

  -- Null-ls
  use {
    'jose-elias-alvarez/null-ls.nvim',
    config = function()
      require("plugins.lsp.null-ls-config")
    end,
  }

  -- Mason
  use {
    "williamboman/mason.nvim",
    requires = {
      'williamboman/mason-lspconfig.nvim',
    },
    config = function()
      require("plugins.lsp.mason-config")
    end,
  }

  -- Cmp
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'rafamadriz/friendly-snippets',

      -- For vsnip users
      -- 'hrsh7th/cmp-vsnip',
      -- 'hrsh7th/vim-vsnip',

      -- For ultisnips users.
      -- 'SirVer/ultisnips',
      -- 'quangnguyen30192/cmp-nvim-ultisnips',

      -- For luasnip users
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',

      -- For snippy users
      -- 'dcampos/nvim-snippy',
      -- 'dcampos/cmp-snippy'
    },
    config = function()
      require("plugins.lsp.cmp-config")
    end,
  }
  -- use {
  --   "zbirenbaum/copilot-cmp",
  --   after = { "copilot.lua" },
  --   config = function()
  --     require("copilot_cmp").setup {
  --       formatters = {
  --         label = require("copilot_cmp.format").format_label_text,
  --         insert_text = require("copilot_cmp.format").format_insert_text,
  --         preview = require("copilot_cmp.format").deindent,
  --       },
  --     }
  --   end
  -- }

  -- Shade
  -- use {
  --   'sunjon/shade.nvim',
  --   config = function()
  --     require("plugins.shade-config")
  --   end,
  -- }


  -- Markdown-preview
  -- install without yarn or npm
  use(
    {
      "iamcco/markdown-preview.nvim",
      run = function() vim.fn["mkdp#util#install"]() end,
    }
  )

  -- Dap
  -- use {
  --   "rcarriga/nvim-dap-ui",
  --   requires = {
  --     "mfussenegger/nvim-dap",
  --     "jay-babu/mason-nvim-dap.nvim",
  --     "theHamsta/nvim-dap-virtual-text",
  --   },
  --   config = function()
  --     require("plugins.debugger.nvim-dap-ui-config")
  --   end,
  -- }
  -- use {
  --   "mfussenegger/nvim-dap",
  --   config = function()
  --     require("plugins.debugger.nvim-dap-config")
  --   end,
  -- }
  -- use {
  --   "jay-babu/mason-nvim-dap.nvim",
  --   config = function()
  --     require('plugins.debugger.mason-nvim-dap-config')
  --   end
  -- }
  -- use {
  --   "theHamsta/nvim-dap-virtual-text",
  --   config = function()
  --     require("plugins.debugger.nvim-dap-virtual-text-config")
  --   end
  -- }

  -- Wilder
  use {
    'gelguy/wilder.nvim',
    requires = { 'romgrk/fzy-lua-native' },
    config = function()
      require("plugins.wilder-config")
    end,
  }

  -- Floaterm
  -- use {
  --   'voldikss/vim-floaterm',
  --   config = function()
  --     require("plugins.terminal.floaterm-config")
  --   end
  -- }

  -- Toggleterm
  use { "akinsho/toggleterm.nvim", tag = '*', config = function()
    config = function()
      require("plugins.terminal.toggleterm-config")
    end
  end }

  -- Comment
  use {
    'numToStr/Comment.nvim',
    config = function()
      require("plugins.comments.comment-config")
    end
  }

  -- Todo-comments
  use {
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("plugins.comments.todo-comments-config")
    end
  }

  -- Telescope
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.1',
    -- or                            , branch = '0.1.x',
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-lua/popup.nvim',
      'jvgrootveld/telescope-zoxide',
      'nvim-telescope/telescope-fzy-native.nvim',
      'nvim-telescope/telescope-project.nvim',
      'nvim-telescope/telescope-media-files.nvim',
      'BurntSushi/ripgrep',
      'sharkdp/fd'
    },
    config = function()
      require("plugins.telescope.telescope-config")
    end,
  }

  -- Neoclip
  use {
    "AckslD/nvim-neoclip.lua",
    requires = {
      {
        'kkharji/sqlite.lua',
        module = 'sqlite'
      },
      -- you'll need at least one of these
      {
        'nvim-telescope/telescope.nvim'
      },
      -- {'ibhagwan/fzf-lua'},
    },
    config = function()
      require('plugins.telescope.nvim-neoclip-config')
    end,
  }

  -- Which-key
  use {
    "folke/which-key.nvim",
    config = function()
      require("plugins.which-key-config")
    end,
  }

  -- Nvim-cursorline
  use {
    'yamatsum/nvim-cursorline',
    config = function()
      require("plugins.nvim-cursorline-config")
    end,
  }


  --Color Picker
  use {
    'uga-rosa/ccc.nvim',
    config = function()
      require("plugins.color-picker-config")
    end,
  }

  -- Pretty-fold - fold-preview
  use { 'anuvyklack/fold-preview.nvim',
    requires = 'anuvyklack/keymap-amend.nvim',
    config = function()
      require('plugins.fold.fold-preview-config')
    end,
  }

  use {
    'anuvyklack/pretty-fold.nvim',
    config = function()
      require('plugins.fold.pretty-fold-config')
    end
  }

  -- use {
  --   'kevinhwang91/nvim-ufo',
  --   requires = 'kevinhwang91/promise-async',
  --   config = function()
  --     require('plugins.fold.nvim-ufo-config')
  --   end
  -- }


  --Lualine
  use {
    'nvim-lualine/lualine.nvim',
    requires = {
      'kyazdani42/nvim-web-devicons',
      opt = true
    },
    config = function()
      require("plugins.ui.lualine-config")
    end
  }

  -- Bufferline
  use {
    'akinsho/bufferline.nvim', tag = "v3.*",
    requires = 'nvim-tree/nvim-web-devicons',
    config = function()
      require("plugins.ui.bufferline-config")
    end
  }

  --Nvim-autopairs
  use {
    "windwp/nvim-autopairs",
    config = function()
      require("plugins.nvim-autopairs-config")
    end
  }

  --Indent-blankline
  use {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("plugins.indent-blankline-config")
    end,
  }

  --Github Copilot
  use {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("plugins.copilot-config")
    end,
  }

  -- Nvim-surround
  use({
    "kylechui/nvim-surround",
    tag = "*", -- Use for stability; omit to use `main` branch for the latest features
    config = function()
      require("plugins.nvim-surround-config")
    end
  })

  -- Git Signs
  use {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('plugins.git.gitsigns-config')
    end
  }
  -- Git Conflict
  use { 'akinsho/git-conflict.nvim', tag = "*", config = function()
    require('plugins.git.git-conflict-config')
  end }

  -- Neoscroll
  -- use {
  --   'karb94/neoscroll.nvim',
  --   config = function()
  --     require("plugins.neoscroll-config")
  --   end,
  -- }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
