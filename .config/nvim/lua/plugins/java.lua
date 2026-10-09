local M = {
	"mfussenegger/nvim-jdtls",
	ft = "java",
	dependencies = {
		"mfussenegger/nvim-dap",
	},
}

function M.setup_jdtls()
	local jdtls = require("jdtls")

	local home = vim.env.HOME
	local mason_path = home .. "/.local/share/nvim/mason/packages"
	local jdtls_path = mason_path .. "/jdtls"

	local launcher_jar = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")
	if launcher_jar == "" then
		return
	end

	local config_dir = jdtls_path .. "/config_linux"
	local lombok_jar = jdtls_path .. "/lombok.jar"

	-- Unique workspace per project
	local root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" })
	local project_name = root_dir and vim.fn.fnamemodify(root_dir, ":p:h:t") or "default"
	local workspace_dir = vim.fn.stdpath("data") .. "/site/java-workspace/" .. project_name

	-- Capabilities (with blink.cmp integration if present)
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	local ok_blink, blink = pcall(require, "blink.cmp")
	if ok_blink then
		capabilities = blink.get_lsp_capabilities(capabilities)
	end

	-- Extended bundles for DAP (debugging)
	local bundles = {}
	local java_debug_jar = vim.fn.glob(
		mason_path .. "/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar"
	)
	if java_debug_jar ~= "" then
		table.insert(bundles, java_debug_jar)
	end

	-- Command arguments for JVM
	local cmd = {
		"java",
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
	}

	if vim.fn.filereadable(lombok_jar) == 1 then
		table.insert(cmd, "-javaagent:" .. lombok_jar)
	end

	table.insert(cmd, "-jar")
	table.insert(cmd, launcher_jar)
	table.insert(cmd, "-configuration")
	table.insert(cmd, config_dir)
	table.insert(cmd, "-data")
	table.insert(cmd, workspace_dir)

	local config = {
		cmd = cmd,
		root_dir = root_dir or vim.fn.getcwd(),
		capabilities = capabilities,
		init_options = {
			bundles = bundles,
			extendedClientCapabilities = jdtls.extendedClientCapabilities,
		},
		settings = {
			java = {
				eclipse = {
					downloadSources = true,
				},
				maven = {
					downloadSources = true,
				},
				implementationsCodeLens = {
					enabled = true,
				},
				referencesCodeLens = {
					enabled = true,
				},
				references = {
					includeDecompiledSources = true,
				},
				inlayHints = {
					parameterNames = {
						enabled = "all",
					},
				},
				format = {
					enabled = true,
				},
				signatureHelp = {
					enabled = true,
				},
				completion = {
					favoriteStaticMembers = {
						"org.hamcrest.MatcherAssert.assertThat",
						"org.hamcrest.Matchers.*",
						"org.hamcrest.CoreMatchers.*",
						"org.junit.jupiter.api.Assertions.*",
						"java.util.Objects.requireNonNull",
						"java.util.Objects.requireNonNullElse",
						"org.mockito.Mockito.*",
					},
					importOrder = {
						"java",
						"javax",
						"com",
						"org",
					},
				},
				sources = {
					organizeImports = {
						starThreshold = 9999,
						staticStarThreshold = 9999,
					},
				},
				codeGeneration = {
					toString = {
						template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
					},
					useBlocks = true,
				},
			},
		},
	}

	config.on_attach = function(client, bufnr)
		-- Enable DAP debugging support from nvim-jdtls
		if not vim.g.is_server then
			jdtls.setup_dap({ hotcodereplace = "auto" })
		end
	end

	jdtls.start_or_attach(config)
end

function M.config()
	local java_group = vim.api.nvim_create_augroup("JavaLspConfig", { clear = true })
	vim.api.nvim_create_autocmd("FileType", {
		pattern = "java",
		group = java_group,
		callback = function(args)
			M.setup_jdtls()

			-- Keymaps for Java files
			local wk_ok, wk = pcall(require, "which-key")
			if wk_ok then
				wk.add({ "<leader>j", group = "Java...", buffer = args.buf })
			end

			local map = function(keys, fn, desc, mode)
				vim.keymap.set(mode or "n", keys, fn, { buffer = args.buf, desc = desc })
			end

			local jdtls = require("jdtls")
			map("<leader>jo", jdtls.organize_imports, "Organize Imports")
			map("<leader>jv", jdtls.extract_variable, "Extract Variable")
			map("<leader>jc", jdtls.extract_constant, "Extract Constant")
			map("<leader>jm", jdtls.extract_method, "Extract Method", "v")
			map("<leader>jt", function()
				if not vim.g.is_server then
					jdtls.test_class()
				end
			end, "Test Class")
			map("<leader>jn", function()
				if not vim.g.is_server then
					jdtls.test_nearest_method()
				end
			end, "Test Nearest Method")
		end,
	})
end

return M
