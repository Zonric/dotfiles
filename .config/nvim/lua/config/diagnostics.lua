vim.diagnostic.config({
	virtual_text = {
		current_line = false,
		spacing = 4,
		source = "if_many",
	},
	virtual_lines = false,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = " ",
			[vim.diagnostic.severity.WARN] = " ",
			[vim.diagnostic.severity.HINT] = " ",
			[vim.diagnostic.severity.INFO] = " ",
		},
	},
	underline = true,
	update_in_insert = false,
	float = {
		border = "rounded",
		source = "if_many",
	},
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = { "*_templ.go", "*/waybar/*.css" },
	callback = function(args)
		vim.diagnostic.enable(false, { bufnr = args.buf })
	end,
})
