local api = vim.api
local fn = vim.fn

local M = {}

M.PATTERNS = {
	["(https?://[%w-_%.%?%.:/%+=&]+%f[^%w])"] = "", --url
	['["]([^%s]*)["]:'] = "https://www.npmjs.com/package/", --npm package
	["[\"']([^%s~/]*/[^%s~/]*)[\"']"] = "https://github.com/", --plugin name git
}

M.find_url = function(text, start_pos)
	start_pos = start_pos or 0

	for pattern, prefix in pairs(M.PATTERNS) do
		local start_pos_result, end_pos_result, url = text:find(pattern, start_pos)
		if url then
			url = prefix .. url
			return start_pos_result, end_pos_result, url
		end
	end

	return nil, nil, nil
end

M.open_url = function()
	local cursor_pos = api.nvim_win_get_cursor(0)
	local cursor_col = cursor_pos[2]
	local line = api.nvim_get_current_line()

	local url_to_open = nil

	-- get the first url in the line
	local start_pos, end_pos, url = M.find_url(line)

	while url do
		url_to_open = url
		-- if the url under cursor, then break
		if cursor_col >= start_pos and cursor_col <= end_pos then
			break
		end

		-- find the next url
		start_pos, end_pos, url = M.find_url(line, end_pos + 1)
	end

	if url_to_open then
		local shell_safe_url = fn.shellescape(url_to_open)
		local command = ""
		if vim.loop.os_uname().sysname == "Linux" then
			command = "silent! !xdg-open " .. shell_safe_url
		elseif vim.loop.os_uname().sysname == "Darwin" then
			command = "silent! !open " .. shell_safe_url
		elseif vim.loop.os_uname().sysname == "Windows" then
			command = "silent! !start " .. shell_safe_url
		else
			print("Unknown operating system.")
			return
		end
		require("core.utils").call_cmd(command, {
			success = "Opening " .. url_to_open .. " successfully.",
			error = "Opening " .. url_to_open .. " failed.",
		})
	end
end

return M
