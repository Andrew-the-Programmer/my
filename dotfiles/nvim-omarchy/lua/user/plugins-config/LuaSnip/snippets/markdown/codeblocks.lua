local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

local function code_block(lang)
	return fmt(
		[[
    ```{lang}
    {block}
    ```
    ]],
		{
			lang = My.lua.If(lang ~= nil, t(lang), i(1, "lang")),
			block = i(0),
		}
	)
end

ls.add_snippets("markdown", {
	s("codeblock", code_block(nil)),
	s("python", code_block("python")),
	s("cpp", code_block("cpp")),
	s("bash", code_block("bash")),
	s("tex", code_block("tex")),
})
