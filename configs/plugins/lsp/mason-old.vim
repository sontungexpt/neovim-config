Plug 'williamboman/mason.nvim'
" https://github.com/williamboman/mason.nvim
Plug 'williamboman/mason-lspconfig.nvim'
" https://github.com/williamboman/mason-lspconfig.nvim
function SetupMason()
lua<<EOF
  require("mason").setup{
    ui = {
		  icons = {
			  package_pending = " ",
			  package_installed = " ",
			  package_uninstalled = " ﮊ",
		  },
      
    },
    ensure_installed = {
      "prettierd",
      "prettier",
      "clang-format",
    } 
  }
  require("mason-lspconfig").setup {
    ensure_installed = {
      --lua
      "lua_ls", 
      
      --rust
      "rust_analyzer",
    
      --python
      "pyright",
     
      --ruby
      "ruby_ls",
    
      --C,C++,C#,Cmake
      "clangd",
      "cmake",
      "omnisharp",
     
      -- web dev
		  "cssls",
		  "html",
		  "eslint",
      "tsserver",
		  "denols",
		  "emmet_ls",
      "jsonls",
      
      --vim
      "vimls",
     
      --prettier

      --shell


    },
    automatic_installation = true
  }
EOF
endfunction

" Run mason psetup config when neovim loaded
augroup MasonOverrides
  autocmd!
  autocmd User PlugLoaded call SetupMason()
augroup END

 " keymaps = {
 "            -- Keymap to expand a package
 "            toggle_package_expand = "<CR>",
 "            -- Keymap to install the package under the current cursor position
 "            install_package = "i",
 "            -- Keymap to reinstall/update the package under the current cursor position
 "            update_package = "u",
 "            -- Keymap to check for new version for the package under the current cursor position
 "            check_package_version = "c",
 "            -- Keymap to update all installed packages
 "            update_all_packages = "U",
 "            -- Keymap to check which installed packages are outdated
 "            check_outdated_packages = "C",
 "            -- Keymap to uninstall a package
 "            uninstall_package = "X",
 "            -- Keymap to cancel a package installation
 "            cancel_installation = "<C-c>",
 "            -- Keymap to apply language filter
 "            apply_language_filter = "<C-f>",
" },
