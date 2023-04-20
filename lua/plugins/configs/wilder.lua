local status_ok, wilder = pcall(require, "wilder")

if not status_ok then
  return
end

local merge_tb = vim.tbl_deep_extend

local colors = require("core.default-config").ui.colors

wilder.setup {
  modes = { ':', '/', '?' },
  next_key = "<Tab>",
  previous_key = "<S-Tab>",
  accept_key = "<M-Tab>",
  reject_key = "<S-Tab><M-Tab>",
  enable_cmdline_enter = 1,
}

wilder.set_option('use_python_remote_plugin', 0)

wilder.set_option('pipeline', {
  wilder.branch(
    wilder.cmdline_pipeline({
      fuzzy = 1,
      fuzzy_filter = wilder.lua_fzy_filter(),
    }),
    wilder.vim_search_pipeline()
  )
})

local general_style = {
  -- 'single', 'double', 'rounded' or 'solid'
  border = 'single',
  -- max height of the palette
  max_height = '80%',
  -- set to the same as 'max_height' for a fixed height window
  min_height = 0,
  -- 'top' or 'bottom' to set the location of the prompt
  prompt_position = 'top',
  -- set to 1 to reverse the order of the list, use in combination with 'prompt_position'
  reverse = 0,
  left = { ' ', wilder.popupmenu_devicons() },
  highlighter = {
    wilder.lua_fzy_highlighter(),
  },
  highlights = {
    accent = wilder.make_hl(
      'WilderAccent',
      'Pmenu',
      {
        { a = 1 },
        { a = 1 },
        { foreground = colors.pink },
      }
    ),
  },
}

wilder.set_option('renderer', wilder.renderer_mux({
  [':'] = wilder.popupmenu_renderer(
    wilder.popupmenu_palette_theme(
      merge_tb("force", general_style or {}, {
        left = { ' ', '  ', wilder.popupmenu_devicons() },
      })
    )
  ),
  ['/'] = wilder.popupmenu_renderer(
    wilder.popupmenu_palette_theme(
      merge_tb("force", general_style or {}, {
        left = { ' ', '  ', wilder.popupmenu_devicons() },
      })
    )
  ),
  ['?'] = wilder.popupmenu_renderer(
    wilder.popupmenu_palette_theme(

      merge_tb("force", general_style or {}, {
        left = { ' ', '  ', wilder.popupmenu_devicons() },
      })
    )
  )
}))
