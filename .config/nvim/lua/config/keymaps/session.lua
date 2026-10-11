local wk_add_group = require("config.keymaps.util").wk_add_group
local map = vim.keymap.set

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
map("n", "<leader>qq", function()
	save_project_session(true)
end, { desc = "Save project session & quit." })

map("n", "<leader>qs", function()
	save_project_session(false)
end, { desc = "Save project session." })

map("n", "<leader>qr", function()
	restore_project_session()
end, { desc = "Restore project session." })

map("n", "<leader>qd", function()
	delete_project_session()
end, { desc = "Delete project session." })
