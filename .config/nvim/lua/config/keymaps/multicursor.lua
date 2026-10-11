local safe = require("config.keymaps.util").safe
local map = vim.keymap.set

local function mc_call(action, ...)
	local args = { ... }
	return safe("multicursor-nvim", function(mc)
		mc[action](unpack(args))
	end)
end

map({ "n", "x" }, "<C-n>", mc_call("matchAddCursor", 1), { desc = "Multicursor: Add next match" })
map({ "n", "x" }, "<C-s>", mc_call("matchSkipCursor", 1), { desc = "Multicursor: Skip next match" })
map({ "n", "x" }, "<C-p>", mc_call("matchAddCursor", -1), { desc = "Multicursor: Add previous match" })

map({ "n", "x" }, "<Up>", mc_call("lineAddCursor", -1), { desc = "Multicursor: Add cursor above" })
map({ "n", "x" }, "<Down>", mc_call("lineAddCursor", 1), { desc = "Multicursor: Add cursor below" })

map({ "n", "x" }, "<C-a>", mc_call("matchAllAddCursors"), { desc = "Multicursor: Add all matches" })

-- Safe Esc handling: clear multicursors first, re-enable if paused, or clear search highlighting
map("n", "<Esc>", function()
	local ok, mc = pcall(require, "multicursor-nvim")
	if ok and mc.hasCursors() then
		mc.clearCursors()
	elseif ok and not mc.cursorsEnabled() then
		mc.enableCursors()
	else
		vim.cmd("nohlsearch")
	end
end, { desc = "Multicursor: Clear cursors / hlsearch" })
