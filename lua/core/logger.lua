local M = {}

local levels = vim.log.levels
local notify = vim.notify
local schedule = vim.schedule

M.info = function(msg, opts)
	opts = opts or { title = "Info" }
	schedule(function()
		notify(msg, levels.INFO, opts)
	end)
end

M.warn = function(msg, opts)
	opts = opts or { title = "Warning" }
	schedule(function()
		notify(msg, levels.WARN, opts)
	end)
end

M.error = function(msg, opts)
	opts = opts or { title = "Error" }
	schedule(function()
		notify(msg, levels.ERROR, opts)
	end)
end

M.debug = function(msg, opts)
	opts = opts or { title = "Debug" }
	schedule(function()
		notify(msg, levels.DEBUG, opts)
	end)
end

M.trace = function(msg, opts)
	opts = opts or { title = "Trace" }
	schedule(function()
		notify(msg, levels.TRACE, opts)
	end)
end

M.off = function(msg, opts)
	opts = opts or { title = "Off" }
	schedule(function()
		notify(msg, levels.OFF, opts)
	end)
end

return M
