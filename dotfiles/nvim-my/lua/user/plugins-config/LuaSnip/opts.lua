return {
	keep_roots = true,
	link_roots = true,
	link_children = true,
	enable_autosnippets = true,
	store_selection_keys = "<Tab>",

	update_events = "TextChanged,TextChangedI",
	delete_check_events = "TextChanged",

	ft_func = function()
		local ft = require("luasnip.extras.filetype_functions").from_cursor_pos()
		ft = My.lua.ListExtend(ft, My.nvim.get_synstack())

		if
			My.lua.Any(ft, function(v)
				return My.lua.ListFind({ "texMathZoneTI", "texMathZoneTD", "mkdMath", "texMathZoneEnv" }, v)
			end) and not My.lua.ListFind(ft, "texMathTextConcArg")
		then
			table.insert(ft, "Math")
		end

		return ft
	end,
}
