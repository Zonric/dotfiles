local safe = require("config.keymaps.util").safe
local wk_add_group = require("config.keymaps.util").wk_add_group
local map = vim.keymap.set

wk_add_group("<leader>n", "Notes / Brain...")

--- Helper to run a zk command safely, ensuring builtin commands are loaded
local function zk_cmd(cmd_name, default_opts)
	return safe("zk", function(zk)
		require("zk.commands.builtin")
		local fn = require("zk.commands").get(cmd_name)
		if fn then
			return fn(default_opts)
		end
	end)
end

--- New permanent note (prompts for title)
map("n", "<leader>nn", safe("zk", function(zk)
	local title = vim.fn.input("Note Title: ")
	if title ~= "" then
		zk.new({ title = title, dir = "permanent", notebook_path = vim.fn.expand("~/notes") })
	end
end), { desc = "New permanent note" })

--- Daily note / capture in 00-inbox
map("n", "<leader>nd", safe("zk", function(zk)
	zk.new({ dir = "00-inbox", group = "daily", notebook_path = vim.fn.expand("~/notes") })
end), { desc = "Daily note / Today" })

--- Find notes by title (fzf-lua directly targeting ~/notes)
map("n", "<leader>nf", safe("fzf-lua", function(fzf)
	fzf.files({ cwd = vim.fn.expand("~/notes"), prompt = "Notes > " })
end), { desc = "Find notes" })

--- Search note text content (fzf-lua live grep in ~/notes)
map("n", "<leader>ns", safe("fzf-lua", function(fzf)
	fzf.live_grep({ cwd = vim.fn.expand("~/notes"), prompt = "Notes Grep > " })
end), { desc = "Grep notes" })

--- Find by tags (fzf-lua via zk)
map("n", "<leader>nt", zk_cmd("ZkTags"), { desc = "Browse note tags" })

--- Outgoing links from current note
map("n", "<leader>nl", zk_cmd("ZkLinks"), { desc = "Outgoing links" })

--- Backlinks pointing to current note
map("n", "<leader>nb", zk_cmd("ZkBacklinks"), { desc = "Backlinks to note" })

--- Visual mode: Insert link to selected text or create new linked note
map("v", "<leader>nl", function()
	pcall(require, "zk")
	require("zk.commands.builtin")
	local fn = require("zk.commands").get("ZkInsertLinkAtSelection")
	if fn then
		fn()
	end
end, { desc = "Link selection to note" })

map("v", "<leader>nn", function()
	pcall(require, "zk")
	require("zk.commands.builtin")
	local fn = require("zk.commands").get("ZkNewFromTitleSelection")
	if fn then
		fn({ dir = "permanent" })
	end
end, { desc = "New note from selection" })
