local Keymap = My.keymaps.Keymap

return {
	"Exafunction/windsurf.vim",
	config = function()
		vim.g.codeium_disable_bindings = 1
		-- vim.g.codeium_enabled = false
		-- vim.g.codeium_manual = true
		-- vim.g.codeium_render = true

		local keymaps = {
			Keymap:new_nvim("i", { ";;", "жж" }, function()
				return vim.fn["codeium#Accept"]()
			end, { desc = "Codeium: accept", expr = true, silent = true }),
			-- Keymap:new_nvim("i", { "::", "ЖЖ" }, function()
			-- 	return vim.fn["codeium#Clear"]()
			-- end, { desc = "Codeium: clear", expr = true, silent = true }),
			Keymap:new_nvim("i", { "<A-'>", "<A-э>" }, function()
				return vim.fn["codeium#CycleCompletions"](1)
			end, { desc = "Codeium: next", expr = true, silent = true }),
			Keymap:new_nvim("i", { '<A-">', "<A-Э>" }, function()
				return vim.fn["codeium#CycleCompletions"](-1)
			end, { desc = "Codeium: prev", expr = true, silent = true }),
		}

		for _, keymap in ipairs(keymaps) do
			keymap:Add()
		end
	end,
}
