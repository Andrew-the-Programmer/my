return {
	"ibhagwan/fzf-lua",
	-- optional for icon support
	dependencies = { "nvim-tree/nvim-web-devicons" },
	-- or if using mini.icons/mini.nvim
	-- dependencies = { "echasnovski/mini.icons" },
	config = function()
		local fzf = require("fzf-lua")
		fzf.setup()

		vim.keymap.set("n", "<leader>ff", function()
			fzf.files()
		end)
		vim.keymap.set("n", "<C-s>", function()
			local items = {
				"apple",
				"banana",
				"mango",
				"你好",
				"MaNgO",
				"ПрИвЕт",
			}
			fzf.fzf_live(function(query)
                local o = {}
                setmetatable(o, {__index=items})
                table.insert(o, 1, query)
				return items
			end, {
				actions = {
					["default"] = function(selected)
						print(selected[1])
					end,
				},
			})
		end)
	end,
}
