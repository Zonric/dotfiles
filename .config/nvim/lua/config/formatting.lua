return {
	formatters = {
		goimports = {
			command = "goimports",
		},
		prettier = {
			command = "/usr/bin/prettier",
		},
		shfmt = {
			args = { "-i", "0", "-ci", "-ln", "bash" },
		},
		["clang-format"] = {
			command = "clang-format",
			args = { "-style=file" },
		},
	},
	formatters_by_ft = {
		blade = { "blade-formatter" },
		cpp = { "clang-format" },
		css = { "prettierd", "prettier", stop_after_first = true },
		go = { "goimports" },
		html = { "prettierd", "prettier", stop_after_first = true },
		java = { "google-java-format" },
		javascript = { "prettierd", "prettier", stop_after_first = true },
		javascriptreact = { "prettierd", "prettier", stop_after_first = true },
		json = { "biome", "prettierd", "prettier", stop_after_first = true },
		lua = { "stylua" },
		markdown = { "prettierd", "prettier", stop_after_first = true },
		php = { "php_cs_fixer" },
		python = { "isort", "black" },
		scss = { "prettierd", "prettier", stop_after_first = true },
		sh = { "shfmt" },
		sql = { "pg_format" },
		pgsql = { "pg_format" },
		templ = { "templ" },
		toml = { "tombi" },
		twig = { "twig-cs-fixer" },
		typescript = { "prettierd", "prettier", stop_after_first = true },
		typescriptreact = { "prettierd", "prettier", stop_after_first = true },
		yaml = { "prettierd", "prettier", stop_after_first = true },
		zsh = { "beautysh" },
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_fallback = true,
	},
}
