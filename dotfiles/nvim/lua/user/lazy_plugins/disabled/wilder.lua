return {
	-- https://github.com/gelguy/wilder.nvim
	"gelguy/wilder.nvim",
	keys = {
		":",
		"/",
		"?",
	},
	dependencies = {
		"catppuccin/nvim",
		"romgrk/fzy-lua-native",
	},
	config = function()
		local wilder = require("wilder")
		local theme_palette = require("catppuccin.palettes").get_palette("frappe")

		-- Create a highlight group for the popup menu
		local text_highlight =
			wilder.make_hl("WilderText", { { a = 1 }, { a = 1 }, { foreground = theme_palette.text } })
		local mauve_highlight =
			wilder.make_hl("WilderMauve", { { a = 1 }, { a = 1 }, { foreground = theme_palette.mauve } })

		-- Enable wilder when pressing :, / or ?
		wilder.setup({ modes = { ":", "/", "?" } })

		-- Enable fuzzy matching for commands and buffers
		wilder.set_option("pipeline", {
			wilder.branch(
				wilder.cmdline_pipeline({
					language = "python",
					fuzzy = 1,
				}),
				wilder.vim_search_pipeline({
					fuzzy = 1,
				}),
				wilder.python_search_pipeline({
					-- can be set to wilder#python_fuzzy_delimiter_pattern() for stricter fuzzy matching
					pattern = wilder.python_fuzzy_pattern(),
					-- omit to get results in the order they appear in the buffer
					sorter = wilder.python_difflib_sorter(),
					-- can be set to 're2' for performance, requires pyre2 to be installed
					-- see :h wilder#python_search() for more details
					engine = "re",
				}),
				wilder.python_file_finder_pipeline({
					-- to use ripgrep : {'rg', '--files'}
					-- to use fd      : {'fd', '-tf'}
					file_command = { "find", ".", "-type", "f", "-printf", "%P\n" },
					-- to use fd      : {'fd', '-td'}
					dir_command = { "find", ".", "-type", "d", "-printf", "%P\n" },
					-- use {'cpsm_filter'} for performance, requires cpsm vim plugin
					-- found at https://github.com/nixprime/cpsm
					filters = { "fuzzy_filter", "difflib_sorter" },
				})
			),
		})

		wilder.set_option(
			"renderer",
			wilder.popupmenu_renderer(wilder.popupmenu_border_theme({
				highlighter = {
					wilder.lua_pcre2_highlighter(), -- requires `luarocks install pcre2`
					wilder.lua_fzy_highlighter(), -- requires fzy-lua-native vim plugin found
					-- at https://github.com/romgrk/fzy-lua-native
				},
				highlights = {
					accent = wilder.make_hl(
						"WilderAccent",
						"Pmenu",
						{ { a = 1 }, { a = 1 }, { foreground = "#f4468f" } }
					),
				},
				-- highlighter = wilder.basic_highlighter(),
				-- highlights = {
				-- 	default = text_highlight,
				-- 	border = mauve_highlight,
				-- 	accent = mauve_highlight,
				-- },
				pumblend = 5,
				min_width = "80%",
				min_height = "25%",
				max_height = "25%",
				border = "rounded",
				prompt_position = "top",
				left = { " ", wilder.popupmenu_devicons() },
				right = { " ", wilder.popupmenu_scrollbar() },
			}))
		)
	end,
}
