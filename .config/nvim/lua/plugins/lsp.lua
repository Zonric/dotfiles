return {
	{
		"mrcjkb/rustaceanvim",
		version = "^5",
		enabled = true,
		lazy = false,
		config = function()
			vim.g.rustaceanvim = {
				server = {
					default_settings = {
						["rust-analyzer"] = {
							check = {
								command = "clippy",
							},
							inlayhints = {
								bindingModeHints = { enable = false },
								chainingHints = { enable = true },
								closingBraceHints = { enable = true },
								parameterHints = { enable = true },
								typeHints = { enable = true },
							},
						},
					},
				},
			}
		end,
	},
	{
		"mason-org/mason.nvim",
		enabled = true,
		cmd = "Mason",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"neovim/nvim-lspconfig",
		},
		opts = {},
		config = function()
			require("config.lsp").setup()
		end,
	},
	{
		"mason-org/mason-lspconfig.nvim",
		enabled = true,
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			ensure_installed = {
				"bashls",
				"cssls",
				"emmet_language_server",
				"eslint",
				"html",
				"intelephense",
				"laravel_ls",
				"lua_ls",
				"phpactor",
				"pyright",
				"templ",
				"ts_ls",
				"twiggy_language_server",
			},
			automatic_enable = true,
		},
	},
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				-- Load luvit types when the `vim.uv` word is found
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
}
