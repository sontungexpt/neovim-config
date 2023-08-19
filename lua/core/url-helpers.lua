local api = vim.api
local fn = vim.fn

local M = {}

M.DEEP_PATTERN =
	"\\v\\c%(%(h?ttps?|ftp|file|ssh|git)://|[a-z]+[@][a-z]+[.][a-z]+:)%([&:#*@~%_\\-=?!+;/0-9a-z]+%(%([.;/?]|[.][.]+)[&:#*@~%_\\-=?!+/0-9a-z]+|:\\d+|,%(%(%(h?ttps?|ftp|file|ssh|git)://|[a-z]+[@][a-z]+[.][a-z]+:)@![0-9a-z]+))*|\\([&:#*@~%_\\-=?!+;/.0-9a-z]*\\)|\\[[&:#*@~%_\\-=?!+;/.0-9a-z]*\\]|\\{%([&:#*@~%_\\-=?!+;/.0-9a-z]*|\\{[&:#*@~%_\\-=?!+;/.0-9a-z]*\\})\\})+"

M.PATTERNS = {
	["(https?://[%w-_%.%?%.:/%+=&]+%f[^%w])"] = "", --url http(s)
	['["]([^%s]*)["]:'] = "https://www.npmjs.com/package/", --npm package
	["[\"']([^%s~/]*/[^%s~/]*)[\"']"] = "https://github.com/", --plugin name git
	["%[.*%]%((https?://[a-zA-Z0-9_/%-%.~@\\+#=?&]+)%)"] = "", --markdown link
	['brew ["]([^%s]*)["]'] = "https://formulae.brew.sh/formula/", --brew formula
	['cask ["]([^%s]*)["]'] = "https://formulae.brew.sh/cask/", -- cask formula
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

	-- fallback to deep pattern
	-- TODO: enable this when create a plugin for url support
	-- local results = fn.matchstrpos(text, M.DEEP_PATTERN, start_pos)
	-- -- result[1] is url, result[2] is start_pos, result[3] is end_pos
	-- if results[1] ~= "" then
	-- 	return results[2], results[3], results[1]
	-- end

	return nil, nil, nil -- no url found
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
