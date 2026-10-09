return {
	{
		"vuki656/package-info.nvim",
		enabled = not vim.g.is_server,
		event = { "BufRead package.json" },
		dependencies = { "MunifTanjim/nui.nvim" },
		opts = {},
	},
	{
		"saecki/crates.nvim",
		enabled = not vim.g.is_server,
		event = { "BufRead Cargo.toml" },
		opts = {
			lsp = {
				enabled = true,
				actions = true,
				completion = true,
				hover = true,
			},
		},
	},
}
