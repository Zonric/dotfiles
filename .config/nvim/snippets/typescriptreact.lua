local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

local function component_name()
	local name = vim.fn.expand("%:t:r")
	if name == "" or name == "index" then
		name = vim.fn.expand("%:p:h:t")
	end
	return name:gsub("^%l", string.upper)
end

return {
	-- React Functional Component with TypeScript Props
	s("rfc", {
		t("interface "),
		f(component_name, {}),
		t("Props {"),
		t({ "", "\t" }),
		i(1),
		t({ "", "}", "", "" }),
		t("export const "),
		f(component_name, {}),
		t(": React.FC<"),
		f(component_name, {}),
		t("Props> = ({ "),
		i(2),
		t(" }) => {"),
		t({ "", "\treturn (" }),
		t({ "", "\t\t<div>" }),
		t({ "", "\t\t\t" }),
		i(0),
		t({ "", "\t\t</div>" }),
		t({ "", "\t);" }),
		t({ "", "};", "" }),
	}),

	-- useState hook
	s("us", {
		t("const ["),
		i(1, "state"),
		t(", set"),
		f(function(args)
			local name = args[1][1] or ""
			return name:gsub("^%l", string.upper)
		end, { 1 }),
		t("] = useState("),
		i(2),
		t(");"),
		i(0),
	}),

	-- useEffect hook
	s("ue", {
		t({ "useEffect(() => {", "\t" }),
		i(0),
		t({ "", "}, [" }),
		i(1),
		t("]);"),
	}),

	-- useMemo hook
	s("um", {
		t("const "),
		i(1, "memoizedValue"),
		t(" = useMemo(() => {"),
		t({ "", "\treturn " }),
		i(0),
		t({ ";", "}, [" }),
		i(2),
		t("]);"),
	}),

	-- useCallback hook
	s("uc", {
		t("const "),
		i(1, "memoizedCallback"),
		t(" = useCallback(("),
		i(2),
		t({ ") => {", "\t" }),
		i(0),
		t({ "", "}, [" }),
		i(3),
		t("]);"),
	}),

	-- useRef hook
	s("ur", {
		t("const "),
		i(1, "ref"),
		t(" = useRef<"),
		i(2, "HTMLDivElement"),
		t(">("),
		i(3, "null"),
		t(");"),
		i(0),
	}),
}
