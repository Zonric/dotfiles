return {
	{
		"nvim-tree/nvim-tree.lua",
		enabled = true,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		opts = {
			view = { width = 30 },
			filters = {
				dotfiles = false,
				git_ignored = false,
				custom = { "_templ\\.go$" },
			},
		},
	},
	{
		"nvim-mini/mini.files",
		enabled = true,
		lazy = true,
		opts = {
			mappings = {
				close = "q",
				go_in = "l",
				go_in_plus = "<CR>",
				go_out = "h",
				go_out_plus = "<BS>",
				mark_goto = "'",
				mark_set = "m",
				reset = "R",
				reveal_cwd = "@",
				show_help = "g?",
				synchronize = "=",
				trim_left = "<",
				trim_right = ">",
			},
		},
	},
	{
		"rcarriga/nvim-notify",
		enabled = true,
		config = function()
			vim.notify = require("notify")
		end,
	},
	{
		"nvim-mini/mini.indentscope",
		version = false,
		enabled = true,
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			symbol = "│",
			options = { try_as_border = true },
			draw = {
				delay = 50,
			},
		},
	},
	{
		"akinsho/bufferline.nvim",
		enabled = true,
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {},
	},
	{
		"nvim-lualine/lualine.nvim",
		enabled = true,
		opts = function()
			return require("config.statusline").setup()
		end,
	},
	{
		"folke/which-key.nvim",
		enabled = true,
		lazy = true,
		event = "VeryLazy",
		opts = {},
	},
	{
		"ibhagwan/fzf-lua",
		enabled = true,
		lazy = true,
		event = "VeryLazy",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("fzf-lua").register_ui_select()
		end,
	},
	{
		"folke/todo-comments.nvim",
		enabled = true,
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
	},
	{
		"brenoprata10/nvim-highlight-colors",
		enabled = true,
		event = "BufReadPre",
		opts = {
			render = "background",
			enable_named_colors = true,
		},
	},
	{
		"nvim-mini/mini.cursorword",
		version = false,
		enabled = true,
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			delay = 100,
		},
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		enabled = not vim.g.is_server,
		lazy = true,
		ft = { "markdown" },
		cmd = "RenderMarkdown",
		opts = {},
	},
	{
		"mbbill/undotree",
		enabled = true,
		cmd = "UndotreeToggle",
		keys = {
			{ "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "Toggle Undotree" },
		},
	},
}
