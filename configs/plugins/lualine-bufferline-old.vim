Plug 'nvim-lualine/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'akinsho/bufferline.nvim', { 'tag': 'v3.*' }


"----------lualine----------"
function SetupLualine()
lua<<EOF

  local colors = {
    bg = "#202328",
    fg = "#bbc2cf",
    yellow = "#ECBE7B",
    cyan = "#008080",
    darkblue = "#081633",
    green = "#98be65",
    orange = "#FF8800",
    violet = "#a9a1e1",
    magenta = "#c678dd",
    blue = "#51afef",
    red = "#ec5f67",
  }

  local status_ok, lualine = pcall(require, "lualine")
  if not status_ok then
    return
  end


  lualine.setup {
    options = {
      icons_enabled = true,
      theme = 'auto',
      section_separators = { left = '', right = '' },
      --component_separators = { left = '│', right = '│' },
      component_separators = { left = '', right = '' },
      disabled_filetypes = {
        statusline = {},
        winbar = {},
      },
      ignore_focus = {},
      always_divide_middle = true,
      globalstatus = true,
      refresh = {
        statusline = 1000,
        tabline = 1000,
        winbar = 1000,
      }
    },
    sections = {
      lualine_a = {
        { 
          'mode', 
          icons_enabled = true, -- Enables the display of icons alongside the component.
          -- Defines the icon to be displayed in front of the component.
          -- Can be string|table
          -- As table it must contain the icon as first entry and can use
          -- color option to custom color the icon. Example:
          -- {'branch', icon = ''} / {'branch', icon = {'', color={fg='green'}}}
          -- icon position can also be set to the right side from table. Example:
          -- {'branch', icon = {'', align='right', color={fg='green'}}}
          icon = nil,

          separator = { left = '',right ='' },
          -- Determines what separator to use for the component.
          -- Note:
          --  When a string is provided it's treated as component_separator.
          --  When a table is provided it's treated as section_separator.
          --  Passing an empty string disables the separator.
          --
          -- These options can be used to set colored separators
          -- around a component.
          --
          -- The options need to be set as such:
          --   separator = { left = '', right = ''}
          --
          -- Where left will be placed on left side of component,
          -- and right will be placed on its right.
          cond = nil,           
          -- Condition function, the component is loaded when the function returns `true`.

          -- Defines a custom color for the component:
          --
          -- 'highlight_group_name' | { fg = '#rrggbb'|cterm_value(0-255)|'color_name(red)', bg= '#rrggbb', gui='style' } | function
          -- Note:
          --  '|' is synonymous with 'or', meaning a different acceptable format for that placeholder.
          -- color function has to return one of other color types ('highlight_group_name' | { fg = '#rrggbb'|cterm_value(0-255)|'color_name(red)', bg= '#rrggbb', gui='style' })
          -- color functions can be used to have different colors based on state as shown below.
          --
          -- Examples:
          --   color = { fg = '#ffaa88', bg = 'grey', gui='italic,bold' },
          --   color = { fg = 204 }   -- When fg/bg are omitted, they default to the your theme's fg/bg.
          --   color = 'WarningMsg'   -- Highlight groups can also be used.
          --   color = function(section)
          --      return { fg = vim.bo.modified and '#aa3355' or '#33aa88' }
          --   end,
          color = nil, -- The default is your theme's color for that section and mode.

          -- Specify what type a component is, if omitted, lualine will guess it for you.
          --
          -- Available types are:
          --   [format: type_name(example)], mod(branch/filename),
          --   stl(%f/%m), var(g:coc_status/bo:modifiable),
          --   lua_expr(lua expressions), vim_fun(viml function name)
          --
          -- Note:
          -- lua_expr is short for lua-expression and vim_fun is short for vim-function.
          type = nil,

          padding = 1, 
          -- Adds padding to the left and right of components.
          -- Padding can be specified to left or right independently, e.g.:
          --   padding = { left = left_padding, right = right_padding }

          fmt = nil,   
          -- Format function, formats the component's output.
          -- This function receives two arguments:
          -- - string that is going to be displayed and
          --   that can be changed, enhanced and etc.
          -- - context object with information you might
          --   need. E.g. tabnr if used with tabs.
          on_click = nil, 
          -- takes a function that is called when component is clicked with mouse.
          -- the function receives several arguments
          -- - number of clicks in case of multiple clicks
          -- - mouse button used (l(left)/r(right)/m(middle)/...)
          -- - modifiers pressed (s(shift)/c(ctrl)/a(alt)/m(meta)...)
        },
      },
      --lualine_b = {'buffers'},
      lualine_b = {
        {
          'fileformat',
          component_separators = { left = '', right = '' },
          symbols = {
            unix = '', -- e712
            dos = '',  -- e70f
            mac = '',  -- e711
          }
        },
        {
            'branch',
            colored = true,
        }, 

        {
          'diff',
          colored = true, -- Displays a colored diff status if set to true
          diff_color = {
            -- Same color values as the general color option can be used here.
            added    = 'DiffAdd',    -- Changes the diff's added color
            modified = 'DiffChange', -- Changes the diff's modified color
            removed  = 'DiffDelete', -- Changes the diff's removed color you
          },
          symbols = {added = '+', modified = '~', removed = '-'}, -- Changes the symbols used by the diff.
          source = nil, 
          -- A function that works as a data source for diff.
          -- It must return a table as such:
          --   { added = add_count, modified = modified_count, removed = removed_count }
          -- or nil on failure. count <= 0 won't be displayed.
        }, 
        
        {
          'diagnostics',
          -- Table of diagnostic sources, available sources are:
          -- 'nvim_lsp', 'nvim_diagnostic', 'nvim_workspace_diagnostic', 'coc', 'ale', 'vim_lsp'.
          -- or a function that returns a table as such:
          -- { error=error_cnt, warn=warn_cnt, info=info_cnt, hint=hint_cnt }
          sources = { 'nvim_diagnostic', 'coc' },

          -- Displays diagnostics for the defined severity types
          sections = { 'error', 'warn', 'info', 'hint' },

          diagnostics_color = {
            -- Same values as the general color option can be used here.
            error = 'DiagnosticError', -- Changes diagnostics' error color.
            warn  = 'DiagnosticWarn',  -- Changes diagnostics' warn color.
            info  = 'DiagnosticInfo',  -- Changes diagnostics' info color.
            hint  = 'DiagnosticHint',  -- Changes diagnostics' hint color.
          },
          symbols = {error = 'E', warn = 'W', info = 'I', hint = 'H'},
          colored = true,           -- Displays diagnostics status in color if set to true.
          update_in_insert = false, -- Update diagnostics in insert mode.
          always_visible = false,   -- Show diagnostics even if there are none.
        },
      },

      lualine_c = {
        {
          'filetype',
          colored = true,   -- Displays filetype icon in color if set to true
          icon_only = true, -- Display only an icon for filetype
          icon = { align = 'center' }, -- Display filetype icon on the right hand side
          right_padding = 1,
          left_padding = 2,
          -- icon =    {'X', align='right'}
          -- Icon string ^ in table is ignored in filetype component
        },

        {
          'filename',
          file_status = true,      -- Displays file status (readonly status, modified status)
          newfile_status = false,  -- Display new file status (new file means no write after created)
          path = 0,            
          padding = 0,
          -- 0: Just the filename
          -- 1: Relative path
          -- 2: Absolute path
          -- 3: Absolute path, with tilde as the home directory

          shorting_target = 40,    
          -- Shortens path to leave 40 spaces in the window
          -- for other components. (terrible name, any suggestions?)
          symbols = {
            modified = '[+]',      -- Text to show when the file is modified.
            readonly = '',        -- Text to show when the file is non-modifiable or readonly.
            unnamed = '[No Name]', -- Text to show for unnamed buffers.
            newfile = '[New]',     -- Text to show for newly created file before first write
          },
        },
      },

      lualine_x = {
        {
          'filesize',
          --separator = {left ='', right = '' }, 
          
        }
      },
      --lualine_x = {'encoding', 'fileformat', 'filetype'},
      lualine_y = {'encoding'},
      lualine_z = {
        { 
          'location', 
          separator = {left ='', right = '' }, 
        },
      },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = {}
    },
    extensions = {'fzf'}
  }
EOF
endfunction

function SetupBufferLine()
lua<<EOF
  require('bufferline').setup {
    options = {
      mode = "buffers", -- set to "tabs" to only show tabpages instead
      numbers = "none", 
      close_command = "bdelete! %d",       -- can be a string | function, see "Mouse actions"
      right_mouse_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
      left_mouse_command = "buffer %d",    -- can be a string | function, see "Mouse actions"
      middle_mouse_command = nil,          -- can be a string | function, see "Mouse actions"
      indicator = {
        icon = '▎ ', -- this should be omitted if indicator style is not 'icon'
        style = 'icon',
      },
      buffer_close_icon = '',
      modified_icon = '●',
      close_icon = '',
      left_trunc_marker = '',
      right_trunc_marker = '',
      -- name_formatter can be used to change the buffer's label in the bufferline.
      -- Please note some names can/will break the
      -- bufferline so use this at your discretion knowing that it has
      -- some limitations that will *NOT* be fixed.
      name_formatter = function(buf)  -- buf contains:
      -- name                | str        | the basename of the active file
      -- path                | str        | the full path of the active file
      -- bufnr (buffer only) | int        | the number of the active buffer
      -- buffers (tabs only) | table(int) | the numbers of the buffers in the tab
      -- tabnr (tabs only)   | int        | the "handle" of the tab, can be converted to its ordinal number using: `vim.api.nvim_tabpage_get_number(buf.tabnr)`
      end,
      max_name_length = 25,
      max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
      truncate_names = true, -- whether or not tab names should be truncated
      tab_size = 20,
      diagnostics = "nvim_lsp",
      diagnostics_update_in_insert = false,
      -- The diagnostics indicator can be set to nil to keep the buffer name highlight but delete the highlighting
      diagnostics_indicator = function(count, level, diagnostics_dict, context)
        return "("..count..")"
      end,
      -- NOTE: this will be called a lot so don't do any heavy processing here
      custom_filter = function(buf_number, buf_numbers)
        -- filter out filetypes you don't want to see
        if vim.bo[buf_number].filetype ~= "<i-dont-want-to-see-this>" then
          return true
        end
        -- filter out by buffer name
        if vim.fn.bufname(buf_number) ~= "<buffer-name-I-dont-want>" then
          return true
        end
        -- filter out based on arbitrary rules
        -- e.g. filter out vim wiki buffer from tabline in your work repo
        if vim.fn.getcwd() == "<work-repo>" and vim.bo[buf_number].filetype ~= "wiki" then
          return true
        end
        -- filter out by it's index number in list (don't show first buffer)
        if buf_numbers[1] ~= buf_number then
          return true
        end
      end,
      offsets = {
        {
          filetype = "NvimTree",
          text = "File Explorer",
          highlight = "directory",
          padding = 0,
          text_align = "center",
          separator = " "
        }
      },
      color_icons = true, -- whether or not to add the filetype icon highlights
      show_buffer_icons = true, -- disable filetype icons for buffers
      show_buffer_close_icons = true,
      show_buffer_default_icon = true, -- whether or not an unrecognised filetype should show a default icon
      show_close_icon = true,
      show_tab_indicators = true,
      show_duplicate_prefix = true, -- whether to show duplicate buffer prefix
      persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
      -- can also be a table containing 2 custom separators
      -- [focused and unfocused]. eg: { '|', '|' }
      separator_style = "thin",
      enforce_regular_tabs = false,
      always_show_bufferline = true,
      hover = {
        enabled = true,
        delay = 1,
        reveal = {'close'}
      },
      sort_by = 'insert_after_current',
    }
  }
EOF
endfunction

" Run the lualine setup and bufferline setup options when neovim loaded
augroup LualineAndBufferLineOverrides
  autocmd!
  autocmd User PlugLoaded call SetupLualine()
  autocmd User PlugLoaded call SetupBufferLine()
augroup END
