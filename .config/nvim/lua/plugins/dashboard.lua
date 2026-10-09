return {
	{
		"nvim-mini/mini.starter",
		enabled = true,
		event = "VimEnter",
		config = function()
			local starter = require("mini.starter")
			local statusLine = "Loading..."

			local function pick_files()
				local ok, fzf = pcall(require, "fzf-lua")
				if ok then
					fzf.files()
				else
					vim.notify("fzf-lua is not installed", vim.log.levels.WARN)
				end
			end

			local function pick_grep()
				local ok, fzf = pcall(require, "fzf-lua")
				if ok then
					fzf.live_grep()
				else
					vim.notify("fzf-lua is not installed", vim.log.levels.WARN)
				end
			end

			local function open_config()
				vim.cmd("cd " .. vim.fn.stdpath("config"))
				vim.cmd("edit ./init.lua")
			end

			local function new_file()
				vim.cmd("enew")
			end

			local function quit_nvim()
				vim.cmd("qa!")
			end

			starter.setup({
				evaluate_single = true,

				header = [[
󰓎 NeoVim is Ready, Are you? 󰓎
     Let's Code it Out!    
]],
				items = {
					{
						name = "Find files",
						action = pick_files,
						section = "Actions",
					},
					{
						name = "Search files",
						action = pick_grep,
						section = "Actions",
					},
					{
						name = "New file",
						action = new_file,
						section = "Actions",
					},
					{
						name = "Open Configs",
						action = open_config,
						section = "Actions",
					},
					{
						name = "Quit NeoVim",
						action = quit_nvim,
						section = "Actions",
					},
				},
				footer = function()
					return statusLine
				end,

				content_hooks = {
					starter.gen_hook.adding_bullet("󰧛 "),
					starter.gen_hook.aligning("center", "center"),
				},
			})

			vim.api.nvim_create_autocmd("User", {
				pattern = "MiniStarterOpened",
				callback = function(args)
					local opts = { buffer = args.buf, silent = true }
					vim.keymap.set("n", "j", function()
						starter.update_current_item("next")
					end, opts)
					vim.keymap.set("n", "k", function()
						starter.update_current_item("prev")
					end, opts)
				end,
			})

			vim.api.nvim_create_autocmd("User", {
				pattern = "VeryLazy",
				once = true,
				callback = function()
					local stats = require("lazy").stats()
					local ms = math.floor(stats.startuptime * 100 + 0.5) / 100
					statusLine = string.format("%d/%d plugins 󰄉 %sms", stats.loaded, stats.count, ms)
					if vim.bo.filetype == "ministarter" then
						starter.refresh()
					end
				end,
			})
		end,
	},
}

