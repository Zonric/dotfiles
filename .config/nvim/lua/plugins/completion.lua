return {
	{
		"saghen/blink.cmp",
		enabled = true,
		dependencies = {
			"saghen/blink.lib",
			{
				"L3MON4D3/LuaSnip",
				config = function()
					local luasnip = require("luasnip")
					luasnip.filetype_extend("cpp", { "c" })
					luasnip.filetype_extend("templ", { "html" })
					luasnip.filetype_extend("typescriptreact", { "typescript", "javascriptreact", "javascript" })
					luasnip.filetype_extend("javascriptreact", { "javascript" })
					require("luasnip.loaders.from_lua").load({ paths = vim.fn.stdpath("config") .. "/snippets" })
				end,
			},
			"zonric/blink-nerdfont.nvim",
			"zonric/blink-emoji.nvim",
		},
		build = function()
			---@diagnostic disable-next-line: undefined-field
			require("blink.cmp").build():pwait()
		end,
		opts = {
			keymap = { preset = "default" },
			completion = {
				menu = {
					draw = {
						columns = {
							{ "kind_icon" },
							{ "label", "label_description", gap = 1 },
							{ "source_name" },
						},
					},
				},
				documentation = {
					auto_show = false,
				},
				ghost_text = { enabled = false },
			},
			snippets = {
				preset = "luasnip",
			},
			sources = {
				default = {
					"lsp",
					"path",
					"buffer",
					"snippets",
					"nerdfont",
					"emoji",
				},
				per_filetype = {
					sql = { "dadbod", "snippets", "buffer" },
					mysql = { "dadbod", "snippets", "buffer" },
					plsql = { "dadbod", "snippets", "buffer" },
					codecompanion = { "codecompanion" },
					codecompanion_input = { "codecompanion" },
				},
				providers = {
					lsp = { name = "LSP" },
					buffer = { name = "Buf" },
					path = { name = "Path" },
					snippets = { name = "Snip" },
					dadbod = {
						name = "Dadbod",
						module = "vim_dadbod_completion.blink",
						score_offset = 85,
					},
					nerdfont = {
						module = "blink-nerdfont",
						name = "NerdFont",
						score_offset = 15,
						opts = { insert = true, trigger = ":!" },
					},
					emoji = {
						module = "blink-emoji",
						name = "Emoji",
						score_offset = 15,
						opts = { insert = true, trigger = ":@" },
					},
				},
			},
			fuzzy = {
				implementation = "rust",
				sorts = {
					"exact",
					"score",
					"sort_text",
				},
			},
			signature = {
				enabled = true,
				window = { border = "rounded" },
			},
		},
	},
}
