return {
	"kristijanhusak/vim-dadbod-ui",
	dependencies = {
		{ "tpope/vim-dadbod", lazy = true },
		{
			-- also see nvim-cmp
			"kristijanhusak/vim-dadbod-completion",
			dependencies = { "hrsh7th/nvim-cmp" },
			ft = { "sql", "mysql", "plsql" },
			lazy = true,
		},
	},
	config = function()
		vim.g.db_ui_use_nerd_fonts = 1
		vim.keymap.set("n", "<leader>td", "<cmd>DBUIToggle<CR>", { desc = "toggle DB UI" })

		local function db_completion()
			require("cmp").setup.buffer({ sources = { { name = "vim-dadbod-completion" } } })
		end

		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "sql", "mysql", "plsql" },
			callback = function()
				vim.schedule(db_completion)
			end,
		})
	end,
}
