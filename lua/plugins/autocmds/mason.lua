local M = {}

M.is_mason_installed = function()
  local mason_path = vim.fn.stdpath('data') .. '/mason'
  return vim.fn.isdirectory(mason_path) == 1
end

M.print_installed_packages = function()
  local installed_packages = M.get_installed_packages()
  print("Installed mason packages: " .. table.concat(installed_packages, ", "))
end

M.print_ensured_packages = function()
  local ensured_packages = require('plugins.configs.mason').ensure_installed
  print("Ensured mason packages: " .. table.concat(ensured_packages, ", "))
end

M.get_installed_packages = function()
  local installed_packages = {}
  local package_path = vim.fn.stdpath('data') .. '/mason/packages/'
  if vim.fn.isdirectory(package_path) == 1 then
    local package_dirs = vim.fn.glob(package_path .. '/*', true, true)
    for _, package_dir in ipairs(package_dirs) do
      local package_name = vim.fn.fnamemodify(package_dir, ':t')
      table.insert(installed_packages, package_name)
    end
  end
  return installed_packages
end

M.compare_same_table = function(table1, table2) -- O(n)
  if #table1 ~= #table2 then
    return false
  end

  local t1_counts = {}

  for _, v1 in ipairs(table1) do
    t1_counts[v1] = (t1_counts[v1] or 0) + 1
  end

  for _, v2 in ipairs(table2) do
    local count = t1_counts[v2] or 0
    if count == 0 then
      return false
    end
    t1_counts[v2] = count - 1
  end
  return true
end

M.get_not_exists_in_table2 = function(table1, table2)
  if #table2 == 0 then
    return table1
  end

  local not_exists = {}
  local t2_counts = {}

  for _, v2 in ipairs(table2) do
    t2_counts[v2] = (t2_counts[v2] or 0) + 1
  end

  for _, v1 in ipairs(table1) do
    local count = t2_counts[v1] or 0
    if count == 0 then
      table.insert(not_exists, v1)
    end
  end

  return not_exists
end

M.had_changed = function()
  local ensured_packages = require('plugins.configs.mason').ensure_installed
  local installed_packages = M.get_installed_packages()
  return not M.compare_same_table(ensured_packages, installed_packages)
end

M.sync_packages = function()
  local ensured_packages = require('plugins.configs.mason').ensure_installed
  local installed_packages = M.get_installed_packages()
  local packages_to_remove = M.get_not_exists_in_table2(installed_packages, ensured_packages)
  local packages_to_install = M.get_not_exists_in_table2(ensured_packages, installed_packages)

  vim.schedule(function()
    if #packages_to_remove > 0 then
      vim.cmd("MasonUninstall " .. table.concat(packages_to_remove, " "))
    end
  end)
  vim.schedule(function()
    if #packages_to_install > 0 then
      vim.cmd("MasonInstall " .. table.concat(packages_to_install, " "))
    end
  end)
end

-- Custom cmd to ensure install all mason binaries listed
M.create_user_commands = function()
  if not M.is_mason_installed() then
    return
  end

  vim.api.nvim_create_user_command("MasonInstallAll", function()
    vim.cmd("MasonInstall " .. table.concat(require('plugins.configs.mason').ensure_installed, " "))
  end, {})

  vim.api.nvim_create_user_command("MasonShowInstalledPackages", function()
    M.print_installed_packages()
  end, {})

  vim.api.nvim_create_user_command("MasonShowEnsuredPackages", function()
    M.print_ensured_packages()
  end, {})
end

-------------------- Auto commands --------------------
M.create_autocmds = function()
  if not M.is_mason_installed() then
    return
  end
  vim.api.nvim_create_autocmd({ 'VimEnter' }, {
    group = vim.api.nvim_create_augroup('MasonCommands', {}),
    callback = function()
      if M.had_changed() then
        M.sync_packages()
      end
    end
  })
end

return M
