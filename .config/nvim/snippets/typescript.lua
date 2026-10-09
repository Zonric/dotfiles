local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
	-- Arrow function
	s("afn", {
		t("const "),
		i(1, "name"),
		t(" = ("),
		i(2),
		t({ ") => {", "\t" }),
		i(0),
		t({ "", "};" }),
	}),

	-- Interface
	s("int", {
		t("interface "),
		i(1, "Name"),
		t({ " {", "\t" }),
		i(0),
		t({ "", "}" }),
	}),

	-- Type alias
	s("ty", {
		t("type "),
		i(1, "Name"),
		t(" = "),
		i(0),
		t(";"),
	}),

	-- Console log
	s("cl", {
		t("console.log("),
		i(1),
		t(");"),
		i(0),
	}),
}
