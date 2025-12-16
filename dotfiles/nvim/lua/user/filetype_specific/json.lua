return My.FiletypeConfig:new({
	pattern = "*.json",
	callback = function(ev)
		vim.opt.tabstop = 2
		vim.opt.shiftwidth = 2
	end,
})
