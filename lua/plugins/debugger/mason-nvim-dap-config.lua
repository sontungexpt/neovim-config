local status_ok, mason_nvim_dap = pcall(require, "mason-nvim-dap")

if not status_ok then
  return
end

mason_nvim_dap.setup {
  automatic_setup   = true,
  automatic_install = true,

  ensure_installed  = {
    'chrome',
    'node2',
  },
}
mason_nvim_dap.setup_handlers()
