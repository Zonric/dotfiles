return {
	{
		"Zonric/codecopy.nvim",
		enabled = true,
		dependencies = { "MunifTanjim/nui.nvim" },
		opts = {
			keymap = "<leader>cc",
			env = {
				enabled = true,
			},
		},
	},
	{
		"zonric/codecopy.nvim",
		name = "codecopy-dev-remote",
		branch = "dev",
		enabled = false,
		dependencies = { "MunifTanjim/nui.nvim" },
		opts = {
			keymap = "<leader>cc",
		},
	},
	{
		dir = "~/dev/nvim/codecopy.nvim",
		name = "codecopy-dev-local",
		enabled = false,
		dependencies = { "MunifTanjim/nui.nvim" },
		opts = {
			keymap = "<leader>cc",
			messages = {
				debug = true,
			},
		},
	},
}
