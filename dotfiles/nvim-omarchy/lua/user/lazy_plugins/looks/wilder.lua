return {
	-- https://github.com/gelguy/wilder.nvim
	-- Better cmd prompt
	-- I have almost no idea how this config works, but it does look nice
	"gelguy/wilder.nvim",
	dependencies = {
		"romgrk/fzy-lua-native",
		"nixprime/cpsm",
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local wilder = require("wilder")
		wilder.setup({
			modes = { ":", "/", "?" },
			next_key = "<C-j>",
			previous_key = "<C-k>",
		})

		wilder.set_option("pipeline", {
			wilder.branch(
				wilder.python_file_finder_pipeline({
					file_command = function(ctx, arg)
						if string.find(arg, ".") ~= nil then
							return { "fd", "-tf", "-H" }
						else
							return { "fd", "-tf" }
						end
					end,
					dir_command = { "fd", "-td" },
					filters = { "cpsm_filter" },
				}),
				wilder.substitute_pipeline({
					pipeline = wilder.python_search_pipeline({
						skip_cmdtype_check = 1,
						pattern = wilder.python_fuzzy_pattern({
							start_at_boundary = 0,
						}),
					}),
				}),
				wilder.cmdline_pipeline({
					fuzzy = 2,
					fuzzy_filter = wilder.lua_fzy_filter(),
				}),
				{
					wilder.check(function(ctx, x)
						return x == ""
					end),
					wilder.history(),
				},
				wilder.python_search_pipeline({
					pattern = wilder.python_fuzzy_pattern({
						start_at_boundary = 0,
					}),
				})
			),
		})

		local highlighters = {
			wilder.pcre2_highlighter(),
			wilder.lua_fzy_highlighter(),
		}

		local theme_palette = require("catppuccin.palettes").get_palette("frappe")

		local text_highlight =
			wilder.make_hl("WilderText", { { a = 1 }, { a = 1 }, { foreground = theme_palette.text } })
		local mauve_highlight =
			wilder.make_hl("WilderMauve", { { a = 1 }, { a = 1 }, { foreground = theme_palette.mauve } })

		local highlights = {
			default = text_highlight,
			border = mauve_highlight,
			accent = mauve_highlight,
		}

		local popupmenu_renderer = wilder.popupmenu_renderer(wilder.popupmenu_border_theme({
			min_width = "100%",
			min_height = "25%",
			max_height = "25%",
			border = "rounded",
			prompt_position = "top",
			-- Transparent background (0 is none)
			pumblend = 10,
			empty_message = wilder.popupmenu_empty_message_with_spinner(),
			highlighter = highlighters,
			highlights = highlights,
			left = {
				" ",
				wilder.popupmenu_devicons(),
				wilder.popupmenu_buffer_flags({
					flags = " a + ",
					icons = { ["+"] = "", a = "", h = "" },
				}),
			},
			right = {
				" ",
				wilder.popupmenu_scrollbar(),
			},
		}))

		local wildmenu_renderer = wilder.wildmenu_renderer({
			highlighter = highlighters,
			separator = " · ",
			left = { " ", wilder.wildmenu_spinner(), " " },
			right = { " ", wilder.wildmenu_index() },
		})

		wilder.set_option(
			"renderer",
			wilder.renderer_mux({
				[":"] = popupmenu_renderer,
				["/"] = wildmenu_renderer,
				substitute = wildmenu_renderer,
			})
		)
	end,
}
