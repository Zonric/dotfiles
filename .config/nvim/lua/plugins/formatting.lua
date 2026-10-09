return {
	{
		"stevearc/conform.nvim",
		enabled = true,
		event = { "BufReadPre", "BufNewFile" },
		opts = function()
			return require("config.formatting")
		end,
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		enabled = true,
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"mason-org/mason.nvim",
		},
		opts = function()
			local tools = {
				"blade-formatter",
				"php-cs-fixer",
				"tombi",
				"twig-cs-fixer",
				"beautysh",
				"isort",
				"black",
				"prettierd",
				"pgformatter",
				"zlint",
			}
			if not vim.g.is_server then
				table.insert(tools, "js-debug-adapter")
			end
			return { ensure_installed = tools }
		end,
	},
	{
		"nvim-mini/mini.align",
		version = "*",
		enabled = true,
		lazy = true,
		keys = {
			{ "ga", mode = { "n", "v" }, desc = "Align" },
			{ "gA", mode = { "n", "v" }, desc = "Align with preview" },
		},
		mappings = {
			start = "ga",
			start_with_preview = "gA",
		},
		config = function()
			require("mini.align").setup()
		end,
	},
}
