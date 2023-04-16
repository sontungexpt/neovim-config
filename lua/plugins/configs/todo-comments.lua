local options = {
  -- show icons in the signs column
  signs = true,
  -- sign priority
  sign_priority = 8,
  -- keywords recognized as todo comments
  keywords = {
    FIX = {
      -- a set of other keywords that all map to this FIX keywords
      alt = { "FIXME", "BUG", "FIXIT", "ISSUE" },
    },
    WARN = { alt = { "WARNING" } },
    PERF = { alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
  },
  highlight = {
    -- "fg" or "bg" or empty
    before = "",
    -- keyword = "wide", -- "fg", "bg", "wide" or empty.
    -- (wide is the same as bg, but will also highlight surrounding characters)
    keyword = "wide",
    -- "fg" or "bg" or empty
    after = "fg",
    -- pattern or table of patterns, used for highlightng (vim regex)
    pattern = [[.*<(KEYWORDS)\s*:]],
    -- uses treesitter to match keywords in comments only
    comments_only = true,
    -- ignore lines longer than this
    max_line_len = 400,
    -- list of file types to exclude highlighting
    exclude = {},
  },
}

return options
