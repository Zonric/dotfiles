local M = {}

function M.setup()
	-- Pine palette colors (balanced medium contrast, zero blinding white)
	local colors = {
		bg           = "#0b1311", -- forest abyss
		surface      = "#111d1a", -- forest floor
		moss         = "#1b2b27", -- moss rock
		lichen       = "#2c453e", -- lichen stone
		pine         = "#35524b", -- pine shade
		fg           = "#d1e2dc", -- mist white
		muted        = "#78988f", -- sage needle
		spruce       = "#5cb87a", -- spruce needle green
		spruce_light = "#82d99d", -- fresh needle sprout
		amber        = "#f09d58", -- warm amber resin
		amber_dark   = "#3b2a1a", -- deep amber shadow
		blossom      = "#ee96b8", -- floral blossom
		blossom_dark = "#38212c", -- deep floral shadow
		berry        = "#f27272", -- ripe berry red
		berry_dark   = "#35191c", -- deep berry crimson
		ridge_blue   = "#7eaff0", -- mountain ridge sky
		ridge_dark   = "#1c2b3d", -- shadowed ridge blue
		teal         = "#64c7bd", -- glacial teal
		lavender     = "#c3acf2", -- wild heather lavender
		gold         = "#e8be6b", -- morning sunbeam gold
	}

	local pine_lualine = {
		normal = {
			a = { bg = colors.lichen, fg = colors.spruce_light, gui = "bold" },
			b = { bg = colors.moss, fg = colors.fg },
			c = { bg = colors.surface, fg = colors.muted },
			x = { bg = colors.surface, fg = colors.muted },
			y = { bg = colors.moss, fg = colors.fg },
			z = { bg = colors.lichen, fg = colors.spruce_light, gui = "bold" },
		},
		insert = {
			a = { bg = colors.amber_dark, fg = colors.amber, gui = "bold" },
			b = { bg = colors.moss, fg = colors.fg },
			z = { bg = colors.amber_dark, fg = colors.amber, gui = "bold" },
		},
		visual = {
			a = { bg = colors.blossom_dark, fg = colors.blossom, gui = "bold" },
			b = { bg = colors.moss, fg = colors.fg },
			z = { bg = colors.blossom_dark, fg = colors.blossom, gui = "bold" },
		},
		replace = {
			a = { bg = colors.berry_dark, fg = colors.berry, gui = "bold" },
			b = { bg = colors.moss, fg = colors.fg },
			z = { bg = colors.berry_dark, fg = colors.berry, gui = "bold" },
		},
		command = {
			a = { bg = colors.ridge_dark, fg = colors.ridge_blue, gui = "bold" },
			b = { bg = colors.moss, fg = colors.fg },
			z = { bg = colors.ridge_dark, fg = colors.ridge_blue, gui = "bold" },
		},
		inactive = {
			a = { bg = colors.surface, fg = colors.muted },
			b = { bg = colors.surface, fg = colors.muted },
			c = { bg = colors.surface, fg = colors.muted },
		},
	}

	local lualine_a = {}
	if vim.g.is_server then
		table.insert(lualine_a, {
			function()
				return vim.uv.os_gethostname()
			end,
			icon = "󰒋",
		})
	end
	table.insert(lualine_a, {
		"mode",
		fmt = function(str)
			return str:sub(1, 3)
		end,
	})

	return {
		options = {
			theme = pine_lualine,
			component_separators = { left = "", right = "" },
			section_separators = { left = "", right = "" },
			disabled_filetypes = {
				statusline = { "dashboard", "alpha", "NvimTree" },
				winbar = {},
			},
			globalstatus = true,
		},
		sections = {
			lualine_a = lualine_a,
			lualine_b = {
				{ "branch", icon = "", color = { fg = colors.spruce_light, gui = "bold" } },
				{
					"diff",
					symbols = { added = " ", modified = " ", removed = " " },
					diff_color = {
						added = { fg = colors.spruce_light },
						modified = { fg = colors.gold },
						removed = { fg = colors.berry },
					},
				},
				{
					"diagnostics",
					sources = { "nvim_diagnostic" },
					symbols = { error = " ", warn = " ", info = " ", hint = " " },
					diagnostics_color = {
						error = { fg = colors.berry },
						warn = { fg = colors.gold },
						info = { fg = colors.teal },
						hint = { fg = colors.muted },
					},
				},
			},
			lualine_c = {
				{
					function()
						return vim.fn.fnamemodify(vim.fn.getcwd(), ":~")
					end,
					icon = "󰉋",
					color = { fg = colors.muted },
				},
				{
					"filename",
					path = 1,
					color = { fg = colors.fg },
					symbols = {
						modified = " ●",
						readonly = " ",
						unnamed = "[No Name]",
						newfile = "[New]",
					},
				},
			},
			lualine_x = {
				{
					function()
						local reg = vim.fn.reg_recording()
						if reg ~= "" then
							return "REC @" .. reg
						end
						return ""
					end,
					color = { fg = colors.berry, gui = "bold" },
				},
				{ "searchcount", maxcount = 999, timeout = 500, color = { fg = colors.gold } },
			},
			lualine_y = {
				-- Primary LSP server indicator with extra count if multiple servers
				{
					function()
						local clients = vim.lsp.get_clients({ bufnr = 0 })
						if #clients == 0 then
							return ""
						end
						local names = {}
						for _, client in ipairs(clients) do
							if client.name ~= "null-ls" and client.name ~= "copilot" then
								table.insert(names, client.name)
							end
						end
						if #names == 0 then
							return ""
						end
						local primary = names[1]
						if #names > 1 then
							return primary .. " (+" .. (#names - 1) .. ")"
						end
						return primary
					end,
					icon = "",
					color = { fg = colors.teal },
				},
				-- Formatter: display only if handled by external formatter (not pure LSP)
				{
					function()
						local ok, conform = pcall(require, "conform")
						if not ok then
							return ""
						end
						local formatters = conform.list_formatters_to_run(0)
						if #formatters == 0 then
							return ""
						end
						local names = {}
						for _, f in ipairs(formatters) do
							if f.name ~= "lsp" then
								table.insert(names, f.name)
							end
						end
						return #names > 0 and table.concat(names, ", ") or ""
					end,
					icon = "",
					color = { fg = colors.lavender },
				},
				{ "filetype", icon_only = false, color = { fg = colors.fg } },
			},
			lualine_z = {
				{ "location" },
				{ "progress" },
			},
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = { { "filename", path = 1 } },
			lualine_x = { "location" },
			lualine_y = {},
			lualine_z = {},
		},
	}
end

return M
