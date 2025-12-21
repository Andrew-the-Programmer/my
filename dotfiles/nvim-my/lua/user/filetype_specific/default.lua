return My.FiletypeConfig:new({
	pattern = "*",
	callback = function(ev)
		-- tabs & indentation
		vim.opt.tabstop = 4
		vim.opt.shiftwidth = 4

		My.opts.format_on_save = false

		-- vim.opt.wrap = false
		-- vim.opt.wrapmargin = 80
		-- vim.opt.textwidth = 80

		-- print("default")
	end,
})
