local function unified()
	local enabled = true
	local stat = vim.uv.fs_stat(vim.fn.expand("~/.config/nvim/colors/unified.lua"))
	if enabled and stat ~= nil and stat.type == "file" then
		vim.cmd("colorscheme unified")
		return false
	end
	return true
end

return {
	{
		"EdenEast/nightfox.nvim",
		enabled = unified(),
		lazy = false,
		priority = 1000,
		opts = {},
		config = function()
			vim.cmd("colorscheme carbonfox")
			vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#FFFFFF" })
			vim.api.nvim_set_hl(0, "MiniCursorword", { fg = "#ff7eb6", bold = true, underline = true })
			vim.api.nvim_set_hl(0, "MiniCursorwordCurrent", { fg = "#ff7eb6", bold = true, underline = true })
		end,
	},
}
