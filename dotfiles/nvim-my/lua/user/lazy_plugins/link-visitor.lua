return {
	"xiyaowong/link-visitor.nvim",
	config = function()
		local link_visitor = require("link-visitor")
		link_visitor.setup()

		-- vim.keymap.set("n", "gx", link_visitor.link_under_cursor, { desc = "Visit nearest linend" })

		-- Integration with coc.nvim
		vim.api.nvim_create_autocmd("User", {
			callback = function()
				local ok, buf = pcall(vim.api.nvim_win_get_buf, vim.g.coc_last_float_win)
				if ok then
					vim.keymap.set("n", "gx", function()
						link_visitor.link_under_cursor()
					end, { buffer = buf })
					vim.keymap.set("n", "gX", function()
						link_visitor.link_near_cursor()
					end, { buffer = buf })
				end
			end,
			pattern = "CocOpenFloat",
		})
	end,
}
