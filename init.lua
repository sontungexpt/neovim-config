local modules = {
  "core.options",
  "core.keymaps",
  "core.plugins",
  "core.plugins-keymaps"
}

local function GetLuaFilesInDir(dirUrl)
  return io.popen('find "' .. dirUrl .. '" -type f' .. ' -name "*.lua"')
end

local function SourceConfigFile(dirUrl)
  local files = GetLuaFilesInDir(dirUrl)

  if files ~= nil then
    for file in files:lines() do
      --Loop through all files
      vim.cmd("luafile " .. file)
    end
  end
end

-- Main Code

-- Refresh module cache
for _, module in pairs(modules) do
  package.loaded[module] = nil
  require(module)
end

-- Source all files in config dir
SourceConfigFile(vim.fn.stdpath('config') .. '/lua/plugins/')
