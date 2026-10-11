local map = vim.keymap.set

--- Dap Keys (Leaderless F-keys)
if not vim.g.is_server then
	map("n", "<F8>", function()
		require("dap").continue()
	end, { desc = "DAP: Continue" })
	map("n", "<F9>", function()
		require("dap").step_over()
	end, { desc = "DAP: Step over" })
	map("n", "<F10>", function()
		require("dap").step_into()
	end, { desc = "DAP: Step into" })
	map("n", "<F11>", function()
		require("dap").step_out()
	end, { desc = "DAP: Step out" })
end

--- Normal / Visual Movement (wrapped lines awareness)
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true })
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true })

--- Alt + (Indentation and line moving)
map("n", "<A-h>", "<h", { desc = "Decrease indentation on line." })
map("v", "<A-h>", "<gv", { desc = "Decrease indentation on line." })
map("n", "<A-j>", "<CMD>execute 'move .+' . v:count1<CR>==", { desc = "Move line down" })
map("v", "<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<CR>gv=gv", { desc = "Move line down" })
map("i", "<A-j>", "<esc><CMD>m .+1<CR>==gi", { desc = "Move line down" })
map("n", "<A-k>", "<CMD>execute 'move .-' . (v:count1 + 1)<CR>==", { desc = "Move line up" })
map("v", "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<CR>gv=gv", { desc = "Move line up" })
map("i", "<A-k>", "<esc><CMD>m .-2<CR>==gi", { desc = "Move line up" })
map("n", "<A-l>", ">l", { desc = "Increase indentation on line." })
map("v", "<A-l>", ">gv", { desc = "Increase indentation on line." })

--- Control +
map("n", "<C-/>", function()
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
map("t", "<C-/>", "<C-\\><C-n><C-w>k", { desc = "Exit Terminal." })
map("n", "<C-BS>", "<CMD>noh<CR>", { desc = "Clear Search" })

--- Window Navigation
map("n", "<C-h>", "<C-w>h", { desc = "Navigate to Left Window." })
map("n", "<C-j>", "<C-w>j", { desc = "Navigate Down a Window." })
map("n", "<C-k>", "<C-w>k", { desc = "Navigate Up a Window." })
map("n", "<C-l>", "<C-w>l", { desc = "Navigate to Right Window." })

map("t", "<C-h>", "<C-\\><C-n><C-w>h", { desc = "Navigate to Left Window." })
map("t", "<C-j>", "<C-\\><C-n><C-w>j", { desc = "Navigate Down a Window." })
map("t", "<C-k>", "<C-\\><C-n><C-w>k", { desc = "Navigate Up a Window." })
map("t", "<C-l>", "<C-\\><C-n><C-w>l", { desc = "Navigate to Right Window." })

--- Control + Alt + (Window Resizing)
map("n", "<C-A-h>", "<CMD>vertical resize -15<CR>", { desc = "Decrease vertical split size." })
map("n", "<C-A-j>", "<CMD>horizontal resize -1<CR>", { desc = "Decrease horizontal split size." })
map("n", "<C-A-k>", "<CMD>horizontal resize +1<CR>", { desc = "Increase horizontal split size." })
map("n", "<C-A-l>", "<CMD>vertical resize +15<CR>", { desc = "Increase vertical split size." })

--- Control + Shift + (BufferLine move)
map("n", "<C-S-l>", "<CMD>BufferLineMoveNext<CR>", { desc = "Move buffer right." })
map("n", "<C-S-h>", "<CMD>BufferLineMovePrev<CR>", { desc = "Move buffer left." })

--- Shift + (BufferLine cycling)
map("n", "<S-h>", "<CMD>BufferLineCyclePrev<CR>", { desc = "Prev Buffer" })
map("n", "<S-l>", "<CMD>BufferLineCycleNext<CR>", { desc = "Next Buffer" })
