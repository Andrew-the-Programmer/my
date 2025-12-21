return My.FiletypeConfig:new({
	pattern = "*.py",
	callback = function(ev)
		vim.opt.tabstop = 4
		vim.opt.shiftwidth = 4
	end,
})
