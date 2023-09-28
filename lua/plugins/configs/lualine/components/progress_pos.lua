local progress = function()
	local current_line = vim.fn.line(".")
	local total_lines = vim.fn.line("$")
	local chars = { "_", "▁", "▂", "▃", "▄", "▅", "▆", "▇", "█" }
	local line_ratio = current_line / total_lines
	local index = math.ceil(line_ratio * #chars)
	return chars[index]
end

return progress
