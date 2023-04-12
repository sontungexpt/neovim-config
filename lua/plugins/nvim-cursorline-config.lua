local status_ok, nvim_cursorline = pcall(require, "nvim-cursorline")
if not status_ok then
  return
end

nvim_cursorline.setup {
  cursorline = {
    enable = true,
    timeout = 400,
    number = false,
  },
  cursorword = {
    enable = true,
    min_length = 3,
    hl = { underline = true },
  }
}
