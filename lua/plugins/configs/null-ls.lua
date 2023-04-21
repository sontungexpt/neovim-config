local status_ok, null_ls = pcall(require, "null-ls")

if not status_ok then
  return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

null_ls.setup({
  debug = true,
  sources = {
    --git sign
    code_actions.gitsigns,

    --blade
    formatting.blade_formatter.with({ extra_args = { "--style", "{IndentWidth: 2}" } }),

    -- deno
    -- formatting.deno_fmt.with({ extra_args = { "--style", "{IndentWidth: 2}" } }),

    -- prettier
    formatting.prettierd.with({
      extra_args = { "--style", "{IndentWidth: 2}", "--single-quote", "--jsx-single-quote" },
      condition = function(utils)
        return utils.root_has_file(".prettierrc.js")
      end,
    }),

    -- eslint
    diagnostics.eslint_d.with({
      condition = function(utils)
        return utils.root_has_file(".eslintrc.js")
      end,
    }),

    --dart
    -- formatting.dart_format.with({ extra_args = { "--style", "{IndentWidth: 2}" } }),

    --go
    -- formatting.goimports_reviser.with({ extra_args = { "--style", "{IndentWidth: 2}" } }),
    -- diagnostics.golangci_lint.with({ diagnostics_format = "#{m} [#{c}]" }),

    --rust
    -- formatting.rustfmt.with({ extra_args = { "--style", "{IndentWidth: 2}" } }),

    --java
    -- formatting.google_java_format.with({ extra_args = { "--style", "{IndentWidth: 2}" } }),

    --ruby
    -- formatting.rubocop.with({ extra_args = { "--style", "{IndentWidth: 2}" } }),

    -- Lua
    formatting.stylua.with({ extra_args = { "--style", "{IndentWidth: 2}" } }),

    --Shell
    formatting.shfmt,
    diagnostics.shellcheck.with({ diagnostics_format = "#{m} [#{c}]" }),

    --python
    formatting.autopep8.with({ extra_args = { "--style", "{IndentWidth:2 }" } }),
    diagnostics.flake8,

    -- cpp, cmake
    formatting.clang_format.with({ extra_args = { "--style", "{IndentWidth: 2}" } }),
    diagnostics.clang_check,

    --Code Spell Checker
    diagnostics.codespell,
  },
  -- Configure format on save
  on_attach = function(client, bufnr)
    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr, timeout = 2000 })
        end,
      })
    end
  end,
})
