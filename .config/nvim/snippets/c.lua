local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local f = ls.function_node

local function brace_space(args)
	return args[1][1] == "" and "{" or " {"
end

local function ns_suffix(args)
	local name = args[1][1]
	return name == "" and "" or (" " .. name)
end

local function guard_name()
	local full_path = vim.fn.expand("%:p")
	local relative = full_path:match(".*/include/(.+)%..+$")

	if not relative then
		relative = vim.fn.expand("%:.:r")
	end

	local clean = relative:gsub("[/\\]", "_"):gsub("[^%w_]", "_"):upper()
	local ext = vim.fn.expand("%:e"):upper():gsub("[^%w]", "_")
	if ext == "" then
		ext = "H"
	end

	return clean .. "_" .. ext
end

return {
	s("guard",{
		f(function() return "#ifndef " .. guard_name() end, {}),
		t({ "", "" }),
		f(function() return "#define " .. guard_name() end, {}),
		t({ "", "", "" }),
		i(1),
		t({ "", "", "" }),
		f(function() return "#endif // " .. guard_name() end, {}),
	}),

	s("ns",{
		t("namespace "), i(1, "name"), f(brace_space, {1}),
		t({"", "\t"}), i(0),
		t({"", "} //end namespace"}), f(ns_suffix, {1}),
	}),

	s("decl",{
		c(1, {
			t("int"),
			t("float"),
			t("double"),
			t("char"),
			t("long"),
			t("unsigned int"),
		}),
		t(" "), i(2, "name"), t(" = "), i(3, "0"), t(";"),
		i(0),
	}),

	s("for", {
		t("for(int "), i(1, "i"), t(" = 0; "),
		f(function(args) return args[1][1] end, {1}), t(" < "), i(2, "n"), t("; "),
		f(function(args) return args[1][1] end, {1}), t("++) {"),
		t({ "", "\t" }), i(0),
		t({ "", "}" }),
	}),

	s("pf", {
		t('printf("'), i(1, "output"),
		c(2, {
			t("%d"),
			t("%f"),
			t("%s"),
			t("%c"),
			t("%p"),
			t("%lu"),
			t("%x"),
		}),
		t('\\n", '), i(3, "value"), t(");"),
		i(0),
	}),

	s("param", {
		c(1, { t("void"), t("int"), t("float"), t("double"), t("char"), }),
		c(2, { t(" "), t(" *")}),
		i(3, "name"),
	}),

}
