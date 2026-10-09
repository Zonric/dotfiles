--- Add a group key to which-key function ---
local function wk_add_group(prefix, name)
	local ok, wk = pcall(require, "which-key")
	if ok then
		wk.add({ prefix, group = name })
	end
end

--- LEADERLESS KEYS ---
--- Dap Keys
if not vim.g.is_server then
	vim.keymap.set("n", "<F8>", function()
		require("dap").continue()
	end)
	vim.keymap.set("n", "<F9>", function()
		require("dap").step_over()
	end)
	vim.keymap.set("n", "<F10>", function()
		require("dap").step_into()
	end)
	vim.keymap.set("n", "<F11>", function()
		require("dap").step_out()
	end)
end

-- Navigation
vim.keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true })
vim.keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true })
-- LSP
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition." })
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration." })
vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Go to references." })
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to Implementation." })
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Display LSP hover info." })

-- Square bracket keys
vim.keymap.set("n", "]d", function()
	vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Next diagnostic" })
vim.keymap.set("n", "[d", function()
	vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Prev diagnostic" })
vim.keymap.set("n", "]h", function()
	require("gitsigns").nav_hunk("next")
end, { desc = "Next git hunk" })
vim.keymap.set("n", "[h", function()
	require("gitsigns").nav_hunk("prev")
end, { desc = "Prev git hunk" })
vim.keymap.set("n", "]t", function()
	require("todo-comments").jump_next()
end, { desc = "Next todo comment" })
vim.keymap.set("n", "[t", function()
	require("todo-comments").jump_prev()
end, { desc = "Prev todo comment" })

--- Alt +
vim.keymap.set("n", "<A-h>", "<h", { desc = "Decrease indentation on line." })
vim.keymap.set("v", "<A-h>", "<gv", { desc = "Decrease indentation on line." })
vim.keymap.set("n", "<A-j>", "<CMD>execute 'move .+' . v:count1<CR>==", { desc = "Move line down" })
vim.keymap.set("v", "<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<CR>gv=gv", { desc = "Move line down" })
vim.keymap.set("i", "<A-j>", "<esc><CMD>m .+1<CR>==gi", { desc = "Move line down" })
vim.keymap.set("n", "<A-k>", "<CMD>execute 'move .-' . (v:count1 + 1)<CR>==", { desc = "Move line up" })
vim.keymap.set("v", "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<CR>gv=gv", { desc = "Move line up" })
vim.keymap.set("i", "<A-k>", "<esc><CMD>m .-2<CR>==gi", { desc = "Move line up" })
vim.keymap.set("n", "<A-l>", ">l", { desc = "Increase indentation on line." })
vim.keymap.set("v", "<A-l>", ">gv", { desc = "Increase indentation on line." })

--- Control +
vim.keymap.set("n", "<C-/>", function()
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		local buf = vim.api.nvim_win_get_buf(win)
		if vim.bo[buf].buftype == "terminal" then
			vim.api.nvim_set_current_win(win)
			vim.cmd("startinsert")
			return
		end
	end
	vim.cmd("botright split")
	vim.api.nvim_win_set_height(0, math.floor(vim.o.lines * 0.35))
	vim.cmd("term")
	vim.cmd("startinsert")
end, { desc = "Open Terminal." })
vim.keymap.set("t", "<C-/>", "<C-\\><C-n><C-w>k", { desc = "Exit Terminal." })
vim.keymap.set("n", "<C-BS>", "<CMD>noh<CR>", { desc = "Clear Search" })

vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Navigate to Left Window." })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Navigate Down a Window." })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Navigate Up a Window." })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Navigate to Right Window." })

vim.keymap.set("t", "<C-h>", "<C-\\><C-n><C-w>h", { desc = "Navigate to Left Window." })
vim.keymap.set("t", "<C-j>", "<C-\\><C-n><C-w>j", { desc = "Navigate Down a Window." })
vim.keymap.set("t", "<C-k>", "<C-\\><C-n><C-w>k", { desc = "Navigate Up a Window." })
vim.keymap.set("t", "<C-l>", "<C-\\><C-n><C-w>l", { desc = "Navigate to Right Window." })

vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, { desc = "Display signature helper." })

-- LuaSnip Jumpable
vim.keymap.set({ "i", "s" }, "<C-h>", function()
	if require("luasnip").jumpable(-1) then
		require("luasnip").jump(-1)
	end
end, { silent = true, desc = "Jump backward (snip)" })
vim.keymap.set({ "i", "s" }, "<C-l>", function()
	if require("luasnip").expand_or_jumpable() then
		require("luasnip").expand_or_jump()
	end
end, { silent = true, desc = "Jump forward (snip)" })

-- LuaSnip choice cycles
vim.keymap.set({ "i", "s" }, "<C-n>", function()
	if require("luasnip").choice_active() then
		require("luasnip").change_choice(1)
	end
end, { silent = true, desc = "Cycle Choice forward (snip)" })
vim.keymap.set({ "i", "s" }, "<C-p>", function()
	if require("luasnip").choice_active() then
		require("luasnip").change_choice(-1)
	end
end, { silent = true, desc = "Cycle Choice forward (snip)" })

--- Control + Alt +
vim.keymap.set("n", "<C-A-h>", "<CMD>vertical resize -15<CR>", { desc = "Decrease vertical split size." })
vim.keymap.set("n", "<C-A-j>", "<CMD>horizontal resize -1<CR>", { desc = "Decrease horizontal split size." })
vim.keymap.set("n", "<C-A-k>", "<CMD>horizontal resize +1<CR>", { desc = "Increase horizontal split size." })
vim.keymap.set("n", "<C-A-l>", "<CMD>vertical resize +15<CR>", { desc = "Increase vertical split size." })

--- Control + Shift +
vim.keymap.set("n", "<C-S-L>", "<CMD>BufferLineMoveNext<CR>", { desc = "Move buffer right." })
vim.keymap.set("n", "<C-S-h>", "<CMD>BufferLineMovePrev<CR>", { desc = "Move buffer left." })

--- Shift +
vim.keymap.set("n", "<S-h>", "<CMD>BufferLineCyclePrev<CR>", { desc = "Prev Buffer" })
vim.keymap.set("n", "<S-l>", "<CMD>BufferLineCycleNext<CR>", { desc = "Next Buffer" })

--- LEADER KEYS ---
vim.keymap.set("n", "<leader>\\", function()
	require("nvim-tree.api").tree.toggle({ focus = true })
end, { desc = "File Tree" })

vim.api.nvim_create_user_command("CodeCompanionCLIToggle", function()
	require("codecompanion").toggle_cli()
end, { desc = "Toggle CodeCompanion CLI terminal." })

wk_add_group("<leader>a", "AI / Antigravity...")
vim.keymap.set({ "n", "v" }, "<leader>aa", "<CMD>CodeCompanionActions<CR>", { desc = "Action palette." })
vim.keymap.set({ "n", "v" }, "<leader>ac", "<CMD>CodeCompanionChat Toggle<CR>", { desc = "Toggle chat." })
vim.keymap.set({ "n", "v" }, "<leader>ai", "<CMD>CodeCompanion<CR>", { desc = "Inline assistant." })
vim.keymap.set({ "n", "v" }, "<leader>at", function()
	require("codecompanion").toggle_cli()
end, { desc = "Toggle Antigravity CLI terminal." })
vim.keymap.set({ "n", "v" }, "<leader>ap", "<CMD>CodeCompanionCLI Ask<CR>", { desc = "CLI prompt input." })
vim.keymap.set("v", "<leader>as", function()
	local start_pos = vim.fn.getpos("'<")
	local end_pos = vim.fn.getpos("'>")
	local lines = vim.api.nvim_buf_get_lines(0, start_pos[2] - 1, end_pos[2], false)
	require("config.agents").speak(table.concat(lines, " "))
end, { desc = "TTS Speak visual selection." })
vim.keymap.set("n", "<leader>as", function()
	local line = vim.api.nvim_get_current_line()
	require("config.agents").speak(line)
end, { desc = "TTS Speak current line." })
vim.keymap.set("n", "<leader>aX", function()
	require("config.agents").stop_speaking()
end, { desc = "TTS Stop speaking." })

wk_add_group("<leader>b", "Buffers...")
vim.keymap.set("n", "<leader>bd", "<CMD>bp|bd#<CR>", { desc = "delete current." })

wk_add_group("<leader>c", "Code...")
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "actions." })
vim.keymap.set("n", "<leader>cc", "<CMD>CodeCopy<CR>", { desc = "Copy." })
vim.keymap.set({ "n", "v" }, "<leader>cf", function()
	require("conform").format({ lsp_fallback = true, async = false, timeout_ms = 500 })
end, { desc = "Format buffer/selection." })
vim.keymap.set("n", "<leader>cu", "<CMD>CodeCopy open ui<CR>", { desc = "Open CC UI." })
vim.keymap.set("n", "<leader>ce", vim.diagnostic.open_float, { desc = "diagnostics." })
vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Rename symbol." })
vim.keymap.set("n", "<leader>ch", function()
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = 0 }), { bufnr = 0 })
end, { desc = "Toggle Inlay Hints." })

if not vim.g.is_server then
	wk_add_group("<leader>d", "Debug / Data...")
	vim.keymap.set("n", "<leader>db", function()
		require("dap").toggle_breakpoint()
	end, { desc = "Set Breakpoint." })
	vim.keymap.set("n", "<leader>dB", function()
		require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
	end, { desc = "Conditional Breakpoint." })
	vim.keymap.set("n", "<leader>dc", function()
		require("dap").continue()
	end, { desc = "Start/Continue" })
	vim.keymap.set("n", "<leader>di", function()
		require("dap").step_into()
	end, { desc = "Step Into" })
	vim.keymap.set("n", "<leader>dn", function()
		require("dap").step_over()
	end, { desc = "Step Over" })
	vim.keymap.set("n", "<leader>do", function()
		require("dap").step_out()
	end, { desc = "Step Out" })
	vim.keymap.set("n", "<leader>dq", function()
		require("dap").terminate()
	end, { desc = "Terminate" })
	vim.keymap.set("n", "<leader>dr", function()
		require("dapui").open({ reset = true })
	end, { desc = "Open Repl" })
	vim.keymap.set("n", "<leader>du", function()
		require("dapui").toggle()
	end, { desc = "Toggle DAP UI" })

	wk_add_group("<leader>dd", "Database...")
	vim.keymap.set("n", "<leader>ddu", "<CMD>DBUIToggle<CR>", { desc = "Toggle DB UI." })
	vim.keymap.set("n", "<leader>ddf", "<CMD>DBUIFindBuffer<CR>", { desc = "Find DB buffer." })
	vim.keymap.set("n", "<leader>ddr", "<CMD>DBUIRenameBuffer<CR>", { desc = "Rename DB buffer." })
	vim.keymap.set("n", "<leader>ddl", "<CMD>DBUILastQueryInfo<CR>", { desc = "Last query info." })
end

vim.keymap.set("n", "<leader>e", function()
	if not require("mini.files").close() then
		require("mini.files").open()
	end
end, { desc = "File Explorer" })

wk_add_group("<leader>f", "Find...")
vim.keymap.set("n", "<leader>fb", function()
	require("fzf-lua").buffers()
end, { desc = "Buffers." })
vim.keymap.set("n", "<leader>fd", function()
	require("fzf-lua").diagnostics_document()
end, { desc = "Diagnostic." })
vim.keymap.set("n", "<leader>ff", function()
	require("fzf-lua").files()
end, { desc = "Files." })
vim.keymap.set("n", "<leader>fh", function()
	require("fzf-lua").help_tags()
end, { desc = "Help Tags." })
vim.keymap.set("n", "<leader>fk", function()
	require("fzf-lua").keymaps()
end, { desc = "Keymaps." })
vim.keymap.set("n", "<leader>fm", function()
	require("fzf-lua").manpages()
end, { desc = "Man Pages." })
vim.keymap.set("n", "<leader>fr", function()
	require("fzf-lua").lsp_references()
end, { desc = "LSP References." })
vim.keymap.set("n", "<leader>fs", function()
	require("fzf-lua").lsp_document_symbols()
end, { desc = "LSP Symborls." })

wk_add_group("<leader>g", "Git...")
vim.keymap.set("n", "<leader>gb", function()
	require("fzf-lua").git_branches()
end, { desc = "Branches." })
vim.keymap.set("n", "<leader>gB", function()
	require("fzf-lua").git_blame()
end, { desc = "Blame." })
vim.keymap.set("n", "<leader>gc", function()
	require("fzf-lua").git_commits()
end, { desc = "Commit logs." })
vim.keymap.set("n", "<leader>gd", "<CMD>DiffviewOpen<CR>", { desc = "Diffview Open." })
vim.keymap.set("n", "<leader>gD", "<CMD>DiffviewClose<CR>", { desc = "Diffview Close." })
vim.keymap.set("n", "<leader>gf", function()
	require("fzf-lua").git_diff()
end, { desc = "Diff files (fzf)." })
vim.keymap.set("n", "<leader>gs", function()
	require("fzf-lua").git_status()
end, { desc = "Status." })
vim.keymap.set("n", "<leader>gl", "<CMD>LazyGit<CR>", { desc = "LazyGit." })
vim.keymap.set("n", "<leader>gp", function()
	require("gitsigns").preview_hunk()
end, { desc = "Preview hunk." })

wk_add_group("<leader>gh", "Hunk...")
vim.keymap.set("n", "<leader>ghs", function()
	require("gitsigns").stage_hunk()
end, { desc = "Stage hunk." })
vim.keymap.set("n", "<leader>ghr", function()
	require("gitsigns").reset_hunk()
end, { desc = "Reset hunk." })
vim.keymap.set("n", "<leader>ghu", function()
	require("gitsigns").stage_hunk()
end, { desc = "Undo / toggle stage hunk." })
vim.keymap.set("v", "<leader>ghs", function()
	require("gitsigns").stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
end, { desc = "Stage selected hunk." })
vim.keymap.set("v", "<leader>ghr", function()
	require("gitsigns").reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
end, { desc = "Reset selected hunk." })

--- Project Session Management (with Shadow Buffers) ---
local function get_session_dir()
	local cwd = vim.fn.getcwd()
	local hash = vim.fn.sha256(cwd):sub(1, 12)
	local name = vim.fn.fnamemodify(cwd, ":t")
	if name == "" then
		name = "root"
	end
	local dir = vim.fn.stdpath("state") .. "/sessions/" .. name .. "_" .. hash
	vim.fn.mkdir(dir .. "/dirty", "p")
	return dir
end

local function save_project_session(and_quit)
	local dir = get_session_dir()
	local session_file = dir .. "/session.vim"

	-- Clear out previous dirty shadow files
	local old_dirty = vim.fn.glob(dir .. "/dirty/*", true, true)
	for _, f in ipairs(old_dirty) do
		vim.fn.delete(f)
	end

	-- Save snapshots of all unwritten/modified file buffers
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].modified and vim.bo[buf].buftype == "" then
			local bname = vim.api.nvim_buf_get_name(buf)
			if bname ~= "" and vim.fn.filereadable(bname) == 1 then
				local bhash = vim.fn.sha256(bname):sub(1, 12)
				local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
				vim.fn.writefile(lines, dir .. "/dirty/" .. bhash)
			end
		end
	end

	-- Save native Vim session layout
	vim.cmd("mksession! " .. vim.fn.fnameescape(session_file))

	if and_quit then
		vim.cmd("qa!")
	else
		vim.notify("Project session saved: " .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t"), vim.log.levels.INFO)
	end
end

local function restore_project_session()
	local dir = get_session_dir()
	local session_file = dir .. "/session.vim"

	if vim.fn.filereadable(session_file) ~= 1 then
		vim.notify(
			"No saved session for current project: " .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t"),
			vim.log.levels.WARN
		)
		return
	end

	-- Wipe existing scratch buffers cleanly before restoring layout
	vim.cmd("silent! %bd!")
	vim.cmd("source " .. vim.fn.fnameescape(session_file))

	-- Restore modified buffer states from dirty shadow snapshots
	local restored_dirty = 0
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buftype == "" then
			local bname = vim.api.nvim_buf_get_name(buf)
			if bname ~= "" then
				local bhash = vim.fn.sha256(bname):sub(1, 12)
				local dirty_file = dir .. "/dirty/" .. bhash
				if vim.fn.filereadable(dirty_file) == 1 then
					local lines = vim.fn.readfile(dirty_file)
					vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
					vim.bo[buf].modified = true
					restored_dirty = restored_dirty + 1
				end
			end
		end
	end

	local msg = "Restored session for " .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
	if restored_dirty > 0 then
		msg = msg .. " (" .. restored_dirty .. " dirty buffer" .. (restored_dirty > 1 and "s" or "") .. " preserved)"
	end
	vim.notify(msg, vim.log.levels.INFO)
end

local function delete_project_session()
	local dir = get_session_dir()
	local session_file = dir .. "/session.vim"
	if vim.fn.filereadable(session_file) == 1 then
		vim.fn.delete(dir, "rf")
		vim.notify("Deleted session for " .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t"), vim.log.levels.INFO)
	else
		vim.notify("No session found to delete.", vim.log.levels.INFO)
	end
end

wk_add_group("<leader>q", "Quit / Session...")
vim.keymap.set("n", "<leader>qq", function()
	save_project_session(true)
end, { desc = "Save project session & quit." })

vim.keymap.set("n", "<leader>qs", function()
	save_project_session(false)
end, { desc = "Save project session." })

vim.keymap.set("n", "<leader>qr", function()
	restore_project_session()
end, { desc = "Restore project session." })

vim.keymap.set("n", "<leader>qd", function()
	delete_project_session()
end, { desc = "Delete project session." })

local rust_group = vim.api.nvim_create_augroup("RustKeymaps", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	pattern = "rust",
	group = rust_group,
	callback = function(ev)
		local wk_ok, wk = pcall(require, "which-key")
		if wk_ok then
			wk.add({ "<leader>r", group = "Rust...", buffer = ev.buf })
		end

		local map = function(keys, cmd, desc)
			vim.keymap.set("n", keys, function()
				vim.cmd.RustLsp(cmd)
			end, { buffer = ev.buf, desc = desc })
		end

		map("<leader>rr", "runnables", "Pick and run, rust bin or tests.")
		map("<leader>rd", "debuggables", "Direct bridge into DAP")
		map("<leader>rt", "testables", "Select unit/integration test.")
		map("<leader>rm", "expandMacro", "Expand declarative/procedural macros.")
		map("<leader>rc", "openCargo", "Jump to project's Cargo.toml")
		map("<leader>rp", "parentModule", "Navigate upward to parent mod or lib .rs.")
		map("<leader>re", "explainError", "Open 'rustc --explain' docs")
		map("<leader>rg", { "crateGraph", "[backend]", "[output]" }, "Visualize module/crate dependencies.")
	end,
})

if not vim.g.is_server then
	wk_add_group("<leader>p", "Packages...")
	vim.keymap.set("n", "<leader>pt", function()
		require("package-info").toggle()
	end, { desc = "Toggle package versions." })
	vim.keymap.set("n", "<leader>pu", function()
		require("package-info").update()
	end, { desc = "Update package." })
	vim.keymap.set("n", "<leader>pd", function()
		require("package-info").delete()
	end, { desc = "Delete package." })
	vim.keymap.set("n", "<leader>pi", function()
		require("package-info").install()
	end, { desc = "Install package." })
	vim.keymap.set("n", "<leader>pc", function()
		require("package-info").change_version()
	end, { desc = "Change package version." })

	-- Crates.nvim keymaps for Cargo.toml
	vim.api.nvim_create_autocmd("BufRead", {
		pattern = "Cargo.toml",
		callback = function(ev)
			local ok, crates = pcall(require, "crates")
			if not ok then
				return
			end
			local map = function(keys, fn, desc)
				vim.keymap.set("n", keys, fn, { buffer = ev.buf, desc = desc })
			end
			map("<leader>pt", crates.toggle, "Toggle crates info.")
			map("<leader>pu", crates.update_crate, "Update crate.")
			map("<leader>pd", crates.show_dependencies_popup, "Dependencies popup.")
			map("<leader>pf", crates.show_features_popup, "Features popup.")
			map("<leader>pv", crates.show_versions_popup, "Versions popup.")
		end,
	})
end

wk_add_group("<leader>s", "Search...")
vim.keymap.set("n", "<leader>sb", function()
	require("fzf-lua").lgrep_curbuf()
end, { desc = "current Buffer" })
vim.keymap.set("n", "<leader>sf", function()
	require("fzf-lua").live_grep()
end, { desc = "Files." })
vim.keymap.set("n", "<leader>sk", function()
	require("fzf-lua").keymaps()
end, { desc = "Keymaps." })
vim.keymap.set("n", "<leader>st", "<CMD>TodoFzfLua<CR>", { desc = "Todo comments" })
vim.keymap.set("n", "<leader>sw", function()
	require("fzf-lua").grep_cword()
end, { desc = "Word under cursor." })

if not vim.g.is_server then
	wk_add_group("<leader>t", "Test...")
	vim.keymap.set("n", "<leader>td", function()
		require("neotest").run.run(vim.fn.expand("%:p:h"))
	end, { desc = "Run directory tests." })
	vim.keymap.set("n", "<leader>tf", function()
		require("neotest").run.run(vim.fn.expand("%"))
	end, { desc = "Run file tests." })
	vim.keymap.set("n", "<leader>tl", function()
		require("neotest").run.run_last()
	end, { desc = "Run last test." })
	vim.keymap.set("n", "<leader>to", function()
		require("neotest").output.open({ enter = true })
	end, { desc = "Open test output." })
	vim.keymap.set("n", "<leader>tr", function()
		require("neotest").run.run()
	end, { desc = "Run nearest test." })
	vim.keymap.set("n", "<leader>ts", function()
		require("neotest").summary.toggle()
	end, { desc = "Toggle test summary." })
	vim.keymap.set("n", "<leader>tS", function()
		require("neotest").run.stop()
	end, { desc = "Stop running test." })
	vim.keymap.set("n", "<leader>tD", function()
		---@diagnostic disable-next-line: missing-fields
		require("neotest").run.run({ strategy = "dap" })
	end, { desc = "Debug nearest test." })
end

wk_add_group("<leader>x", "Trouble...")
vim.keymap.set("n", "<leader>xb", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Diagnostics (buffer)" })
vim.keymap.set("n", "<leader>xq", "<cmd>Trouble qflist toggle<cr>", { desc = "Quickfix" })
vim.keymap.set("n", "<leader>xs", "<cmd>Trouble symbols toggle<cr>", { desc = "Symbols" })
vim.keymap.set("n", "<leader>xt", "<cmd>Trouble todo<cr>", { desc = "Todo comments" })
vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (project)" })
