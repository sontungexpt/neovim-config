local status_ok, wilder = pcall(require, "wilder")

if not status_ok then
  return
end

wilder.setup {
  modes = { ':', '/', '?' },
  -- next_key = "<Tab>",
  next_key = "<Tab>",
  previous_key = "<S-Tab>",
  accept_key = "<M-Tab>",
  reject_key = "<S-Tab><M-Tab>",
  enable_cmdline_enter = 1,
}

wilder.set_option('pipeline', {
  wilder.branch(
    wilder.cmdline_pipeline({
      fuzzy = 1,
      fuzzy_filter = wilder.lua_fzy_filter(),
    }),
    wilder.vim_search_pipeline()
  )
})

wilder.set_option('renderer', wilder.renderer_mux({
  [':'] = wilder.popupmenu_renderer(
    wilder.popupmenu_palette_theme({
      border = 'single', -- 'single', 'double', 'rounded' or 'solid'
      max_height = '80%', -- max height of the palette
      min_height = 0, -- set to the same as 'max_height' for a fixed height window
      prompt_position = 'top', -- 'top' or 'bottom' to set the location of the prompt
      reverse = 0, -- set to 1 to reverse the order of the list, use in combination with 'prompt_position'
      left = { ' ', '  ', wilder.popupmenu_devicons() },
      highlighter = {
        wilder.lua_pcre2_highlighter(), -- requires `luarocks install pcre2`
        wilder.lua_fzy_highlighter(), -- requires fzy-lua-native vim plugin found
        -- at https://github.com/romgrk/fzy-lua-native
      },
      highlights = {
        accent = wilder.make_hl('WilderAccent', 'Pmenu', { { a = 1 }, { a = 1 }, { foreground = '#f4468f' } }),
      },
    })
  ),
  ['/'] = wilder.popupmenu_renderer(
     wilder.popupmenu_palette_theme({
      border = 'single', -- 'single', 'double', 'rounded' or 'solid'
      max_height = '80%', -- max height of the palette
      min_height = 0, -- set to the same as 'max_height' for a fixed height window
      prompt_position = 'top', -- 'top' or 'bottom' to set the location of the prompt
      reverse = 0, -- set to 1 to reverse the order of the list, use in combination with 'prompt_position'
      left = { ' ', '  ', wilder.popupmenu_devicons() },
      highlighter = {
        wilder.lua_pcre2_highlighter(), -- requires `luarocks install pcre2`
        wilder.lua_fzy_highlighter(), -- requires fzy-lua-native vim plugin found
        -- at https://github.com/romgrk/fzy-lua-native
      },
      highlights = {
        accent = wilder.make_hl('WilderAccent', 'Pmenu', { { a = 1 }, { a = 1 }, { foreground = '#f4468f' } }),
      },
    })
  ),
  ['?'] = wilder.popupmenu_renderer(
     wilder.popupmenu_palette_theme({
      border = 'single', -- 'single', 'double', 'rounded' or 'solid'
      max_height = '80%', -- max height of the palette
      min_height = 0, -- set to the same as 'max_height' for a fixed height window
      prompt_position = 'top', -- 'top' or 'bottom' to set the location of the prompt
      reverse = 0, -- set to 1 to reverse the order of the list, use in combination with 'prompt_position'
      left = { ' ', '  ', wilder.popupmenu_devicons() },
      highlighter = {
        wilder.lua_pcre2_highlighter(), -- requires `luarocks install pcre2`
        wilder.lua_fzy_highlighter(), -- requires fzy-lua-native vim plugin found
      },
      highlights = {
        accent = wilder.make_hl('WilderAccent', 'Pmenu', { { a = 1 }, { a = 1 }, { foreground = '#f4468f' } }),
      },
    })
  )
}))

-- default
-- wilder.set_option('renderer', wilder.popupmenu_renderer(
--   wilder.popupmenu_palette_theme({
--     border = 'single', -- 'single', 'double', 'rounded' or 'solid'
--     max_height = '80%', -- max height of the palette
--     min_height = 0, -- set to the same as 'max_height' for a fixed height window
--     prompt_position = 'top', -- 'top' or 'bottom' to set the location of the prompt
--     reverse = 0, -- set to 1 to reverse the order of the list, use in combination with 'prompt_position'
--     left = { ' ', '  ', wilder.popupmenu_devicons() },
--     highlighter = {
--       wilder.lua_pcre2_highlighter(), -- requires `luarocks install pcre2`
--       wilder.lua_fzy_highlighter(), -- requires fzy-lua-native vim plugin found
--       -- at https://github.com/romgrk/fzy-lua-native
--     },
--     highlights = {
--       accent = wilder.make_hl('WilderAccent', 'Pmenu', { { a = 1 }, { a = 1 }, { foreground = '#f4468f' } }),
--     },
--   })
-- ))
