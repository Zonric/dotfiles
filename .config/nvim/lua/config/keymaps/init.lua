-- Auto-load all lua modules in config/keymaps/ (excluding init and util)
local keymaps_dir = vim.fn.stdpath("config") .. "/lua/config/keymaps"

-- Ensure utility helpers are available first
require("config.keymaps.util")

local handle = vim.uv.fs_scandir(keymaps_dir)
if handle then
	local files = {}
	while true do
		local name, ftype = vim.uv.fs_scandir_next(handle)
		if not name then
			break
		end
		if ftype == "file" and name:match("%.lua$") and name ~= "init.lua" and name ~= "util.lua" then
			local mod_name = name:gsub("%.lua$", "")
			files[#files + 1] = mod_name
		end
	end

	table.sort(files)

	for _, mod in ipairs(files) do
		require("config.keymaps." .. mod)
	end
end
