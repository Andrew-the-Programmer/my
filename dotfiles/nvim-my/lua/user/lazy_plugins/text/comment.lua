return {
	-- https://github.com/numToStr/Comment.nvim
	"numToStr/Comment.nvim",
	dependencies = {
		-- worked badly
		"JoosepAlviste/nvim-ts-context-commentstring",
	},
	config = function()
		local api = require("Comment.api")
		local map = vim.keymap.set

		local opts = {
			-- Add a space b/w comment and the line
			padding = true,
			-- Whether the cursor should stay at its position
			sticky = true,
			-- Lines to be ignored while (un)comment
			ignore = nil,
			-- LHS of toggle mappings in NORMAL mode
			toggler = {
				-- Line-comment toggle keymap
				line = "<leader>gcc",
				-- Block-comment toggle keymap
				block = "<leader>gbc",
			},
			-- LHS of operator-pending mappings in NORMAL and VISUAL mode
			opleader = {
				-- Line-comment keymap
				line = "<leader>gc",
				-- Block-comment keymap
				block = "<leader>gb",
			},
			-- LHS of extra mappings
			extra = {
				-- Add comment on the line above
				above = "<leader>gcO",
				-- Add comment on the line below
				below = "<leader>gco",
				-- Add comment at the end of line
				eol = "<leader>gcA",
			},
			-- Enable keybindings
			-- NOTE: If given `false` then the plugin won't create any mappings
			mappings = {
				-- Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
				basic = true,
				-- Extra mapping; `gco`, `gcO`, `gcA`
				extra = true,
			},
			-- Function to call before (un)comment
			-- pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
			-- pre_hook = function()
			-- 	return vim.bo.commentstring
			-- end,
			pre_hook = nil,

			-- Function to call after (un)comment
			post_hook = nil,
		}

        -- This keymap only adds comment
		--[[ map({ "n" }, "<leader>c", function()
            -- local key = vim.api.nvim_replace_termcodes("gcc", true, false, true)
            -- vim.api.nvim_feedkeys(key, "n", false)
			api.comment.linewise.current()
		end, { desc = "Comment line" }) ]]

		require("Comment").setup(opts)
	end,
}
