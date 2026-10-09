-- Highlight yanked text.
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.hl.on_yank({ higroup = "IncSearch", timeout = 200 })
	end,
})

-- Pin help window to left v split
vim.api.nvim_create_autocmd("FileType", {
	pattern = "help",
	callback = function(args)
		vim.bo[args.buf].bufhidden = "unload"
		local win = vim.api.nvim_get_current_win()
		vim.cmd("wincmd L")
		vim.api.nvim_win_set_width(win, 80)
		vim.wo[win].winfixwidth = true
	end,
})

-- Add esc to close mini.files
vim.api.nvim_create_autocmd("User", {
	pattern = "MiniFilesBufferCreate",
	callback = function(args)
		vim.keymap.set("n", "<Esc>", function()
			require("mini.files").close()
		end, {
			buffer = args.data.buf_id,
		})
	end,
})

-- Gracefully handle markdown if treesitter parser is not installed yet
vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	callback = function(args)
		local ok = pcall(vim.treesitter.language.inspect, "markdown")
		if not ok then
			pcall(vim.treesitter.stop, args.buf)
			vim.bo[args.buf].syntax = "markdown"
		end
	end,
})

-- Auto close nvim-tree if it is the last remaining window
vim.api.nvim_create_autocmd("QuitPre", {
	callback = function()
		local invalid_win = {}
		local wins = vim.api.nvim_list_wins()
		for _, w in ipairs(wins) do
			local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(w))
			if bufname:match("NvimTree_") ~= nil then
				table.insert(invalid_win, w)
			end
		end
		if #invalid_win == #wins - 1 then
			for _, w in ipairs(invalid_win) do
				vim.api.nvim_win_close(w, true)
			end
		end
	end,
})

-- Enable Treesitter indentation for templ and html files
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "templ", "html" },
	callback = function(args)
		vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end,
})

-- CodeCompanion settings: line numbers & buffer shortcuts
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "codecompanion", "codecompanion_cli" },
	callback = function(args)
		vim.opt_local.number = false
		vim.opt_local.relativenumber = false
		if args.match == "codecompanion_cli" then
			vim.keymap.set("n", "q", function()
				require("codecompanion").toggle_cli()
			end, { buffer = args.buf, desc = "Hide CLI terminal window." })
		end
	end,
})
