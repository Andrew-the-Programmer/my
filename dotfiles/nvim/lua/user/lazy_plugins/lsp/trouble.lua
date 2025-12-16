return {
	-- https://github.com/folke/trouble.nvim
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local trouble = require("trouble")

		vim.keymap.set("n", "<leader>tT", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Toggle diagnostics" })
		-- vim.keymap.set("n", "<leader>cq", "<cmd>Trouble qflist toggle<cr>", { desc = "Toggle quickfixlist" })

		trouble.setup({})
	end,
}
