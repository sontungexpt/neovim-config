local status_ok, neoclip = pcall(require, "neoclip")
if not status_ok then
  return
end

local function is_whitespace(line)
  return vim.fn.match(line, [[^\s*$]]) ~= -1
end

local function all(tbl, check)
  for _, entry in ipairs(tbl) do
    if not check(entry) then
      return false
    end
  end
  return true
end

neoclip.setup({
  history = 1000,
  enable_persistent_history = false,
  length_limit = 1048576,
  continuous_sync = false,
  db_path = vim.fn.stdpath("data") .. "/databases/neoclip.sqlite3",
  filter = function(data)
    return not all(data.event.regcontents, is_whitespace)
  end,
  preview = true,
  prompt = nil,
  default_register = '"',
  default_register_macros = 'q',
  enable_macro_history = true,
  content_spec_column = true,
  on_select = {
    move_to_front = false,
    close_telescope = true,
  },
  on_paste = {
    set_reg = false,
    move_to_front = false,
    close_telescope = true,
  },
  on_replay = {
    set_reg = false,
    move_to_front = false,
    close_telescope = true,
  },
  on_custom_action = {
    close_telescope = true,
  },
  keys = {
    telescope = {
      i = {
        select = '<cr>',
        paste = '<C-v>',
        paste_behind = '<C-V>',
        replay = '<c-q>', -- replay a macro
        delete = { '<c-d>', '<Delete>' }, -- delete an entry
        edit = '<C-e>', -- edit an entry
        custom = {},
      },
      n = {
        select = '<cr>',
        paste = '<C-v>',
        --- It is possible to map to more than one key.
        -- paste = { 'p', '<c-p>' },
        paste_behind = 'C-V',
        replay = 'q',
        delete = { 'd', '<Delete>' },
        edit = 'e',
        custom = {},
      },
    },
    fzf = {
      select = 'default',
      paste = 'ctrl-v',
      paste_behind = 'ctrl-V',
      custom = {},
    },
  },
})
