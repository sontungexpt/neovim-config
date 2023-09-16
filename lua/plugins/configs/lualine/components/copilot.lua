local copilot = function()
	for _, client in pairs(vim.lsp.get_active_clients()) do
		if client.name == "copilot" then
			return "   "
		end
	end
	return ""
end

return copilot
