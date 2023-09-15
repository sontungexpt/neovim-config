local status_ok, dap = pcall(require, "dap")
if not status_ok then
	return
end

local path_helpers = require("plugins.configs.dap.paths")

vim.fn.sign_define(
	"DapBreakpoint",
	{ text = " ", texthl = "DapBreakpointColor", linehl = "", numhl = "" }
)
vim.api.nvim_command("highlight DapBreakpointColor guifg=#EC5241")

vim.fn.sign_define("DapStopped", { text = "󰜴 ", texthl = "DapStoppedColor", linehl = "", numhl = "" })
vim.api.nvim_command("highlight DapStoppedColor guifg=#98C379")

dap.adapters.codelldb = {
	type = "server",
	host = "127.0.0.1",
	port = 13000,
}

dap.adapters.codelldb = {
	type = "server",
	port = "${port}",
	executable = {
		-- CHANGE THIS to your path!
		command = path_helpers.get_adapter_mason_path("codelldb"),
		args = { "--port", "${port}" },
	},
}

dap.configurations.cpp = {
	{
		name = "Launch file",
		type = "codelldb",
		request = "launch",
		program = function()
			return vim.fn.input("path to executable: ", vim.fn.getcwd() .. "/bin/program", "file")
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
		args = {},
	},
}
dap.configurations.c = dap.configurations.cpp

dap.configurations.rust = {
	{
		type = "codelldb",
		name = "Debug Rust",
		request = "launch",
		program = function()
			return path_helpers.get_rust_debug_filepath()
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
	},
}

dap.adapters.coreclr = {
	type = "executable",
	command = vim.fn.stdpath("data") .. "/mason/bin/netcoredbg",
	args = { "--interpreter=vscode" },
}
dap.configurations.cs = {
	{
		type = "coreclr",
		name = "launch - netcoredbg",
		request = "launch",
		program = function() -- Ask the user what executable wants to debug
			return vim.fn.input("Path to dll: ", vim.fn.getcwd() .. "/bin/Program.exe", "file")
		end,
	},
}

-- F#
dap.configurations.fsharp = dap.configurations.cs

-- Visual basic dotnet
dap.configurations.vb = dap.configurations.cs

-- Java
-- Note: The java debugger jdtls is automatically spawned and configured
--       when a java file is opened. You can check it out here:
--       ../base/3-autocmds.lua

-- Python
dap.adapters.python = {
	type = "executable",
	command = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python",
	args = { "-m", "debugpy.adapter" },
}
dap.configurations.python = {
	{
		type = "python",
		request = "launch",
		name = "Launch file",
		program = "${file}", -- This configuration will launch the current file if used.
	},
}

-- Go
-- Requires:
-- * You have initialized your module with 'go mod init module_name'.
-- * You :cd your project before running DAP.
dap.adapters.delve = {
	type = "server",
	port = "${port}",
	executable = {
		command = vim.fn.stdpath("data") .. "/mason/packages/delve/dlv",
		args = { "dap", "-l", "127.0.0.1:${port}" },
	},
}
dap.configurations.go = {
	{
		type = "delve",
		name = "Compile module and debug this file",
		request = "launch",
		program = "./${relativeFileDirname}",
	},
	{
		type = "delve",
		name = "Compile module and debug this file (test)",
		request = "launch",
		mode = "test",
		program = "./${relativeFileDirname}",
	},
}
--       -- Shell
dap.adapters.bashdb = {
	type = "executable",
	command = vim.fn.stdpath("data") .. "/mason/packages/bash-debug-adapter/bash-debug-adapter",
	name = "bashdb",
}
dap.configurations.sh = {
	{
		type = "bashdb",
		request = "launch",
		name = "Launch file",
		showDebugOutput = true,
		pathBashdb = vim.fn.stdpath("data")
			.. "/mason/packages/bash-debug-adapter/extension/bashdb_dir/bashdb",
		pathBashdbLib = vim.fn.stdpath("data") .. "/mason/packages/bash-debug-adapter/extension/bashdb_dir",
		trace = true,
		file = "${file}",
		program = "${file}",
		cwd = "${workspaceFolder}",
		pathCat = "cat",
		pathBash = "/bin/bash",
		pathMkfifo = "mkfifo",
		pathPkill = "pkill",
		args = {},
		env = {},
		terminalKind = "integrated",
	},
}
