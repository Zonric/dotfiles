local M = {}

--- Add a group key to which-key safely
function M.wk_add_group(prefix, name)
	local ok, wk = pcall(require, "which-key")
	if ok then
		wk.add({ prefix, group = name })
	end
end

--- Lazy-safe and call-safe wrapper around a module function
--- @param mod string Module name to require
--- @param fn_or_str function|string Function callback or string path (e.g. "tree.toggle")
function M.safe(mod, fn_or_str)
	return function(...)
		local ok, m = pcall(require, mod)
		if not ok then
			return
		end

		if type(fn_or_str) == "function" then
			return fn_or_str(m, ...)
		elseif type(fn_or_str) == "string" then
			local target = m
			for part in fn_or_str:gmatch("[^%.]+") do
				target = target and target[part]
			end
			if type(target) == "function" then
				return target(...)
			end
		end
	end
end

return M
