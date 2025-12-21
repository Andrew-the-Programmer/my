return {
	"folke/persistence.nvim",
	event = "BufReadPre",
	opts = {},
	config = function()
		local ps = require("persistence")

		vim.keymap.set("n", "<leader>sL", function()
			ps.load()
		end)

		vim.keymap.set("n", "<leader>ss", function()
            ps.save()
		end)

		-- select a session to load
		vim.keymap.set("n", "<leader>sS", function()
			ps.select()
		end)

		-- load the last session
		vim.keymap.set("n", "<leader>sl", function()
			ps.load({ last = true })
		end)

		-- stop Persistence => session won't be saved on exit
		vim.keymap.set("n", "<leader>sd", function()
			ps.stop()
		end)
	end,
}
