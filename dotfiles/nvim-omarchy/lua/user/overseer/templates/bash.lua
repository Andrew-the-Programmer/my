---@type Term
local bash_term = My.term.TermExecute:new({
	display_name = "bash terminal",
})

return {
	name = "bash",
	builder = function()
		local file = My.nvim.File()

		local args = {
			"bash",
			file,
		}
		local cmd = ""

		for _, v in pairs(args) do
			cmd = cmd .. " " .. v
		end

		bash_term:ChangeDir(My.nvim.Dir())
		bash_term:Send(cmd)

		return {
			name = "Done",
			cmd = { "echo" },
			args = { "Done" },
		}
	end,
	condition = {
		filetype = { "bash", "sh" },
		-- dir = vim.fn.getcwd(),
	},
}
