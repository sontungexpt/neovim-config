local M = {}

M.load_config = function()
  local config = require "core.default-config"

  return config
end

M.lazy_load = function(plugin)
  vim.api.nvim_create_autocmd({ "BufRead", "BufWinEnter", "BufNewFile" }, {
    group = vim.api.nvim_create_augroup("BeLazyOnFileOpen" .. plugin, {}),
    callback = function()
      local file = vim.fn.expand "%"
      local condition = file ~= "NvimTree_1" and file ~= "[lazy]" and file ~= ""

      if condition then
        vim.api.nvim_del_augroup_by_name("BeLazyOnFileOpen" .. plugin)

        -- dont defer for treesitter as it will show slow highlighting
        -- This deferring only happens only when we do "nvim filename"
        if plugin ~= "nvim-treesitter" then
          vim.schedule(function()
            require("lazy").load { plugins = plugin }

            if plugin == "nvim-lspconfig" then
              vim.cmd "silent! do FileType"
            end
          end, 0)
        else
          require("lazy").load { plugins = plugin }
        end
      end
    end,
  })
end

M.get_lua_file = function(dirUrl)
  return io.popen('find "' .. dirUrl .. '" -type f' .. ' -name "*.lua"')
end

M.get_file_name_without_ext = function(file)
  local name = file:match("^.+/(.+)$")
  return name:match("(.+)%..+$")
end

M.source_config_file = function(dirUrl)
  local files = M.get_lua_file(dirUrl)
  if files ~= nil then
    for file in files:lines() do
      if not M.get_file_name(file) == "lazy_nvim" then
        vim.cmd("luafile " .. file)
      end
    end
  end
end

M.is_last_line = function()
  local last_line = vim.api.nvim_buf_line_count(0)
  local current_line = vim.api.nvim__buf_stats(0).current_lnum
  return last_line == current_line
end

M.is_first_line = function()
  local current_line = vim.api.nvim__buf_stats(0).current_lnum
  return current_line == 1
end

M.is_blank_line = function()
  local current_line = vim.api.nvim__buf_stats(0).current_lnum
  local line = vim.api.nvim_buf_get_lines(0, current_line - 1, current_line, false)[1]
  return line == nil or line:match("^%s*$") ~= nil
end


-- default opts = 1
-- opts = 1 for noremap and silent
-- opts = 2 for not noremap and silent
-- opts = 3 for noremap and not silent
-- opts = 4 for not noremap and not silent
-- opts = 5 for expr and noremap and silent
M.map = function(mode, key, map_to, opts)
  local keymap = vim.keymap.set
  local opts1 = { noremap = true, silent = true }
  opts = opts or 1
  if type(opts) == "table" then
    opts = vim.tbl_deep_extend("force", opts1, opts)
    keymap(mode, key, map_to, opts)
    return
  end

  if opts == 1 then
    opts = opts1
  elseif opts == 2 then
    opts = { noremap = false, silent = true }
  elseif opts == 3 then
    opts = { noremap = true, silent = false }
  elseif opts == 4 then
    opts = { noremap = false, silent = false }
  elseif opts == 5 then
    opts = { expr = true, replace_keycodes = true, noremap = true, silent = true }
  else
    opts = opts1
  end
  keymap(mode, key, map_to, opts)
end

return M
