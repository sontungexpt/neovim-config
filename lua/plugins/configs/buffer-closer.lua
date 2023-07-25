local options = {
  min_remaining_buffers = 1,
  retirement_minutes = 1,        -- can not be less than 1
  checking_interval_minutes = 1, -- can not be less than 1

  excluded = {
    filetypes = { "lazy", "NvimTree" },
    buftypes = { "terminal", "nofile", "quickfix", "prompt", "help" },
    filenames = {},
  },

  -- it means that a buffer will not be closed if it is opened in a window
  ignore_working_windows = true,
}

return options
