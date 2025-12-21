return {
	-- https://github.com/rmagatti/auto-session
	"rmagatti/auto-session",
	lazy = false,

	config = function()
		local as = require("auto-session")
        vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

		as.setup({})

		vim.keymap.set("n", "<leader>sS", require("auto-session.session-lens").search_session)
		vim.keymap.set("n", "<leader>ss", as.SaveSession)
		vim.keymap.set("n", "<leader>sr", as.RestoreSession)

		-- as.RestoreSession()
	end,
}
