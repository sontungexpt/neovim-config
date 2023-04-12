local status_ok, shade = pcall(require, "shade")

if not status_ok then
  return
end

shade.setup {
  overlay_opacity = 50,
  opacity_step = 0,
  exclude_filetypes = { "NvimTree" },
}
