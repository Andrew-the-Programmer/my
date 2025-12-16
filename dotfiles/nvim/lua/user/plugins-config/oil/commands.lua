local M = {}

function M.StartOil()
	vim.cmd("Oil")
	vim.cmd("vsplit")
end

vim.api.nvim_create_user_command("StartOil", M.StartOil, { nargs = 0, desc = "Start oil file manager" })
