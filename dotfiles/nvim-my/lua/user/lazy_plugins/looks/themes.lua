return {
	{
		-- https://github.com/catppuccin/nvim
		"catppuccin/nvim",
		lazy = false,
		name = "catppuccin",
		priority = 1000,
		opts = {
			flavour = "frappe",
			transparent_background = true,
		},
		config = function()
			-- vim.cmd.colorscheme("catppuccin-frappe")
		end,
	},
	{
        -- https://github.com/shaunsingh/nord.nvim
		"shaunsingh/nord.nvim",
	},
	{
        -- https://github.com/andweeb/presence.nvim
		"dylanaraps/wal",
	},
}
