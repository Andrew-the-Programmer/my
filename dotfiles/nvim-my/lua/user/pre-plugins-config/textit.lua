-- Split buffer text by cursor position and match first part with lhs and
-- second part with rhs
---@param lhs string
---@param rhs string
local function Rule(lhs, rhs)
	local pos = My.nvim.GetCursorPos()
	local first = My.nvim.GetText(My.nvim.BufBeginPos(), pos)
	local second = My.nvim.GetText(pos, My.nvim.BufEndPos())
	-- print(My.lua.Surround(first, "'"), My.lua.Surround(second, "'"))
	return first:match(lhs) and second:match(rhs)
end

vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
	callback = function()
		local synstack = My.nvim.get_synstack()

		if not My.lua.ListFind(synstack, "texMathText") then
			return
		end

		vim.cmd([[
syntax region texMathTextInTextit start=/\\textit{/ end=/}/ contains=texMathText
hi link texMathTextInTextit Special
]])

		vim.cmd([[
syntax match CustomMathTextConcArg /\\\(textit\){[^}]*}/
]])
	end,
})
