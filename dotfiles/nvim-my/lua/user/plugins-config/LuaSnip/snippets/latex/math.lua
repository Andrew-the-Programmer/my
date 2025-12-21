local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local fmta = require("luasnip.extras.fmt").fmta

local sf = require("user.plugins-config.LuaSnip.snippets.latex.snip_funcs")

ls.add_snippets("Math", {
	sf.greek_letter("a", "alpha"),
	sf.greek_letter("b", "beta"),
	sf.greek_letter("g", "gamma"),
	sf.greek_letter("G", "Gamma"),
	sf.greek_letter("d", "delta"),
	sf.greek_letter("D", "Delta"),
	sf.greek_letter("e", "varepsilon"),
	sf.greek_letter("z", "zeta"),
	sf.greek_letter("h", "eta"), -- NOTE: bad naming
	sf.greek_letter("th", "theta"), -- NOTE: bad naming
	sf.greek_letter("Th", "Theta"), -- NOTE: bad naming
	sf.greek_letter("k", "kappa"),
	sf.greek_letter("l", "lambda"),
	sf.greek_letter("L", "Lambda"),
	sf.greek_letter("m", "mu"),
	sf.greek_letter("n", "nu"),
	sf.greek_letter("x", "xi"),
	sf.greek_letter("X", "Xi"),
	sf.greek_letter("p", "pi"),
	sf.greek_letter("P", "Pi"),
	sf.greek_letter("r", "rho"),
	sf.greek_letter("s", "sigma"),
	sf.greek_letter("S", "Sigma"),
	sf.greek_letter("t", "tau"),
	sf.greek_letter("u", "upsilon"),
	sf.greek_letter("U", "Upsilon"),
	sf.greek_letter("f", "varphi"), -- NOTE: bad naming
	sf.greek_letter("F", "Phi"), -- NOTE: bad naming
	sf.greek_letter("c", "chi"),
	sf.greek_letter("y", "psi"), -- NOTE: really bad naming
	sf.greek_letter("Y", "Psi"), -- NOTE: really bad naming
	sf.greek_letter("o", "omega"),
	sf.greek_letter("O", "Omega"),

	sf.keyword_simple("N", "NN"),
	sf.keyword_simple("Z", "ZZ"),
	sf.keyword_simple("Q", "QQ"),
	sf.keyword_simple("R", "RR"),
	sf.keyword_simple("Re", "RRe"),
	sf.keyword_simple("C", "CC"),
	sf.keyword_simple("PP", "PP"),
	sf.keyword_simple("HH", "HH"),
	sf.keyword_simple("FF", "FF"),

	sf.keyword_simple("inf", "infty"),
	sf.keyword_simple("bs", "blacksquare"),

	sf.power("sr", "2"),
	sf.power("cb", "3"),

	s({
		trig = "(%a)(%d)",
		trigEngine = "pattern",
		snippetType = "autosnippet",
	}, {
		f(function(_, snip)
			local c1 = snip.captures[1]
			local c2 = snip.captures[2]
			return c1 .. "_" .. c2
		end),
	}),

	sf.lind_snip("%a", "%d"),
	sf.lind_snip("%a", "ii", "i"),
	sf.lind_snip("[abcdmnxyz]", "j", "j"),
	sf.lind_snip("%a", "nn", "n"),
	sf.lind_snip("\\%a+", "nn", "n"),
	sf.lind_snip("%a", "mm", "m"),

	-- sf.unary_operator("d", "\\d"),
	-- sf.unary_operator("D", "\\D"),
	s({
		trig = "([dD])([%a ])",
		trigEngine = "pattern",
	}, {
		f(function(_, snip)
			local c1 = snip.captures[1]
			local c2 = snip.captures[2]
			return "\\" .. c1 .. My.lua.If(c2 == " ", " ", " " .. c2)
		end),
	}),
	-- TODO: improve this
	sf.unary_operator("L", "\\Laplace"),
	sf.unary_operator("DA", "\\DAlambert"),
	sf.unary_operator("N", "\\Nabla"),
	sf.unary_operator("G", "\\grad"),

	sf.unary_operator_easy("not", "\\lnot"),
	sf.unary_operator_easy("ex", "\\exists"),
	sf.unary_operator_easy("nex", "\\not\\exists"),
	sf.unary_operator_easy("fa", "\\forall"),
	sf.unary_operator_easy("nfa", "\\not\\forall"),

	sf.binary_operator("eq", "="),
	sf.binary_operator("ne", "\\neq"),
	sf.binary_operator_auto("!=", "\\neq"),
	sf.binary_operator("de", "\\defeq"),
	sf.binary_operator_auto(":=", "\\defeq"),
	sf.binary_operator("le", "\\le"),
	sf.binary_operator_auto("<=", "\\le"),
	sf.binary_operator("ge", "\\ge"),
	sf.binary_operator_auto(">=", "\\ge"),
	sf.binary_operator("ll", "\\ll"),
	sf.binary_operator_auto("<<", "\\ll"),
	sf.binary_operator("gg", "\\gg"),
	sf.binary_operator_auto(">>", "\\gg"),
	sf.binary_operator("im", "\\implies"),
	sf.binary_operator_auto("->", "\\implies"),
	sf.binary_operator("imb", "\\impliedby"),
	sf.binary_operator_auto("<-", "\\impliedby"),
	sf.binary_operator("sm", "\\same"),
	sf.binary_operator("ht", "\\hthen"),
	sf.binary_operator_auto("/>", "\\hthen"),
	sf.binary_operator("to", "\\to"),

	sf.binary_operator("un", "\\cup"),
	sf.binary_operator("ir", "\\cap"),
	sf.binary_operator("or", "\\lor"),
	sf.binary_operator("and", "\\land"),
	sf.binary_operator("in", "\\in"),
	sf.binary_operator("ss", "\\subset"),
	sf.binary_operator("se", "\\subseteq"),

	sf.binary_operator_auto("**", "\\cdot"),
	sf.binary_operator_auto("xx/", "\\times"),
	sf.binary_operator_auto("--", "\\dash"),
	sf.binary_operator_auto("..", "\\dots"),
	s({
		trig = ",q",
		snippetType = "autosnippet",
		wordTrig = false,
	}, { t(", \\quad ") }),

	sf.unary_func("circled", "circled"),
	sf.unary_func("ol", "overline"),
	sf.unary_func("ul", "underline"),
	sf.unary_func("wt", "widetilde"),
	sf.unary_func("wh", "widehat"),
	sf.unary_func("abs", "abs"),
	sf.unary_func("norm", "norm"),
	sf.unary_func("ceil", "ceil"),
	sf.unary_func("floor", "floor"),
	sf.unary_func("round", "round"),
	sf.unary_func("vec", "vec"),
	sf.unary_func("dot", "dot"),
	sf.unary_func("sure", "surround"),
	s(
		{
			trig = "sure([<{%(%[tcbr]?)([>}%)%]tcbr]?)",
			trigEngine = "pattern",
		},
		fmta("\\surround<1>{<2>}", {
			[1] = d(1, function(_, snip)
				local c1 = snip.captures[1]
				local c2 = snip.captures[2]
				if c1:len() == 0 then
					return sn(nil, { i(1) })
				end
				if c1 == "t" then
					c1 = "<"
				elseif c1 == "c" then
					c1 = "{"
				elseif c1 == "b" then
					c1 = "("
				elseif c1 == "r" then
					c1 = "["
				end
				if c2:len() == 0 then
					return sn(nil, { t(c1), i(1) })
				end
				if c2 == "t" then
					c2 = ">"
				elseif c2 == "c" then
					c2 = "}"
				elseif c2 == "b" then
					c2 = ")"
				elseif c2 == "r" then
					c2 = "]"
				end
				return sn(nil, { t(c1 .. c2) })
			end),
			[2] = i(2),
		})
	),
	sf.unary_func("set", "set"),
	sf.unary_func("gr", "group"),
	sf.unary_func("grr", "groupr"),
	sf.unary_func("grt", "groupt"),
	sf.unary_func("tt", "text"),
	sf.unary_func("ti", "textit"),

	sf.env("gather", "Gather"),
	sf.env("cases", "Cases"),
	sf.env("array", "Array"),
	sf.env("matrix", "Matrix"),
	sf.env("alignleft", "AlignLeft"),
	sf.env("aligncenter", "AlignCenter"),
	sf.env("align", "Align"),

	sf.unary_func_with_index("exp", "exp"),
	sf.unary_func_with_index("ln", "ln"),
	sf.unary_func_with_index("log", "log"),
	sf.unary_func("sq", "sqrt"),

	sf.unary_func_with_index("sin", "sin"),
	sf.unary_func_with_index("cos", "cos"),
	sf.unary_func_with_index("tg", "tg"),
	sf.unary_func_with_index("ct", "ct"),
	sf.unary_func_with_index("asin", "arcsin"),
	sf.unary_func_with_index("acos", "arccos"),
	sf.unary_func_with_index("atg", "arctg"),
	sf.unary_func_with_index("act", "arcct"),
	sf.unary_func_with_index("sh", "sh"),
	sf.unary_func_with_index("ch", "ch"),

	-- dv, Dv, pdv, pDv, vdv, vDv
	s(
		{
			trig = "([pv]?[dD]v)(%d?)(%a?)(%a?)",
			trigEngine = "pattern",
		},
		fmta("\\<op><1>{<2>}{<3>}", {
			op = f(function(_, snip)
				return snip.captures[1]
			end),
			[1] = d(1, function(_, snip)
				local capture = snip.captures[2]
				if capture:len() > 0 then
					return sn(nil, { t("[" .. capture .. "]") })
				else
					return sn(nil, {})
				end
			end),
			[2] = d(2, function(_, snip)
				local capture = snip.captures[3]
				if capture:len() > 0 then
					return sn(nil, { t(capture) })
				else
					return sn(nil, { i(1) })
				end
			end),
			[3] = d(3, function(_, snip)
				local capture = snip.captures[4]
				if capture:len() > 0 then
					return sn(nil, { t(capture) })
				else
					return sn(nil, { i(1) })
				end
			end),
		})
	),
	-- veccross, vecprod
	s(
		{
			trig = "v([pc])",
			trigEngine = "pattern",
		},
		fmta("\\vec<op>{<>}{<>}", {
			op = f(function(_, snip)
				local capture = snip.captures[2]
				if capture == "p" then
					return "prod"
				else
					return "cross"
				end
			end),
			i(1),
			i(2),
		})
	),
	-- lim, limsup, liminf
	s(
		{
			trig = "lim([is]?)",
			trigEngine = "pattern",
		},
		sf.index(
			f(function(_, snip)
				local capture = snip.captures[1]
				if capture == "s" then
					return "\\limsup"
				elseif capture == "i" then
					return "\\liminf"
				else
					return "\\lim"
				end
			end),
			{
				sn(nil, { i(1), t(" \\to "), i(2) }),
				sn(nil, { i(1) }),
			},
			nil
		),
		sf.dont_repeat()
	),

	-- sup, inf, min, max
	s({
		trig = "sup",
	}, sf.domain_operator("\\sup"), sf.dont_repeat()),
	s({
		trig = "inf",
	}, sf.domain_operator("\\inf"), sf.dont_repeat()),
	s({
		trig = "min",
	}, sf.domain_operator("\\min"), sf.dont_repeat()),
	s({
		trig = "max",
	}, sf.domain_operator("\\max"), sf.dont_repeat()),

	-- sum, union, intersection, product, or, and
	s({
		trig = "sum",
	}, sf.big_operator("\\sum"), sf.dont_repeat()),
	s({
		trig = "Un",
	}, sf.big_operator("\\bigcup")),
	s({
		trig = "Uns",
	}, sf.big_operator("\\bigsqcup")),
	s({
		trig = "Ir",
	}, sf.big_operator("\\bigcap")),
	s({
		trig = "prod",
	}, sf.big_operator("\\prod"), sf.dont_repeat()),
	s({
		trig = "Or",
	}, sf.big_operator("\\bigvee")),
	s({
		trig = "And",
	}, sf.big_operator("\\bigwedge")),
	s(
		{
			trig = "int",
		},
		sf.index(
			"\\int",
			{
				sn(nil, { i(1) }),
				t("-\\infty"),
				sn(nil, { i(1), t(" \\in "), i(2) }),
			},
			---@param lind string
			---@return table
			function(lind)
				if lind == "" or lind:match("^.* \\in .*$") then
					return {}
				else
					return {
						sn(nil, { i(1, "+\\infty") }),
						sn(nil, { t("\\to "), i(1) }),
					}
				end
			end
		),
		sf.dont_repeat()
	),
	s(
		{
			trig = "//",
			snippetType = "autosnippet",
		},
		fmta("\\frac{<>}{<>}", {
			i(1),
			i(2),
		})
	),
	s(
		{
			trig = "([%a%d])/",
			trigEngine = "pattern",
			snippetType = "autosnippet",
		},
		fmta("\\frac{<>}{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			i(1),
		})
	),
	s(
		{
			trig = "/([%a%d])",
			trigEngine = "pattern",
			snippetType = "autosnippet",
		},
		fmta("\\frac{<>}{<>}", {
			i(1),
			f(function(_, snip)
				return snip.captures[1]
			end),
		})
	),
	s({
		trig = '"',
		wordTrig = true,
		snippetType = "autosnippet",
		priority = -100,
	}, {
		t("\\text{\\textit{"),
		i(1),
		t("}}"),
	}),
})
