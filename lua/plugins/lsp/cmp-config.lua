vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
  return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
  return
end

local luasnip_loaders_status_ok, luasnip_loaders = pcall(require, "luasnip.loaders.from_vscode")
if not luasnip_loaders_status_ok then
  return
end
luasnip_loaders.lazy_load()

local check_backspace = function()
  local col = vim.fn.col "." - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
end

local kind_icons = {
  Text = " ",
  Method = "m ",
  Function = " ",
  Constructor = " ",
  Field = " ",
  Variable = " ",
  Class = " ",
  Interface = " ",
  Module = " ",
  Property = " ",
  Unit = " ",
  Value = " ",
  Enum = " ",
  Keyword = " ",
  Snippet = " ",
  Color = " ",
  File = " ",
  Reference = " ",
  Folder = " ",
  EnumMember = " ",
  Constant = " ",
  Struct = " ",
  Event = " ",
  Operator = " ",
  TypeParameter = " ",
}

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  sources = {
    { name = 'path' },
    { name = 'nvim_lsp', keyword_length = 1 },
    { name = 'buffer',   keyword_length = 3 },
    { name = 'luasnip',  keyword_length = 4 },
    { name = "copilot",  group_index = 2 },
  },
  window = {
    documentation = cmp.config.window.bordered(),
    -- border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
    border = "single"
  },
  formatting = {
    fields = { "kind", "abbr", "menu" },
    --fields = {'menu', 'abbr', 'kind'},
    format = function(entry, vim_item)
      -- Kind icons
      vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
      -- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind)
      -- This concatonates the icons with the name of the item kind
      vim_item.menu = ({
            nvim_lsp = "λ ",
            luasnip = " ",
            buffer = "Ω ",
            path = "󱘎",
            nvim_lua = " ",
            copilot = " ",
            Copilot = " ",
          })[entry.source.name]
      return vim_item
    end,
  },
  confirm_opts = {
    behavior = cmp.ConfirmBehavior.Selected,
    select = false,
  },
  experimental = {
    ghost_text = false,
    native_menu = false,
  },
  mapping = {
    ['<Up>'] = cmp.mapping.select_prev_item(select_opts),
    ['<Down>'] = cmp.mapping.select_next_item(select_opts),

    ['<C-u>'] = cmp.mapping.scroll_docs( -4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),

    -- ['<CR>'] = cmp.mapping.confirm({ select = false }),
    ['<CR>'] = cmp.mapping.confirm({ select = false }),

    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expandable() then
        luasnip.expand()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif check_backspace() then
        fallback()
      else
        fallback()
      end
    end, { "i", "s", }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable( -1) then
        luasnip.jump( -1)
      else
        fallback()
      end
    end, { "i", "s", }),
  },
  sorting = {
    priority_weight = 2,
  },
})
