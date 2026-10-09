local agents = require("config.agents")

return {
	{
		"milanglacier/minuet-ai.nvim",
		enabled = true,
		config = function()
			require("minuet").setup({
				provider = "openai_fim_compatible",
				provider_options = {
					openai_fim_compatible = {
						api_key = "TERM",
						end_point = "http://127.0.0.1:8010/v1/completions",
						model = "qwen2.5-coder-7b",
						name = "LlamaCPP",
						stream = true,
						optional = {
							max_tokens = 64,
							temperature = 0.1,
							top_p = 0.95,
							stop = { "<|fim_pad|>", "<|fim_middle|>", "<|endoftext|>", "<|im_end|>" },
						},
					},
				},
				virtualtext = {
					-- auto_trigger_ft = { "c", "cpp", "python", "lua", "bash" },
					keymap = {
						accept = "<A-A>",
						accept_line = "<A-a>",
						accept_n_line = "<A-z>",
						prev = "<A-[>",
						next = "<A-]>",
						dismiss = "<A-e>",
					},
				},
			})
		end,
	},
	{
		"ggml-org/llama.vim",
		enabled = false,
		init = function()
			vim.g.llama_config = {
				auto_fim = true,
				keymap_fim_trigger = "<C-f>",
				keymap_fim_accept_word = "<C-l>",
				keymap_fim_accept_line = "<C-j>",
				keymap_fim_accept_full = "<S-Tab>",

				n_predict = 256,
				t_max_predict_ms = 1385,
				n_prefix = 512,
				n_suffix = 128,
				ring_n_chunks = 64,
			}
		end,
		config = function()
			local function unit(action)
				vim.system({ "systemctl", "--user", action, "llama-fim" }, {}, function(r)
					vim.schedule(function()
						vim.notify(("llama-fim %s: %s"):format(action, r.code == 0 and "ok" or "failed"))
					end)
				end)
			end
			vim.api.nvim_create_user_command("FimUp", function()
				unit("start")
			end, {})
			vim.api.nvim_create_user_command("FimDown", function()
				unit("stop")
			end, {})
		end,
	},
	{
		"olimorris/codecompanion.nvim",
		enabled = true,
		version = "^19.0.0",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		opts = agents.codecompanion_opts,
	},
}
