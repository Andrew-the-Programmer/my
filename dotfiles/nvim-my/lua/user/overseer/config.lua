local overseer = require("overseer")

local M = {}

function M.RegisterTemplates()
	local templates_folder = { "user", "overseer", "templates" }
	local ls_cmd = "ls " .. "~/.config/nvim/lua/" .. table.concat(templates_folder, "/")
	for t in io.popen(ls_cmd):lines() do
		t = My.sys.FileBaseName(t)
		t = table.concat(templates_folder, ".") .. "." .. t
		overseer.register_template(require(t))
	end
end

M.RegisterTemplates()

vim.keymap.set("n", "<leader>cx", overseer.run_template, { desc = "Run action" })

return M
