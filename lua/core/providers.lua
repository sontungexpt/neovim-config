local g = vim.g

g.ruby_host_prog = '~/.rbenv/versions/3.2.2/bin/neovim-ruby-host'
g.python3_host_prog = '/usr/bin/python3'

-- disable some providers
local disable = {
  "perl",
}

for _, provider in ipairs(disable) do
  g["loaded_" .. provider .. "_provider"] = 0
end
