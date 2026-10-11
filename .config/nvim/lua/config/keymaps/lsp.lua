local safe = require("config.keymaps.util").safe
local wk_add_group = require("config.keymaps.util").wk_add_group
local map = vim.keymap.set

--- Core LSP leaderless
map("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition." })
map("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration." })
map("n", "gr", vim.lsp.buf.references, { desc = "Go to references." })
map("n", "gi", vim.lsp.buf.implementation, { desc = "Go to Implementation." })
map("n", "K", vim.lsp.buf.hover, { desc = "Display LSP hover info." })
map("i", "<C-k>", vim.lsp.buf.signature_help, { desc = "Display signature helper." })

--- Diagnostics & Hunks jump brackets
map("n", "]d", function()
	vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Next diagnostic" })
map("n", "[d", function()
	vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Prev diagnostic" })

map("n", "]h", safe("gitsigns", function(gs)
	gs.nav_hunk("next")
end), { desc = "Next git hunk" })
map("n", "[h", safe("gitsigns", function(gs)
	gs.nav_hunk("prev")
end), { desc = "Prev git hunk" })

map("n", "]t", safe("todo-comments", function(tc)
	tc.jump_next()
end), { desc = "Next todo comment" })
map("n", "[t", safe("todo-comments", function(tc)
	tc.jump_prev()
end), { desc = "Prev todo comment" })

--- LuaSnip Jumpable / Cycle
map({ "i", "s" }, "<C-h>", safe("luasnip", function(ls)
	if ls.jumpable(-1) then
		ls.jump(-1)
	end
end), { silent = true, desc = "Jump backward (snip)" })

map({ "i", "s" }, "<C-l>", safe("luasnip", function(ls)
	if ls.expand_or_jumpable() then
		ls.expand_or_jump()
	end
end), { silent = true, desc = "Jump forward (snip)" })

map({ "i", "s" }, "<C-n>", safe("luasnip", function(ls)
	if ls.choice_active() then
		ls.change_choice(1)
	end
end), { silent = true, desc = "Cycle Choice forward (snip)" })

map({ "i", "s" }, "<C-p>", safe("luasnip", function(ls)
	if ls.choice_active() then
		ls.change_choice(-1)
	end
end), { silent = true, desc = "Cycle Choice backward (snip)" })

--- Rust filetype bindings
local rust_group = vim.api.nvim_create_augroup("RustKeymaps", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	pattern = "rust",
	group = rust_group,
	callback = function(ev)
		wk_add_group("<leader>r", "Rust...")

		local rust_map = function(keys, cmd, desc)
			vim.keymap.set("n", keys, function()
				vim.cmd.RustLsp(cmd)
			end, { buffer = ev.buf, desc = desc })
		end

		rust_map("<leader>rr", "runnables", "Pick and run, rust bin or tests.")
		rust_map("<leader>rd", "debuggables", "Direct bridge into DAP")
		rust_map("<leader>rt", "testables", "Select unit/integration test.")
		rust_map("<leader>rm", "expandMacro", "Expand declarative/procedural macros.")
		rust_map("<leader>rc", "openCargo", "Jump to project's Cargo.toml")
		rust_map("<leader>rp", "parentModule", "Navigate upward to parent mod or lib .rs.")
		rust_map("<leader>re", "explainError", "Open 'rustc --explain' docs")
		rust_map("<leader>rg", { "crateGraph", "[backend]", "[output]" }, "Visualize module/crate dependencies.")
	end,
})

--- Cargo.toml / Crates bindings
if not vim.g.is_server then
	vim.api.nvim_create_autocmd("BufRead", {
		pattern = "Cargo.toml",
		callback = function(ev)
			local ok, crates = pcall(require, "crates")
			if not ok then
				return
			end
			local bmap = function(keys, fn, desc)
				vim.keymap.set("n", keys, fn, { buffer = ev.buf, desc = desc })
			end
			bmap("<leader>pt", crates.toggle, "Toggle crates info.")
			bmap("<leader>pu", crates.update_crate, "Update crate.")
			bmap("<leader>pd", crates.show_dependencies_popup, "Dependencies popup.")
			bmap("<leader>pf", crates.show_features_popup, "Features popup.")
			bmap("<leader>pv", crates.show_versions_popup, "Versions popup.")
		end,
	})
end
