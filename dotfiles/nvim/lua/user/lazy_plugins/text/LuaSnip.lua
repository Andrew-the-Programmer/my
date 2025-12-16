return {
	{
		"mireq/luasnip-snippets",
		dependencies = { "L3MON4D3/LuaSnip" },
		init = function()
			-- Mandatory setup function
			-- require("luasnip_snippets.common.snip_utils").setup()
		end,
	},
	{
		-- https://github.com/L3MON4D3/LuaSnip
		"L3MON4D3/LuaSnip",
		version = "v2.*",
		build = "make install_jsregexp",
		dependencies = {
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
		},
	},
}
