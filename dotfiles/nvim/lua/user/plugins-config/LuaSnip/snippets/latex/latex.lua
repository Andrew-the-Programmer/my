local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

local sf = require("user.plugins-config.LuaSnip.snippets.latex.snip_funcs")

local M = {}

function M.env(name)
	return fmta(
		[[
    \begin{<>}
        <>
    \end{<>}
    ]],
		{
			My.lua.If(name ~= nil, t(name), i(1)),
			i(0),
			My.lua.If(name ~= nil, t(name), rep(1)),
		}
	)
end

ls.add_snippets("latex", {
	s("beg", M.env(nil)),
	s("env", M.env(nil)),
	s("gather", M.env("gather")),
	s("equation", M.env("equation")),
	s({
		trig = "mi",
		desc = "inline math",
	}, {
		t("$"),
		i(1),
		t("$"),
	}),
	s({
		trig = "mb",
		desc = "block math",
	}, M.env("gather")),
	s("enumerate", M.env("enumerate")),
	s(
		"table",
		fmta(
			[[
\begin{table}[H]
\centering
\begin{tabular}{<col>}
\toprule
    <body>
\midrule
\bottomrule
\end{tabular}
\end{table}
    ]],
			{
				col = i(1),
				body = i(0),
			}
		)
	),
	s(
		"figure",
		fmta(
			[[
\begin{figure}[H]
\centering
<>
\caption{<>}
\label{fig:<>}
\end{figure}
    ]],
			{
				c(1, {
					fmta([[\includesvg[width=\linewidth]{<>}]], { i(1) }),
					fmta([[\includegraphics[width=\linewidth]{<>}]], { i(1) }),
				}),
				i(2, "caption"),
				i(3, "label"),
			}
		)
	),
	s(
		"description",
		fmta(
			[[
\begin{description}
    \item <body>
\end{description}
<i0>
    ]],
			{
				body = i(1),
				i0 = i(0),
			}
		)
	),
})

return M
