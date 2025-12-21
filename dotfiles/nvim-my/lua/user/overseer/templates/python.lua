---@type Term
local python_term = My.term.TermExecute:new({
	display_name = "python terminal",
})

return {
	name = "python",
	builder = function()
		local file = My.nvim.File()

		local args = {
			"python",
			file,
		}
		local cmd = ""

		for _, v in pairs(args) do
			cmd = cmd .. " " .. v
		end

        python_term:ChangeDir(My.nvim.Dir())
        python_term:Send(cmd)

		return {
			name = "Done",
			cmd = { "echo" },
			args = { "Done" },
		}
	end,
	condition = {
		filetype = { "python" },
		-- dir = vim.fn.getcwd(),
	},
}
