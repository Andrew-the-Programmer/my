return My.FiletypeConfig:new({
	pattern = { "*.tex", "*.sty" },
	callback = function(ev)
		vim.opt.wrap = true
		vim.opt.tabstop = 2
		vim.opt.shiftwidth = 2
	end,
})
