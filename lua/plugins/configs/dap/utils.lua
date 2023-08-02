local M = {}

M.lang = {
	["rust"] = {
		cmd = "cargo build",
		msg = {
			running = "cargo build running",
			succeed = "cargo build success",
			failed = "cargo build failed",
			timed_out = "cargo build timed out",
		},
		timeout = 2000,
	},
}

M.continue_debugging = function()
	vim.schedule(function()
		local lang = M.lang[vim.bo.filetype]
		if not lang then
			print(
				"No language config found for "
					.. vim.bo.filetype
					.. ". Config for language in lua/plugins/configs/dap/utils.lua"
			)
			vim.notify(
				"No language config found for "
					.. vim.bo.filetype
					.. ". Config for language in lua/plugins/configs/dap/utils.lua",
				"error"
			)
			return
		end

		local fn = vim.fn
		local job_id = fn.jobstart(lang.cmd)

		local timeout = lang.timeout or 2000

		local start_time = vim.loop.hrtime()
		while true do
			local status = fn.jobwait({ job_id }, timeout)[1]

			if status == 0 then
				print(lang.msg.succeed or "job succeed")
				require("dap").continue()
				break
			elseif status == -1 then
				-- Job was stopped (e.g. user cancelled the debugging session)
				fn.jobstop(job_id)
				print("job stopped suddenly")
				vim.notify("job stopped suddenly", "error")
				break
			else
				-- Job failed to start or encountered an error
				fn.jobstop(job_id)
				print(lang.msg.failed)
				vim.notify(lang.msg.failed or "job failed", "error")
				break
			end

			local elapsed_time = vim.loop.hrtime() - start_time
			if elapsed_time / 1e6 >= timeout then
				-- Job timed out
				fn.jobstop(job_id)
				print(lang.msg.timed_out)
				vim.notify(lang.msg.timed_out or "time out", "warning")
				break
			end
		end
	end)
end

return M
