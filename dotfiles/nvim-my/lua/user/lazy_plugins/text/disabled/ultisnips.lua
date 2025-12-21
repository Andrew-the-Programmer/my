return {
	-- https://github.com/SirVer/ultisnips
	"SirVer/ultisnips",
	config = function()
		-- vim.g.UltiSnipsExpandTrigger = "<C-y>"

		-- Somehow works: <C-j/k>, see cmp config
		-- vim.g.UltiSnipsJumpForwardTrigger = "<C-n>"
		-- vim.g.UltiSnipsJumpBackwardTrigger = "<C-p>"

		vim.g.UltiSnipsSnippetDirectories = { "UltiSnips", "UltiSnips-my", "UltiSnips-vsnip" }
	end,
	opts = {},
}
