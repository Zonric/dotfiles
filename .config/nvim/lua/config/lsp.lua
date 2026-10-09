local M = {}

function M.setup()
	-- Selectively allow LSP formatting capabilities or hook buffer events
	local fmt_disallow = { "zig" }
	vim.api.nvim_create_autocmd("LspAttach", {
		callback = function(args)
			local client = vim.lsp.get_client_by_id(args.data.client_id)
			if not client or not client.server_capabilities then
				return
			end
			if vim.tbl_contains(fmt_disallow, client.name) then
				client.server_capabilities.documentFormattingProvider = false
				client.server_capabilities.documentRangeFormattingProvider = false
			end
		end,
	})

	require("mason").setup({
		PATH = "append",
		ui = {
			icons = {
				package_installed = "✓",
				package_pending = "➜",
				package_uninstalled = "✗",
			},
		},
	})

	local capabilities = vim.lsp.protocol.make_client_capabilities()
	local ok, blink = pcall(require, "blink.cmp")
	if ok then
		capabilities = blink.get_lsp_capabilities(capabilities)
	end

	vim.lsp.config("*", {
		capabilities = capabilities,
	})

	vim.lsp.config("zls", {
		cmd = { "zls" },
		settings = {
			zls = {
				enable_autofix = true,
				enable_inlay_hints = true,
				inlay_hints_show_builtin = true,
			},
		},
	})

	vim.lsp.config("gopls", {
		settings = {
			gopls = {
				gofumpt = true,
				analyses = {
					unusedparams = true,
					shadow = true,
					nilness = true,
					unusedwrite = true,
					useany = true,
				},
				staticcheck = true,
				hints = {
					assignVariableTypes = true,
					compositeLiteralFields = true,
					compositeLiteralTypes = true,
					constantValues = true,
					functionTypeParameters = true,
					parameterNames = true,
					rangeVariableTypes = true,
				},
				semanticTokens = true,
				usePlaceholders = true,
				completeUnimported = true,
			},
		},
	})

	vim.lsp.config("html", {
		filetypes = { "html", "templ" },
	})

	vim.lsp.config("emmet_language_server", {
		filetypes = {
			"css",
			"eruby",
			"html",
			"javascript",
			"javascriptreact",
			"less",
			"sass",
			"scss",
			"svelte",
			"pug",
			"typescriptreact",
			"vue",
			"templ",
		},
	})

	vim.lsp.config("ts_ls", {
		settings = {
			typescript = {
				inlayHints = {
					includeInlayParameterNameHints = "all",
					includeInlayParameterNameHintsWhenArgumentMatchesName = false,
					includeInlayFunctionParameterTypeHints = true,
					includeInlayVariableTypeHints = true,
					includeInlayPropertyDeclarationTypeHints = true,
					includeInlayFunctionLikeReturnTypeHints = true,
					includeInlayEnumMemberValueHints = true,
				},
			},
			javascript = {
				inlayHints = {
					includeInlayParameterNameHints = "all",
					includeInlayParameterNameHintsWhenArgumentMatchesName = false,
					includeInlayFunctionParameterTypeHints = true,
					includeInlayVariableTypeHints = true,
					includeInlayPropertyDeclarationTypeHints = true,
					includeInlayFunctionLikeReturnTypeHints = true,
					includeInlayEnumMemberValueHints = true,
				},
			},
		},
	})

	-- Enable system-managed servers (nvim-lspconfig configs loaded via Neovim 0.11+)
	vim.lsp.enable({ "clangd", "zls", "gopls" })
end

return M
