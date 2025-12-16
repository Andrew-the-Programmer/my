return My.FiletypeConfig:new({
	pattern = "*.lua",
	callback = function(ev)
		vim.opt.tabstop = 4
		vim.opt.shiftwidth = 4
	end,
})
