local obsidian = require("obsidian")
local util = require("obsidian.util")

return {
	-- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
	["gf"] = {
		action = function()
			return obsidian.util.gf_passthrough()
		end,
		opts = { noremap = false, expr = true, buffer = true },
	},
	-- Smart action depending on context, either follow link or toggle checkbox.
	["<CR>"] = {
		action = function()
			return util.smart_action()
		end,
		opts = { buffer = true, expr = true },
	},
	["<leader>oo"] = {
		action = function()
			return "<cmd>ObsidianOpen<CR>"
		end,
		opts = { buffer = true, expr = true, desc = "Open Obsidian" },
	},
	["<leader>os"] = {
		action = function()
			return "<cmd>ObsidianSearch<CR>"
		end,
		opts = { buffer = true, expr = true, desc = "Search for obsidian note" },
	},
	["<leader>ot"] = {
		action = function()
			return "<cmd>ObsidianTemplate<CR>"
		end,
		opts = { buffer = true, expr = true, desc = "Insert Obsidian template" },
	},
	["<leader>ol"] = {
		action = function()
			return "<cmd>ObsidianLink .<CR>"
		end,
		opts = { buffer = true, expr = true, desc = "Insert Obsidian template" },
	},
	--- keymap for markdown
	["<localleader>mn"] = {
		action = function()
			local n = vim.fn.input("Number of lines: ")
			local row, _ = My.nvim.GetCursorPos()
			for i = 0, n - 1 do
				local cur_row = row + i
				My.nvim.PrependText(i + 1 .. ". ", { line_number = cur_row })
			end
		end,
		opts = { buffer = true, desc = "Add numbered list" },
	},
	["<localleader>mh"] = {
		action = function()
            local line = My.nvim.GetLine()
            if not line:match("^#.*") then
                My.nvim.PrependText("# ")
                return
            end
            My.nvim.PrependText("#")
		end,
		opts = { buffer = true, desc = "Add numbered list" },
	},
	["<localleader>ma"] = {
		action = function()
            local line = My.nvim.GetLine()
            if not line:match("^#.*") then
                My.nvim.PrependText("# ")
                return
            end
            My.nvim.PrependText("#")
		end,
		opts = { buffer = true, desc = "Add numbered list" },
	}
}
