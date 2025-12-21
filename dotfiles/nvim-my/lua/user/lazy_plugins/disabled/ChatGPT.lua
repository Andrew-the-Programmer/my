return {
	"jackMort/ChatGPT.nvim",
	event = "VeryLazy",
	dependencies = {
		"MunifTanjim/nui.nvim",
		"nvim-lua/plenary.nvim",
		"folke/trouble.nvim", -- optional
		"nvim-telescope/telescope.nvim",
	},
	config = function()
		require("chatgpt").setup({
			-- api_key_cmd = "pass show openai/chatgpt.nvim",
			api_key_cmd = "pass show openai/chatgpt.nvim",
		})
	end,
}
