local status, jdtls = pcall(require, "jdtls")
if not status then
	return
end

local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }

-- get the mason install path
local install_path = require("mason-registry").get_package("jdtls"):get_install_path()

local os = vim.loop.os_uname().sysname

if os == "Linux" then
	os = "linux"
elseif os == "Darwin" then
	os = "mac"
elseif os == "Windows" then
	os = "win"
end

-- return the server config
local config = {
	cmd = {
		"/usr/lib/jvm/java-17-openjdk/bin/java", -- or '/path/to/java17_or_newer/bin/java'
		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Dlog.protocol=true",
		"-Dlog.level=ALL",
		"-Xmx1g",
		"--add-modules=ALL-SYSTEM",
		"--add-opens",
		"java.base/java.util=ALL-UNNAMED",
		"--add-opens",
		"java.base/java.lang=ALL-UNNAMED",
		"-jar",
		install_path .. "/plugins/org.eclipse.equinox.launcher_1.6.500.v20230717-2134.jar",
		"-configuration",
		install_path .. "/config_" .. os,
		"-data",
		require("jdtls.setup").find_root(root_markers),
	},
	capabilities = require("plugins.configs.lsp.general-configs").capabilities(true),
	root_dir = require("jdtls.setup").find_root(root_markers),
	settings = {
		java = {
			configuration = {
				runtimes = {
					{
						name = "JavaSE-11",
						path = "/usr/lib/jvm/java-11-openjdk/",
					},
					{
						name = "JavaSE-17",
						path = "/usr/lib/jvm/java-17-openjdk/",
					},
				},
			},
		},
	},
	init_options = {
		bundles = {},
	},
}

require("jdtls").start_or_attach(config)
