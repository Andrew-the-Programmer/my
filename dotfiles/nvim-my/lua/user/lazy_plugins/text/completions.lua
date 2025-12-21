return {
	-- https://github.com/hrsh7th/nvim-cmp
	"hrsh7th/nvim-cmp",
	event = { "BufReadPost", "BufNewFile" },
	dependencies = {
		-- LSP
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-nvim-lsp-signature-help",
		"folke/lazydev.nvim",
		-- This tiny plugin adds vscode-like pictograms to neovim built-in lsp
		"onsails/lspkind.nvim",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",

		-- AI
		"Exafunction/windsurf.nvim",
		"zbirenbaum/copilot-cmp",
		"Exafunction/windsurf.nvim",

		-- Snippets
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
		-- "SirVer/ultisnips",
		-- {
		-- 	"quangnguyen30192/cmp-nvim-ultisnips",
		-- 	dependencies = { "SirVer/ultisnips" },
		-- 	opts = {},
		-- },
	},
	config = function()
		local cmp = require("cmp")

		-- local cmp_autopairs = require("nvim-autopairs.completion.cmp")
		-- -- Integrate nvim-autopairs with cmp
		-- cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

		local lspkind = require("lspkind")

		cmp.setup({
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			},
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
			completion = { completeopt = "menu,menuone,noinsert" },
			mapping = {
				-- Works with telescope
				["<C-k>"] = cmp.mapping.select_prev_item(),
				["<C-j>"] = cmp.mapping.select_next_item(),
				["<C-l>"] = cmp.mapping.confirm({ select = true }),
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-h>"] = cmp.mapping.abort(),
			},

			sources = {
				-- Snippets
				{
					name = "luasnip",
					priority = 100,
				},
				-- {
				-- 	name = "ultisnips",
				-- priority = 100,
				-- },
				-- },
				-- -- LSP
				-- {
				{
					name = "nvim_lsp",
					priority = 90,
				},
				{
					name = "lazydev",
					priority = 90,
				},
				{
					name = "vim-dadbod-completion",
					priority = 90,
				},
				{
					name = "nvim-lsp-signature-help",
					priority = 90,
				},
				-- },
				-- -- Local
				-- {
				{
					name = "buffer",
					priority = 80,
				},
				{
					name = "path",
					priority = 80,
				},
				-- },
				-- -- AI
				-- {
				-- Codeium is shit and don't work
				{
					name = "codeium",
					max_item_count = 3,
					priority = 50,
				},
				-- Don't have copilot, too broke 😭
				-- {
				-- 	name = "copilot",
				-- 	max_item_count = 3,
				-- },
			},

			-- Enable pictogram icons for lsp/autocompletion
			formatting = {
				expandable_indicator = true,
				format = lspkind.cmp_format({
					mode = "symbol_text",
					maxwidth = 50,
					ellipsis_char = "...",
					menu = {
						ultisnips = "[UltiSnips]",
						luasnip = "[LuaSnip]",
						nvim_lsp = "[LSP]",
						buffer = "[Buffer]",
						path = "[PATH]",
						lazydev = "[LazyDev]",
						copilot = "[Copilot]",
					},
				}),
			},
			experimental = {
				ghost_text = false,
			},
		})
	end,
}
