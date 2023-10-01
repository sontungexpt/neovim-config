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

local function capabilities()
	local capabilities = vim.tbl_deep_extend(
		"force",
		vim.lsp.protocol.make_client_capabilities() or {},
		require("cmp_nvim_lsp").default_capabilities()
	)
	capabilities.offsetEncoding = { "utf-8", "utf-16" }
	capabilities.textDocument.completion.completionItem = {
		documentationFormat = { "markdown", "plaintext" },
		snippetSupport = true,
		preselectSupport = true,
		insertReplaceSupport = true,
		labelDetailsSupport = true,
		deprecatedSupport = true,
		commitCharactersSupport = true,
		tagSupport = { valueSet = { 1 } },
		resolveSupport = {
			properties = {
				"documentation",
				"detail",
				"additionalTextEdits",
			},
		},
	}

	return capabilities
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
		install_path .. "/config_linux",
		"-data",
		-- require("core.utils").find_project_root(),
		require("jdtls.setup").find_root(root_markers),
	},
	capabilities = capabilities(),
	root_dir = require("jdtls.setup").find_root(root_markers),
	settings = {
		java = {},
	},

	init_options = {
		bundles = {},
	},
}

require("jdtls").start_or_attach(config)
