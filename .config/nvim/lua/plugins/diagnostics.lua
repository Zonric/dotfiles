return {
	{
		"folke/trouble.nvim",
		enabled = true,
		cmd = "Trouble",
		opts = {
			modes = {
				todo = {
					mode = "todo",
					win = {
						type = "split",
						position = "right",
						size = 55,
					},
				},
			},
		},
	},
}
