local M = {}
M.get_installed_packages = function()
  local installed_packages = {}
  local package_path = vim.fn.stdpath('data') .. '/mason/packages/'
  local package_dirs = vim.fn.glob(package_path .. '/*', true, true)
  for _, package_dir in ipairs(package_dirs) do
    local package_name = vim.fn.fnamemodify(package_dir, ':t')
    table.insert(installed_packages, package_name)
  end
  return installed_packages
end

M.ensure_packages = function()
  local packages = require('plugins.configs.mason').ensure_installed
  local installed_packages = M.get_installed_packages()
  if #installed_packages < #packages then
    for _, installed_package in ipairs(installed_packages) do
      for i, package in ipairs(packages) do
        if package == installed_package then
          table.remove(packages, i)
        end
      end
    end
    if #packages > 0 then
      vim.cmd("MasonInstall " .. table.concat(packages, " "))
    end
  end
end

M.clean_ensured_packages = function()
  local packages = require('plugins.configs.mason').ensure_installed
  local installed_packages = M.get_installed_packages()
  if #installed_packages > #packages then
    for _, package in ipairs(packages) do
      for i, installed_package in ipairs(installed_packages) do
        if package == installed_package then
          table.remove(installed_packages, i)
        end
      end
    end
    if #installed_packages > 0 then
      vim.cmd("MasonUninstall " .. table.concat(installed_packages, " "))
    end
  end
end

-- Custom cmd to ensure install all mason binaries listed
M.create_user_commands = function()
  -- The command that will be used to install all ensure packages
  vim.api.nvim_create_user_command("MasonEnsurePackages", function()
    M.ensure_packages()
  end, {})

  -- The command that will be used to sync the ensure packages with the installed packages
  vim.api.nvim_create_user_command("MasonSyncEnsurePackages", function()
    M.clean_ensured_packages()
  end, {})

  vim.api.nvim_create_user_command("MasonInstallAll", function()
    vim.cmd("MasonInstall " .. table.concat(require('plugins.configs.mason').ensure_installed, " "))
  end, {})
end


-------------------- Auto commands --------------------
M.create_autocmds = function()
  -- Mason
  vim.api.nvim_create_autocmd({ 'VimEnter' }, {
    group = vim.api.nvim_create_augroup('MasonCommands', {}),
    callback = function()
      local mason_installed_packages = require('plugins.autocmds.mason').get_installed_packages()
      local ensure_packages = require('plugins.configs.mason').ensure_installed
      if #mason_installed_packages ~= #ensure_packages then
        vim.cmd("MasonSyncEnsurePackages")
        vim.cmd("bd")
        vim.cmd("MasonEnsurePackages")
      end
    end
  })
end

return M
