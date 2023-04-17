-- All plugins have lazy=true by default,to load a plugin on startup just lazy=false
local cmd = vim.cmd
local g = vim.g

local default_plugins = {
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    version = 'nightly', -- optional, updated every week. (see issue #1193)
    cmd = { "NvimTreeToggle", "NvimTreeFocus", "NvimTreeOpen" },
    opts = function()
      return require("plugins.configs.nvim-tree")
    end,
    config = function(_, opts)
      local status_ok, nvim_tree = pcall(require, "nvim-tree")

      if not status_ok then
        return
      end

      nvim_tree.setup(opts)
    end,
  },

  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    opts = function()
      return require("plugins.configs.copilot")
    end,
    config = function(_, opts)
      local status_ok, copilot = pcall(require, "copilot")

      if not status_ok then
        return
      end

      copilot.setup(opts)
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-lua/popup.nvim',
      'jvgrootveld/telescope-zoxide',
      'nvim-telescope/telescope-fzy-native.nvim',
      'nvim-telescope/telescope-project.nvim',
      'nvim-telescope/telescope-media-files.nvim',
      -- 'dharmx/telescope-media.nvim',
      -- 'BurntSushi/ripgrep',
      -- 'sharkdp/fd'
    },
    opts = function()
      return require "plugins.configs.telescope"
    end,
    config = function(_, opts)
      local status_ok, telescope = pcall(require, "telescope")
      if not status_ok then
        return
      end

      -- load telescope extensions
      for _, ext in ipairs(opts.extensions_list) do
        telescope.load_extension(ext)
      end

      telescope.setup(opts)
    end,
  },

  -- {
  --   'Fymyte/rasi.vim',
  --   dependencies = {
  --     -- 'Fymyte/tree-sitter-rasi',
  --     'nvim-treesitter/nvim-treesitter',
  --   },
  --   build = ':TSInstall rasi',
  --   init = function()
  --     -- load gitsigns only when a git file is opened
  --     vim.api.nvim_create_autocmd({ "BufRead" }, {
  --       group = vim.api.nvim_create_augroup("TreesiterrasiLazyLoad", { clear = true }),
  --       callback = function()
  --         local ext = vim.fn.expand "%:e"
  --         if ext == "rasi" then
  --           vim.api.nvim_del_augroup_by_name "TreesiterrasiLazyLoad"
  --           vim.schedule(function()
  --             -- require("lazy").load { plugins = { "tree-sitter-rasi" } }
  --             require("lazy").load { plugins = { "rasi.vim" } }
  --           end)
  --         end
  --       end,
  --     })
  --   end,
  -- },

  {
    'windwp/nvim-ts-autotag',
    dependencies = {
      'nvim-treesitter/nvim-treesitter'
    },
    ft = {
      'html',
      'javascript',
      'javascriptreact',
      'typescriptreact',
      'svelte',
      'vue',
      'typescript',
      'tsx',
      'jsx'
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      --'p00f/nvim-ts-rainbow',

      -- The new plugins
      'HiPhish/nvim-ts-rainbow2',
    },
    init = function()
      require("core.utils").lazy_load "nvim-treesitter"
    end,
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    build = ":TSUpdate",
    opts = function()
      return require("plugins.configs.nvim-treesitter")
    end,
    config = function(_, opts)
      local status_ok, nvim_treesitter = pcall(require, "nvim-treesitter.configs")
      if not status_ok then
        return
      end

      nvim_treesitter.setup(opts)
    end,
  },

  {
    'brenoprata10/nvim-highlight-colors',
    init = function()
      require("core.utils").lazy_load "nvim-highlight-colors"
    end,
    opts = function()
      return require("plugins.configs.hightlight-colors")
    end,
    config = function(_, opts)
      require("nvim-highlight-colors").setup(opts)
    end
  },

  {
    'folke/tokyonight.nvim',
    priority = 1000,
    lazy = false,
    opts = function()
      return require("plugins.configs.tokyonight")
    end,
    config = function(_, opts)
      local status_ok, tokyonight = pcall(require, "tokyonight")
      if not status_ok then
        return
      end
      tokyonight.setup(opts)

      cmd [[colorscheme tokyonight]]
      cmd [[let g:lightline = {'colorscheme': 'tokyonight'}]]
    end,
  },

  {
    'gelguy/wilder.nvim',
    event = "CmdlineEnter",
    dependencies = {
      'romgrk/fzy-lua-native'
    },
    config = function()
      require("plugins.configs.wilder")
    end,
  },

  {
    "akinsho/toggleterm.nvim",
    version = '*',
    keys = { "<C-t>" },
    config = function()
      require("plugins.configs.toggleterm")
    end
  },

  {
    'numToStr/Comment.nvim',
    init = function()
      require("core.utils").lazy_load "Comment.nvim"
    end,
    opts = function()
      return require("plugins.configs.comment")
    end,
    config = function(_, opts)
      local status_ok, comment = pcall(require, "Comment")
      if not status_ok then
        return
      end
      comment.setup(opts)
    end
  },

  {
    "nvim-telescope/telescope.nvim",
    'dharmx/telescope-media.nvim',
    event = "TodoTelescope",
  },

  {
    "folke/todo-comments.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    init = function()
      require("core.utils").lazy_load "todo-comments.nvim"
    end,
    opts = function()
      return require("plugins.configs.todo-comments")
    end,
    config = function(_, opts)
      local status_ok, todo_comments = pcall(require, "todo-comments")
      if not status_ok then
        return
      end
      todo_comments.setup(opts)
    end
  },

  {
    "windwp/nvim-autopairs",
    opts = function()
      return require("plugins.configs.nvim-autopairs")
    end,
    event = "InsertEnter",
    config = function(_, opts)
      local status_ok, autopairs = pcall(require, "nvim-autopairs")

      if not status_ok then
        return
      end

      autopairs.setup(opts)

      local cmp_status_ok, cmp = pcall(require, "cmp")
      if not cmp_status_ok then
        return
      end

      local cmp_autopairs_status_ok, cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")
      if not cmp_autopairs_status_ok then
        return
      end

      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done { map_char = { tex = "" } })
    end,
  },

  {
    'yamatsum/nvim-cursorline',
    -- init = function()
    --   require("core.utils").lazy_load "nvim-cursorline"
    -- end,
    lazy = false,
    opts = function()
      return require("plugins.configs.nvim-cursorline")
    end,
    config = function(_, opts)
      local status_ok, nvim_cursorline = pcall(require, "nvim-cursorline")
      if not status_ok then
        return
      end
      nvim_cursorline.setup(opts)
    end,
  },

  {
    'uga-rosa/ccc.nvim',
    cmd = { "CccPick" },
    opts = function()
      return require("plugins.configs.color-picker")
    end,
    config = function(_, opts)
      local status_ok, ccc = pcall(require, "ccc")
      if not status_ok then
        return
      end
      ccc.setup(opts)
    end,
  },

  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    init = function()
      require("core.utils").lazy_load "lualine.nvim"
    end,
    config = function()
      require("plugins.configs.lualine")
    end
  },

  {
    'akinsho/bufferline.nvim',
    version = "v3.*",
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    lazy = false,
    config = function()
      require("plugins.configs.bufferline")
    end,
  },


  {
    "lukas-reineke/indent-blankline.nvim",
    init = function()
      require("core.utils").lazy_load "indent-blankline.nvim"
    end,
    config = function()
      require("plugins.configs.indent-blankline")
    end,
  },

  {
    "kylechui/nvim-surround",
    version = "*",
    init = function()
      require("core.utils").lazy_load "nvim-surround"
    end,
    opts = function()
      return require("plugins.configs.nvim-surround")
    end,
    config = function()
      local status_ok, nvim_surround = pcall(require, "nvim-surround")


      if not status_ok then
        return
      end

      nvim_surround.setup {}
    end
  },

  {
    "lewis6991/gitsigns.nvim",
    ft = "gitcommit",
    init = function()
      -- load gitsigns only when a git file is opened
      vim.api.nvim_create_autocmd({ "BufRead" }, {
        group = vim.api.nvim_create_augroup("GitSignsLazyLoad", { clear = true }),
        callback = function()
          vim.fn.system("git -C " .. '"' .. vim.fn.expand "%:p:h" .. '"' .. " rev-parse")
          if vim.v.shell_error == 0 then
            vim.api.nvim_del_augroup_by_name "GitSignsLazyLoad"
            vim.schedule(function()
              require("lazy").load { plugins = { "gitsigns.nvim" } }
            end)
          end
        end,
      })
    end,
    config = function()
      require("plugins.configs.gitsigns")
    end,
  },

  {
    'akinsho/git-conflict.nvim',
    version = "*",
    ft = "gitcommit",
    init = function()
      -- load git-conflict only when a git file is opened
      vim.api.nvim_create_autocmd({ "BufRead" }, {
        group = vim.api.nvim_create_augroup("GitConflictLazyLoad", { clear = true }),
        callback = function()
          vim.fn.system("git -C " .. '"' .. vim.fn.expand "%:p:h" .. '"' .. " rev-parse")
          if vim.v.shell_error == 0 then
            vim.api.nvim_del_augroup_by_name "GitConflictLazyLoad"
            vim.schedule(function()
              require("lazy").load { plugins = { "git-conflict.nvim" } }
            end)
          end
        end,
      })
    end,
    opts = function()
      return require("plugins.configs.git-conflict")
    end,
    config = function(_, opts)
      local present, conflict = pcall(require, "git-conflict")
      if not present then
        return
      end
      conflict.setup(opts)
    end
  },

  --Lsp + cmp
  {
    "williamboman/mason.nvim",
    dependencies = {
      "mason-org/mason-registry",
      -- {
      --   "williamboman/mason-lspconfig.nvim",
      --   init = function()
      --     require("core.utils").lazy_load "mason-lspconfig.nvim"
      --   end,
      --   opts = function()
      --     return require "plugins.configs.mason-lspconfig"
      --   end,
      --   config = function(_, opts)
      --     local status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
      --     if not status_ok then
      --       return
      --     end
      --     mason_lspconfig.setup(opts)
      --   end,
      -- },
    },
    build = ":MasonUpdate",
    cmd = { "Mason", "MasonEnsurePackages", "MasonSyncEnsurePackages", "MasonInstall", "MasonInstallAll",
      "MasonUninstall",
      "MasonUninstallAll", "MasonLog" },
    opts = function()
      return require "plugins.configs.mason"
    end,
    config = function(_, opts)
      local status_ok, mason = pcall(require, "mason")
      if not status_ok then
        return
      end
      mason.setup(opts)

      require("plugins.autocmds.mason").create_user_commands()

      vim.g.mason_binaries_list = opts.ensure_installed
    end,
  },

  {
    "neovim/nvim-lspconfig",
    init = function()
      require("core.utils").lazy_load "nvim-lspconfig"
    end,
    config = function()
      require "plugins.configs.nvim-lspconfig"
    end,
  },

  {
    "glepnir/lspsaga.nvim",
    event = "LspAttach",
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
      --Please make sure you install markdown and markdown_inline parser
      { "nvim-treesitter/nvim-treesitter" }
    },
    opts = function()
      return require("plugins.configs.lspsaga")
    end,
    config = function(_, opts)
      require("lspsaga").setup(opts)
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      {
        -- snippet plugin
        "L3MON4D3/LuaSnip",
        dependencies = "rafamadriz/friendly-snippets",
        opts = { history = true, updateevents = "TextChanged,TextChangedI" },
        config = function(_, opts)
          require("luasnip").config.set_config(opts)

          -- vscode format
          require("luasnip.loaders.from_vscode").lazy_load()
          require("luasnip.loaders.from_vscode").lazy_load { paths = vim.g.vscode_snippets_path or "" }

          -- snipmate format
          require("luasnip.loaders.from_snipmate").load()
          require("luasnip.loaders.from_snipmate").lazy_load { paths = vim.g.snipmate_snippets_path or "" }

          -- lua format
          require("luasnip.loaders.from_lua").load()
          require("luasnip.loaders.from_lua").lazy_load { paths = vim.g.lua_snippets_path or "" }

          vim.api.nvim_create_autocmd("InsertLeave", {
            callback = function()
              if
                  require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
                  and not require("luasnip").session.jump_active
              then
                require("luasnip").unlink_current()
              end
            end,
          })
        end,
      },

      -- cmp sources plugins
      {
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
      },
    },
    config = function()
      require("plugins.configs.cmp")
    end,
  },

  {
    'jose-elias-alvarez/null-ls.nvim',
    -- init = function()
    --   require("core.utils").lazy_load "null-ls"
    -- end,
    event = "BufWritePre",
    config = function()
      require("plugins.configs.null-ls")
    end,
  },

  {
    "iamcco/markdown-preview.nvim",
    ft = "markdown",
    -- cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = function() vim.fn["mkdp#util#install"]() end,
    config = function()
      require("plugins.configs.markdown-preview")
    end,
  },

  {
    "folke/which-key.nvim",
    keys = { "<leader>", "g", "[", "]", '"', "'", "`" },
    opts = function()
      return require "plugins.configs.whichkey"
    end,
    config = function(_, opts)
      require("which-key").setup(opts)
    end,
  },

  {
    'kevinhwang91/nvim-ufo',
    dependencies = 'kevinhwang91/promise-async',
    init = function()
      require("core.utils").lazy_load "nvim-ufo"
    end,
    config = function()
      require('plugins.configs.nvim-ufo')
    end
  },

}

local config = require("core.utils").load_config()

if #config.plugins > 0 then
  table.insert(default_plugins, { import = config.plugins })
end

require("plugins.autocmds")
require("lazy").setup(default_plugins, config.lazy_nvim)
