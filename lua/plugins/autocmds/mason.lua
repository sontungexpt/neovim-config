local M = {}

M.is_mason_install = function()
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

M.had_changed = function()
  local packages = require('plugins.configs.mason').ensure_installed
  local installed_packages = M.get_installed_packages()
  if #installed_packages ~= #packages then
    return true
  end
  for _, package in ipairs(packages) do
    local isInstalled = false
    for _, installed_package in ipairs(installed_packages) do
      if package == installed_package then
        isInstalled = true
      end
    end
    if not isInstalled then
      return true
    end
  end
  return false
end


M.get_packages_to_remove = function()
  local ensured_packages = require('plugins.configs.mason').ensure_installed
  local installed_packages = M.get_installed_packages()
  local packages_to_remove = {}

  if #ensured_packages == 0 then
    return installed_packages
  end

  for _, installed_package in ipairs(installed_packages) do
    local isEnsured = false
    for _, package in ipairs(ensured_packages) do
      if package == installed_package then
        isEnsured = true
      end
    end
    if not isEnsured then
      table.insert(packages_to_remove, installed_package)
    end
  end

  return packages_to_remove
end

M.get_packages_to_install = function()
  local ensured_packages = require('plugins.configs.mason').ensure_installed
  local installed_packages = M.get_installed_packages()
  local packages_to_install = {}

  if #installed_packages == 0 then
    return ensured_packages
  end

  for _, package in ipairs(ensured_packages) do
    local isInstalled = false
    for _, installed_package in ipairs(installed_packages) do
      if package == installed_package then
        isInstalled = true
      end
    end
    if not isInstalled then
      table.insert(packages_to_install, package)
    end
  end

  return packages_to_install
end

M.sync_packages = function()
  if not M.is_mason_install() then
    return
  end

  local packages_to_install = M.get_packages_to_install()
  local packages_to_remove = M.get_packages_to_remove()

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
  if not M.is_mason_install() then
    return
  end

  vim.api.nvim_create_user_command("MasonSyncPackages", function()
    M.sync_packages()
  end, {})

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
  if not M.is_mason_install() then
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
