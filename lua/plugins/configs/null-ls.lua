local status_ok, null_ls = pcall(require, "null-ls")

if not status_ok then
  return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
  debug = true,
  sources = {
    --git sign
    code_actions.gitsigns,

    -- deno
    -- formatting.deno_fmt.with({ extra_args = { "--style", "{IndentWidth: 2}" } }),

    -- prettier
    formatting.prettier,

    -- eslint
    diagnostics.eslint_d.with({
      condition = function(utils)
        return utils.root_has_file(".eslintrc.js")
      end,
    }),

    --rust
    --
    formatting.rustfmt.with({
      extra_args = function(params)
        local Path = require("plenary.path")
        local cargo_toml = Path:new(params.root .. "/" .. "Cargo.toml")

        if cargo_toml:exists() and cargo_toml:is_file() then
          for _, line in ipairs(cargo_toml:readlines()) do
            local edition = line:match([[^edition%s*=%s*%"(%d+)%"]])
            if edition then
              return { "--edition=" .. edition }
            end
          end
        end
        -- default edition when we don't find `Cargo.toml` or the `edition` in it.
        return { "--edition=2021" }
      end,
    }),

    -- Lua
    -- formatting.stylua.with({ extra_args = { "--style", "{IndentWidth: 2}" } }),
    -- use stylelua.toml instead if it exists
    formatting.stylua.with({
      extra_args = function(params)
        local Path = require("plenary.path")
        local stylelua_toml = Path:new(params.root .. "/" .. "stylua.toml")

        if stylelua_toml:exists() and stylelua_toml:is_file() then
          return { "--config-path", stylelua_toml:absolute() }
        end
        return { "--style", "{IndentWidth: 2}" }
      end,
    }),


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
    diagnostics.codespell.with({ args = { "--ignore-words-list=Tung" } }),
  },

  -- Configure format on save
  on_attach = function(client, bufnr)
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
