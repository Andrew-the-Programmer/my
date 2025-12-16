local Keymap = My.keymaps.Keymap

local keymaps = {
	Keymap:new_nvim("v", "<localleader>s", function()
		local from, to = My.nvim.GetVisualSelection()
		print(from.col, to.col)
		local text = My.nvim.GetText(from, to)
		vim.ui.input({ prompt = "Tag and args: " }, function(input)
			local tag, args = string.match(input, "([a-z]+)(.*)")
			args = My.lua.IfNil(args, "")
			local prefix = ("<%s%s>"):format(tag, args)
			local suffix = ("</%s>"):format(tag)
			local new_text = prefix .. text .. suffix
			My.nvim.SubstituteText(new_text, from, to)
		end)
	end, { desc = "Surround" }),
}

return My.FiletypeConfig:new({
	pattern = "*.html",
	keymaps = keymaps,
	callback = function(ev)
		vim.opt.wrap = true
	end,
})
