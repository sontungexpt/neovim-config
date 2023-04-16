local M = {}

M.echo = function(str)
  vim.cmd "redraw"
  vim.api.nvim_echo({ { str, "Bold" } }, true, {})
end

M.lazy = function(install_path)
  --------- lazy.nvim ---------------
  M.echo "  Installing lazy.nvim & plugins ..."
  print ("Installing lazy.nvim & plugins")
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", "--branch=stable", repo, install_path }
  vim.opt.rtp:prepend(install_path)

  -- install plugins
  require "plugins"
  vim.api.nvim_buf_delete(0, { force = true }) -- close lazy window

  ---------- mason packages -------------
  vim.schedule(function()
    vim.cmd "MasonInstallAll"
    -- vim.cmd "MasonEnsurePackages"
    local packages = table.concat(vim.g.mason_binaries_list, " ")

    require("mason-registry"):on("package:install:success", function(pkg)
      packages = string.gsub(packages, pkg.name:gsub("%-", "%%-"), "") -- rm package name

      if packages:match "%S" == nil then
        vim.schedule(function()
          vim.api.nvim_buf_delete(0, { force = true })
        end)
      end
    end)
  end)
end

return M
