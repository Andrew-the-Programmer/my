return {
	-- https://github.com/nvim-treesitter/nvim-treesitter
	"nvim-treesitter/nvim-treesitter",
	dependencies = {
		"latex-lsp/tree-sitter-latex",
	},
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.configs").setup({
			-- A list of parser names, or "all"
			-- ignore_install = { "latex" },
			ensure_installed = {
				"c",
				"cpp",
				"javascript",
				"typescript",
				"lua",
				"rust",
				"bash",
				"latex",
				"json",
				"vim",
				"markdown",
				"sql",
				"python",
				"latex",
			},

			sync_install = true,
			auto_install = true,

			indent = {
				enable = true,
				disable = { "latex" },
			},

			highlight = {
				enable = true,
				-- Ultisnips stop working in markdown
				disable = { "latex" },
				additional_vim_regex_highlighting = { "latex", "markdown" },
				-- additional_vim_regex_highlighting = { "latex" },
			},
		})
	end,
}
