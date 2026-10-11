local safe = require("config.keymaps.util").safe
local wk_add_group = require("config.keymaps.util").wk_add_group
local map = vim.keymap.set

--- File Tree
map("n", "<leader>\\", safe("nvim-tree.api", function(api)
	api.tree.toggle({ focus = true })
end), { desc = "File Tree" })

--- Mini.Files
map("n", "<leader>e", safe("mini.files", function(mf)
	if not mf.close() then
		mf.open()
	end
end), { desc = "File Explorer" })

--- AI / Antigravity
wk_add_group("<leader>a", "AI / Antigravity...")
map({ "n", "v" }, "<leader>aa", "<CMD>CodeCompanionActions<CR>", { desc = "Action palette." })
map({ "n", "v" }, "<leader>ac", "<CMD>CodeCompanionChat Toggle<CR>", { desc = "Toggle chat." })
map({ "n", "v" }, "<leader>ai", "<CMD>CodeCompanion<CR>", { desc = "Inline assistant." })
map({ "n", "v" }, "<leader>at", safe("codecompanion", function(cc)
	cc.toggle_cli()
end), { desc = "Toggle Antigravity CLI terminal." })
map({ "n", "v" }, "<leader>ap", "<CMD>CodeCompanionCLI Ask<CR>", { desc = "CLI prompt input." })
map("v", "<leader>as", function()
	local start_pos = vim.fn.getpos("'<")
	local end_pos = vim.fn.getpos("'>")
	local lines = vim.api.nvim_buf_get_lines(0, start_pos[2] - 1, end_pos[2], false)
	local ok, agents = pcall(require, "config.agents")
	if ok then
		agents.speak(table.concat(lines, " "))
	end
end, { desc = "TTS Speak visual selection." })
map("n", "<leader>as", function()
	local line = vim.api.nvim_get_current_line()
	local ok, agents = pcall(require, "config.agents")
	if ok then
		agents.speak(line)
	end
end, { desc = "TTS Speak current line." })
map("n", "<leader>aX", safe("config.agents", function(ag)
	ag.stop_speaking()
end), { desc = "TTS Stop speaking." })

--- Buffers
wk_add_group("<leader>b", "Buffers...")
map("n", "<leader>bd", "<CMD>bp|bd#<CR>", { desc = "delete current." })

--- Code
wk_add_group("<leader>c", "Code...")
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "actions." })
map("n", "<leader>cc", "<CMD>CodeCopy<CR>", { desc = "Copy." })
map({ "n", "v" }, "<leader>cf", safe("conform", function(c)
	c.format({ lsp_fallback = true, async = false, timeout_ms = 500 })
end), { desc = "Format buffer/selection." })
map("n", "<leader>cu", "<CMD>CodeCopy open ui<CR>", { desc = "Open CC UI." })
map("n", "<leader>ce", vim.diagnostic.open_float, { desc = "diagnostics." })
map("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Rename symbol." })
map("n", "<leader>ch", function()
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = 0 }), { bufnr = 0 })
end, { desc = "Toggle Inlay Hints." })

--- Debug / DAP
if not vim.g.is_server then
	wk_add_group("<leader>d", "Debug / Data...")
	map("n", "<leader>db", safe("dap", "toggle_breakpoint"), { desc = "Set Breakpoint." })
	map("n", "<leader>dB", function()
		local ok, dap = pcall(require, "dap")
		if ok then
			dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
		end
	end, { desc = "Conditional Breakpoint." })
	map("n", "<leader>dc", safe("dap", "continue"), { desc = "Start/Continue" })
	map("n", "<leader>di", safe("dap", "step_into"), { desc = "Step Into" })
	map("n", "<leader>dn", safe("dap", "step_over"), { desc = "Step Over" })
	map("n", "<leader>do", safe("dap", "step_out"), { desc = "Step Out" })
	map("n", "<leader>dq", safe("dap", "terminate"), { desc = "Terminate" })
	map("n", "<leader>dr", safe("dapui", function(dui)
		dui.open({ reset = true })
	end), { desc = "Open Repl" })
	map("n", "<leader>du", safe("dapui", "toggle"), { desc = "Toggle DAP UI" })

	wk_add_group("<leader>dd", "Database...")
	map("n", "<leader>ddu", "<CMD>DBUIToggle<CR>", { desc = "Toggle DB UI." })
	map("n", "<leader>ddf", "<CMD>DBUIFindBuffer<CR>", { desc = "Find DB buffer." })
	map("n", "<leader>ddr", "<CMD>DBUIRenameBuffer<CR>", { desc = "Rename DB buffer." })
	map("n", "<leader>ddl", "<CMD>DBUILastQueryInfo<CR>", { desc = "Last query info." })
end

--- Find (fzf-lua)
wk_add_group("<leader>f", "Find...")
map("n", "<leader>fb", safe("fzf-lua", "buffers"), { desc = "Buffers." })
map("n", "<leader>fd", safe("fzf-lua", "diagnostics_document"), { desc = "Diagnostic." })
map("n", "<leader>ff", safe("fzf-lua", "files"), { desc = "Files." })
map("n", "<leader>fh", safe("fzf-lua", "help_tags"), { desc = "Help Tags." })
map("n", "<leader>fk", safe("fzf-lua", "keymaps"), { desc = "Keymaps." })
map("n", "<leader>fm", safe("fzf-lua", "manpages"), { desc = "Man Pages." })
map("n", "<leader>fr", safe("fzf-lua", "lsp_references"), { desc = "LSP References." })
map("n", "<leader>fs", safe("fzf-lua", "lsp_document_symbols"), { desc = "LSP Symbols." })

--- Git
wk_add_group("<leader>g", "Git...")
map("n", "<leader>gb", safe("fzf-lua", "git_branches"), { desc = "Branches." })
map("n", "<leader>gB", safe("fzf-lua", "git_blame"), { desc = "Blame." })
map("n", "<leader>gc", safe("fzf-lua", "git_commits"), { desc = "Commit logs." })
map("n", "<leader>gd", "<CMD>DiffviewOpen<CR>", { desc = "Diffview Open." })
map("n", "<leader>gD", "<CMD>DiffviewClose<CR>", { desc = "Diffview Close." })
map("n", "<leader>gf", safe("fzf-lua", "git_diff"), { desc = "Diff files (fzf)." })
map("n", "<leader>gs", safe("fzf-lua", "git_status"), { desc = "Status." })
map("n", "<leader>gl", "<CMD>LazyGit<CR>", { desc = "LazyGit." })
map("n", "<leader>gp", safe("gitsigns", "preview_hunk"), { desc = "Preview hunk." })

wk_add_group("<leader>gh", "Hunk...")
map("n", "<leader>ghs", safe("gitsigns", "stage_hunk"), { desc = "Stage hunk." })
map("n", "<leader>ghr", safe("gitsigns", "reset_hunk"), { desc = "Reset hunk." })
map("n", "<leader>ghu", safe("gitsigns", "stage_hunk"), { desc = "Undo / toggle stage hunk." })
map("v", "<leader>ghs", safe("gitsigns", function(gs)
	gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
end), { desc = "Stage selected hunk." })
map("v", "<leader>ghr", safe("gitsigns", function(gs)
	gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
end), { desc = "Reset selected hunk." })

--- Packages
if not vim.g.is_server then
	wk_add_group("<leader>p", "Packages...")
	map("n", "<leader>pt", safe("package-info", "toggle"), { desc = "Toggle package versions." })
	map("n", "<leader>pu", safe("package-info", "update"), { desc = "Update package." })
	map("n", "<leader>pd", safe("package-info", "delete"), { desc = "Delete package." })
	map("n", "<leader>pi", safe("package-info", "install"), { desc = "Install package." })
	map("n", "<leader>pc", safe("package-info", "change_version"), { desc = "Change package version." })
end

--- Search (fzf-lua)
wk_add_group("<leader>s", "Search...")
map("n", "<leader>sb", safe("fzf-lua", "lgrep_curbuf"), { desc = "current Buffer" })
map("n", "<leader>sf", safe("fzf-lua", "live_grep"), { desc = "Files." })
map("n", "<leader>sk", safe("fzf-lua", "keymaps"), { desc = "Keymaps." })
map("n", "<leader>st", "<CMD>TodoFzfLua<CR>", { desc = "Todo comments" })
map("n", "<leader>sw", safe("fzf-lua", "grep_cword"), { desc = "Word under cursor." })

--- Test (neotest)
if not vim.g.is_server then
	wk_add_group("<leader>t", "Test...")
	map("n", "<leader>td", safe("neotest", function(nt)
		nt.run.run(vim.fn.expand("%:p:h"))
	end), { desc = "Run directory tests." })
	map("n", "<leader>tf", safe("neotest", function(nt)
		nt.run.run(vim.fn.expand("%"))
	end), { desc = "Run file tests." })
	map("n", "<leader>tl", safe("neotest", function(nt)
		nt.run.run_last()
	end), { desc = "Run last test." })
	map("n", "<leader>to", safe("neotest", function(nt)
		nt.output.open({ enter = true })
	end), { desc = "Open test output." })
	map("n", "<leader>tr", safe("neotest", function(nt)
		nt.run.run()
	end), { desc = "Run nearest test." })
	map("n", "<leader>ts", safe("neotest", function(nt)
		nt.summary.toggle()
	end), { desc = "Toggle test summary." })
	map("n", "<leader>tS", safe("neotest", function(nt)
		nt.run.stop()
	end), { desc = "Stop running test." })
	map("n", "<leader>tD", safe("neotest", function(nt)
		---@diagnostic disable-next-line: missing-fields
		nt.run.run({ strategy = "dap" })
	end), { desc = "Debug nearest test." })
end

--- Trouble
wk_add_group("<leader>x", "Trouble...")
map("n", "<leader>xb", "<CMD>Trouble diagnostics toggle filter.buf=0<CR>", { desc = "Diagnostics (buffer)" })
map("n", "<leader>xq", "<CMD>Trouble qflist toggle<CR>", { desc = "Quickfix" })
map("n", "<leader>xs", "<CMD>Trouble symbols toggle<CR>", { desc = "Symbols" })
map("n", "<leader>xt", "<CMD>Trouble todo<CR>", { desc = "Todo comments" })
map("n", "<leader>xx", "<CMD>Trouble diagnostics toggle<CR>", { desc = "Diagnostics (project)" })
