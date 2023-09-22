local copilot = function()
	local copilot_client = vim.lsp.get_active_clients({ name = "copilot" })[1]
	if copilot_client == nil then
		return ""
	end
	return "   "
end

return copilot
