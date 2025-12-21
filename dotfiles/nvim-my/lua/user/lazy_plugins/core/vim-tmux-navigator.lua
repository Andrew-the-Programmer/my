return {
	-- https://github.com/christoomey/vim-tmux-navigator
	"christoomey/vim-tmux-navigator",
	config = function()
		vim.g.tmux_navigator_no_mappings = 1
		vim.keymap.set("n", "<C-h>", "<cmd>TmuxNavigateLeft<CR>", { silent = true })
		vim.keymap.set("n", "<C-j>", "<cmd>TmuxNavigateDown<CR>", { silent = true })
		vim.keymap.set("n", "<C-k>", "<cmd>TmuxNavigateUp<CR>", { silent = true })
		vim.keymap.set("n", "<C-l>", "<cmd>TmuxNavigateRight<CR>", { silent = true })
	end,
}
