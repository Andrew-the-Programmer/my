return {
	-- https://github.com/goolord/alpha-nvim
	-- Fancy init screen
	"goolord/alpha-nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},

	config = function()
		return require("user.plugins-config.dashboards.my")
	end,
}
