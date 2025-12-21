local Keymap = My.keymaps.Keymap

local function New(o)
	return Keymap:new_nvim(o.mode, o.lhs, o.rhs, o.opts)
end

---@type Keymap[]
local keymaps = {
	New({
		lhs = "<localleader>me",
		mode = "n",
		rhs = function()
			local n = vim.fn.input("Number of lines: ")
			local row, _ = My.nvim.GetCursorPos():unpack()
			for i = 0, n - 1 do
				local cur_row = row + i
				My.nvim.PrependText(i + 1 .. ". ", { line_number = cur_row })
			end
		end,
		opts = { desc = "Enumerate" },
	}),
	New({
		lhs = "<localleader>mi",
		mode = "n",
		rhs = function()
			local n = vim.fn.input("Number of lines: ")
			local row, _ = My.nvim.GetCursorPos():unpack()
			for i = 0, n - 1 do
				local cur_row = row + i
				My.nvim.PrependText("- ", { line_number = cur_row })
			end
		end,
		opts = { desc = "Itemize" },
	}),
	New({
		lhs = "<localleader>mh",
		mode = "n",
		rhs = function()
			local line = My.nvim.GetLine()
			if not line:match("^#.*") then
				My.nvim.PrependText("# ")
				return
			end
			My.nvim.PrependText("#")
		end,
		opts = { desc = "Header" },
	}),
	New({
		lhs = "<localleader>mu",
		mode = "v",
		rhs = function()
			local visual_selection = My.nvim.get_visual_selection_text()
			if not visual_selection then
				return
			end
			local vs_text = table.concat(visual_selection, "\n")
			My.nvim.SubstituteVisualSelection(([[***%s***]]):format(vs_text))
			My.nvim.EnterNormalMode()
		end,
		opts = { desc = "Abbreviation" },
	}),
	New({
		lhs = "<localleader>ms",
		mode = "v",
		rhs = function()
			local from, to = My.nvim.GetVisualSelection()
			local text = My.nvim.GetText(from, to)
			vim.ui.input({ prompt = "Tag and args: " }, function(input)
				local tag, args = string.match(input, "([a-z]+)(.*)")
				args = My.lua.IfNil(args, "")
				local prefix = ("<%s%s>"):format(tag, args)
				local suffix = ("</%s>"):format(tag)
				local new_text = prefix .. text .. suffix
				My.nvim.SubstituteText(new_text, from, to)
			end)
		end,
		opts = { desc = "Surround" },
	}),
	New({
		lhs = "<localleader>ma",
		mode = "v",
		rhs = function()
			local from, to = My.nvim.GetVisualSelection()
			local text = My.nvim.GetText(from, to)
			vim.ui.input({ prompt = "Title: " }, function(input)
				local tag = "abbr"
				local title = input
				title = My.lua.IfNil(title, "")
				local prefix = ("<%s title='%s'>"):format(tag, title)
				local suffix = ("</%s>"):format(tag)
				local new_text = prefix .. text .. suffix
				My.nvim.SubstituteText(new_text, from, to)
			end)
		end,
		opts = { desc = "Abbreviation" },
	}),
}

return My.FiletypeConfig:new({
	pattern = "*.md",
	keymaps = keymaps,
	callback = function(ev)
		vim.opt.wrap = true
        -- print("markdown")
	end,
})
