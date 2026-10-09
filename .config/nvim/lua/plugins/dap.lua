return {
	{
		"mfussenegger/nvim-dap",
		enabled = not vim.g.is_server,
		lazy = true,
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"theHamsta/nvim-dap-virtual-text",
			"nvim-neotest/nvim-nio",
		},
		config = function()
			require("config.dap").setup()
		end,
	},
}
