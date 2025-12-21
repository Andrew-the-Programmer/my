return {
	"Exafunction/windsurf.vim",
	config = function()
		-- vim.g.codeium_disable_bindings = 1
		-- vim.g.codeium_enabled = false
		-- vim.g.codeium_manual = true
		-- vim.g.codeium_render = true

		vim.keymap.set("i", ";;", function()
			return vim.fn["codeium#Accept"]()
		end, { expr = true, silent = true })

		vim.keymap.set("i", "::", function()
			return vim.fn["codeium#Clear"]()
		end, { expr = true, silent = true })

		vim.keymap.set("i", "<A-'>", function()
			return vim.fn["codeium#CycleCompletions"](1)
		end, { expr = true, silent = true })

		vim.keymap.set("i", '<A-">', function()
			return vim.fn["codeium#CycleCompletions"](-1)
		end, { expr = true, silent = true })
	end,
}
