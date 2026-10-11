return {
	{
		"zk-org/zk-nvim",
		enabled = true,
		lazy = true,
		ft = { "markdown" },
		cmd = {
			"ZkNew",
			"ZkNotes",
			"ZkTags",
			"ZkMatch",
			"ZkLinks",
			"ZkBacklinks",
			"ZkCd",
			"ZkIndex",
		},
		config = function()
			require("zk").setup({
				picker = "fzf_lua",
				lsp = {
					config = {
						cmd = { "zk", "lsp" },
						name = "zk",
					},
					auto_attach = {
						enabled = true,
					},
				},
			})

			-- Attach immediately to the active markdown buffer if already open
			local cur_buf = vim.api.nvim_get_current_buf()
			if vim.bo[cur_buf].filetype == "markdown" then
				require("zk.lsp").buf_add(cur_buf)
			end
		end,
	},
}
