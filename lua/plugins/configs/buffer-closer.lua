local options = {
  min_remaining_buffers = 2, -- can not be less than 1
  retirement_minutes = 3,    -- can not be less than 1

  -- feature options

  -- if true then it will check the retired buffers when a new valid buffer is added
  check_when_buffer_adding = true,

  -- if check_when_buffer_add is true,
  -- then this option will be off by default
  check_after_minutes = {
    enabled = false,
    interval_minutes = 1, -- can not be less than 1
  },

  -- end of feature options

  excluded = {
    filetypes = { "lazy", "NvimTree" },
    buftypes = { "terminal", "nofile", "quickfix", "prompt", "help" },
    filenames = {},
  },

  -- it means that a buffer will not be closed if it is opened in a window
  ignore_working_windows = true,
}

return options
