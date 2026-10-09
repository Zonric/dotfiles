return {
	{
		"nvim-neotest/neotest",
		enabled = not vim.g.is_server,
		lazy = true,
		cmd = { "Neotest" },
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",
			"marilari88/neotest-vitest",
			"nvim-neotest/neotest-jest",
			"fredrikaverpil/neotest-golang",
			"nvim-neotest/neotest-python",
		},
		opts = function()
			-- Register tsx parser for typescriptreact so Treesitter can discover JSX tests (.test.tsx)
			pcall(vim.treesitter.language.register, "tsx", "typescriptreact")

			local function find_package_root(file_path)
				if not file_path or file_path == "" then
					file_path = vim.fn.expand("%:p")
				end
				if not file_path or file_path == "" then
					return vim.fn.getcwd()
				end
				local root = vim.fs.root(file_path, { "package.json" })
				return root or vim.fn.getcwd()
			end

			local function find_jest_config(file_path)
				local pkg_root = find_package_root(file_path)
				for _, cfg_name in ipairs({ "jest.config.ts", "jest.config.js", "jest.config.mjs", "jest.config.cjs" }) do
					local full_path = pkg_root .. "/" .. cfg_name
					if vim.fn.filereadable(full_path) == 1 then
						return full_path
					end
				end
				return pkg_root .. "/jest.config.ts"
			end

			return {
				adapters = {
					require("neotest-vitest")({
						cwd = function(file_path)
							return find_package_root(file_path)
						end,
					}),
					require("neotest-jest")({
						jestConfigFile = function(file_path)
							return find_jest_config(file_path)
						end,
						cwd = function(file_path)
							return find_package_root(file_path)
						end,
					}),
					require("neotest-golang"),
					require("neotest-python")({
						dap = { justMyCode = false },
					}),
				},
				status = { virtual_text = true },
				output = { open_on_run = false },
			}
		end,
		config = function(_, opts)
			require("neotest").setup(opts)
		end,
	},
}
