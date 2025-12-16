return {
	-- https://github.com/hedyhli/outline.nvim
	-- Symbols-outline plugin substitute
	"hedyhli/outline.nvim",
	config = function()
		require("outline").setup({
			symbols = {
				filter = {
					python = { "Function", "Class", "Method" },
				},
			},
		})
		-- symbols = filter = {
		--     default = { 'String', exclude=true },
		--     python = { 'Function', 'Class' },
		-- }
		vim.keymap.set("n", "<leader>to", "<cmd>Outline<CR>", { desc = "Toggle outline" })
	end,
}
