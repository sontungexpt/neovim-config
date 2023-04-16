-- Mason
local mason_status_ok, mason = pcall(require, 'plugins.autocmds.mason')
if mason_status_ok then
  mason.create_autocmds()
end

-- treesitter
local treesitter_status_ok, treesitter = pcall(require, 'plugins.autocmds.treesitter')
if treesitter_status_ok then
  treesitter.create_autocmds()
end

-- git conflict
local git_conflict_status_ok, git_conflict = pcall(require, 'plugins.autocmds.git-conflict')
if git_conflict_status_ok then
  git_conflict.create_autocmds()
end

local highlight_colors_status_ok, highlight_colors = pcall(require, 'plugins.autocmds.highlight-colors')
if highlight_colors_status_ok then
  highlight_colors.create_autocmds()
end
