return {
	-- https://github.com/nvim-lualine/lualine.nvim
	-- Status line at the bottom
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		-- "rmagatti/auto-session",
	},
	config = function()
		-- For harppon integration
		-- Adds a harpoon info to lualine
		-- See lualine.setup.sections.lualine_b
		local harpoon = require("harpoon.mark")
		local function harpoon_component()
			local total_marks = harpoon.get_length()

			if total_marks == 0 then
				return ""
			end

			local current_mark = "󰢤"

			local mark_idx = harpoon.get_current_index()
			if mark_idx ~= nil then
				current_mark = tostring(mark_idx)
			end

			return string.format("󰛃 %s|%d", current_mark, total_marks)
		end

		function ibus_component()
			return My.ibus.ibus_emoji()
		end

		require("lualine").setup({
			options = {
				theme = "catppuccin",
				globalstatus = true,
				-- component_separators = { left = "", right = "" },
				-- section_separators = { left = "█", right = "█" },
			},
			sections = {
				lualine_b = {
					ibus_component,
					{ "branch", icon = "" },
					harpoon_component,
					-- require("auto-session.lib").current_session_name,
					"diff",
					"diagnostics",
				},
				lualine_c = {
					"filename",
				},
				lualine_x = {
					"filetype",
				},
			},
		})
	end,
}
