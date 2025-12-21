return My.FiletypeConfig:new({
	pattern = "*.cpp",
	callback = function(ev)
		vim.opt.tabstop = 2
		vim.opt.shiftwidth = 2
	end,
})
