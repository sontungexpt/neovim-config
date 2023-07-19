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

-- default opts = 1
-- opts = 1 for noremap and silent
-- opts = 2 for not noremap and silent
-- opts = 3 for noremap and not silent
-- opts = 4 for not noremap and not silent
-- opts = 5 for expr and noremap and silent
M.map = function(mode, key, map_to, opts)
  local opts1 = { noremap = true, silent = true }
  opts = opts or 1
  if type(opts) == "table" then
    opts = vim.tbl_deep_extend("force", opts1, opts)
    vim.keymap.set(mode, key, map_to, opts)
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
  vim.keymap.set(mode, key, map_to, opts)
end

M.identified_files = {
  -- rust
  "Cargo.toml",
  "Cargo.lock",

  -- git
  ".git",
  ".gitignore",

  -- npm
  "package.json",
  "yarn.lock",

  -- c/c++
  "CMakeLists.txt",
}

M.find_project_root = function()
  local cwd = vim.fn.getcwd()
  while cwd ~= '/' do
    for _, file in ipairs(M.identified_files) do
      local file_path = vim.fn.findfile(file, cwd)
      if file_path ~= '' then
        return cwd
      end
    end
    cwd = vim.fn.fnamemodify(cwd, ':h')
  end
  return ""
end

M.continue_debugging = function()
  vim.schedule(function()
    local buf_ft = vim.bo.filetype
    local find_project_root = require('core.utils').find_project_root
    vim.cmd('cd ' .. find_project_root())

    if buf_ft == 'rust' then
      local job_id = vim.fn.jobstart('cargo run')
      local timeout = 2000
      local start_time = vim.loop.hrtime()
      while true do
        local status = vim.fn.jobwait({ job_id }, timeout)[1]
        if status == 0 then
          print('cargo run success')
          require('dap').continue()
          break
        end
        local elapsed_time = vim.loop.hrtime() - start_time
        if elapsed_time / 1e6 >= timeout then
          print('cargo run failed')
          break
        end
      end
    end
  end)
end

return M
