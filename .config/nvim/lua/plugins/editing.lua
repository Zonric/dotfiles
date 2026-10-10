return {
	{
		"jake-stewart/multicursor.nvim",
		branch = "1.0",
		enabled = true,
		lazy = true,
		opts = {},
	},
	{
		"windwp/nvim-autopairs",
		enabled = true,
		lazy = true,
		event = "InsertEnter",
		opts = {},
		config = function(_, opts)
			local npairs = require("nvim-autopairs")
			local Rule = require("nvim-autopairs.rule")

			npairs.setup(opts)
			npairs.add_rules({
				Rule(">[%w%s]*$", "^%s*</", { "templ" }):only_cr():use_regex(true),
			})
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		enabled = true,
		lazy = true,
		event = { "BufReadPre", "BufNewFile" },
		opts = {},
		config = function(_, opts)
			local autotag = require("nvim-ts-autotag")
			autotag.setup(opts)

			local TagConfigs = require("nvim-ts-autotag.config.init")
			local FiletypeConfig = require("nvim-ts-autotag.config.ft")

			local base_cfg = FiletypeConfig:extend(nil, {
				skip_tag_pattern = {
					"area",
					"base",
					"br",
					"col",
					"command",
					"embed",
					"hr",
					"img",
					"slot",
					"input",
					"keygen",
					"link",
					"meta",
					"param",
					"source",
					"track",
					"wbr",
					"menuitem",
				},
			})

			TagConfigs:add(base_cfg:extend("templ", {
				start_tag_pattern = { "tag_start" },
				start_name_tag_pattern = { "element_identifier", "name" },
				end_tag_pattern = { "tag_end" },
				end_name_tag_pattern = { "element_identifier", "name" },
				close_tag_pattern = { "tag_end" },
				close_name_tag_pattern = { "element_identifier", "name" },
				element_tag = { "element" },
				skip_tag_pattern = { "quoted_attribute_value", "tag_end", "attribute", "value" },
			}))
		end,
	},
	{
		"nvim-mini/mini.surround",
		enabled = true,
		lazy = true,
		keys = {
			{ "sa", mode = { "n", "v" }, desc = "Surrounding add." },
			{ "sd", mode = "n", desc = "Surrounding delete." },
			{ "sf", mode = "n", desc = "Surrounding find forward." },
			{ "sF", mode = "n", desc = "Surrounding find backward." },
			{ "sh", mode = "n", desc = "Surrounding highlight" },
			{ "sr", mode = "n", desc = "Surrounding replace" },
		},
		mappings = {
			add = "sa",
			delete = "sd",
			find = "sf",
			find_left = "sF",
			highlight = "sh",
			replace = "sr",
			suffix_last = "l",
			suffix_next = "n",
		},
		opts = {},
	},
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		enabled = true,
		lazy = true,
		opts = {
			enable_autocmd = false,
		},
		init = function()
			local get_option = vim.filetype.get_option
			vim.filetype.get_option = function(filetype, option)
				return option == "commentstring"
						and require("ts_context_commentstring.internal").calculate_commentstring()
					or get_option(filetype, option)
			end
		end,
	},
	{
		"folke/flash.nvim",
		enabled = true,
		event = "VeryLazy",
		opts = {},
		keys = {
			{
				"s",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash jump",
			},
			{
				"S",
				mode = { "n", "x", "o" },
				function()
					require("flash").treesitter()
				end,
				desc = "Flash Treesitter",
			},
		},
	},
	{
		"nvim-mini/mini.ai",
		version = false,
		enabled = true,
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			n_lines = 500,
		},
	},
}
