local oil = require("oil")
local mo = My.oil

local keymaps = {
	["g?"] = "actions.show_help",
	["<CR>"] = { "actions.select", opts = { close = false }, desc = "Open" },
	["<C-s>"] = { "actions.select", opts = { vertical = true }, desc = "Open the entry in a vertical split" },
	["<C-S>"] = {
		"actions.select",
		opts = { horizontal = true },
		desc = "Open the entry in a horizontal split",
	},
	["<C-t>"] = { "actions.select", opts = { tab = true }, desc = "Open the entry in new tab" },
	["<C-c>"] = "actions.close",
	["<C-R>"] = "actions.refresh",
	["<A-h>"] = "actions.parent",
	["<A-l>"] = { "actions.select", opts = { close = false }, desc = "Open" },
	["-"] = "actions.parent",
	["_"] = "actions.open_cwd",
	["`"] = {
		function()
			print(oil.get_current_dir())
		end,
		desc = "Print oil cwd",
	},
	["~"] = { My.oil.functions.OpenOilInNvimCwd, desc = "Cd to nvim cwd" },

	["<localleader>ox"] = {
		"actions.open_external",
		desc = "Open the file in an external program",
	},
	["<localleader>th"] = {
		"actions.toggle_hidden",
		desc = "Toggle hidden files",
	},
	["<localleader>tr"] = {
		"actions.toggle_trash",
		desc = "Toggle trash",
	},
	["<localleader>tp"] = {
		"actions.preview",
		desc = "Toggle preview",
	},

	["<localleader>gp"] = {
		"actions.parent",
		desc = "Go to parent directory",
	},

	["<localleader>ss"] = {
		"actions.change_sort",
		desc = "Change sort order",
	},
	["<localleader>sn"] = {
		"actions.change_sort",
		opts = {
			sort = {
				{ "type", "asc" },
				{ "name", "asc" },
			},
		},
		desc = "Sort by type->name",
	},
	["<localleader>sl"] = {
		"actions.change_sort",
		opts = {
			sort = {
				{ "type", "asc" },
				{ "mtime", "desc" },
				{ "name", "asc" },
			},
		},
		desc = "Sort by type->mtime->name",
	},
	["<leader>te"] = {
		function()
			mo.term.oil_term:ExecuteFile()
		end,
		desc = "Execute file under cursor",
	},
	["<leader>tt"] = {
		function()
			mo.term.oil_term:OpenFromOil()
		end,
		desc = "Open terminal",
	},

	["<leader>bx"] = {
		mo.functions.MakeFileUnderCursorExecutable,
		desc = "Make file under cursor executable",
		silent = false,
	},
	["<localleader>Id"] = {
		function()
			oil.set_columns({ "icon", "permissions", "size", "mtime" })
		end,
		desc = "Set columns to detailed",
	},
	["<localleader>Ic"] = {
		function()
			oil.set_columns({ "icon" })
		end,
		desc = "Set columns to compact",
	},
	["<localleader>ip"] = {
		function()
			mo.img_paste.PasteImage()
		end,
		desc = "Paste image from clipboard",
	},
	["<localleader>ic"] = {
		function()
			mo.img_paste.CopyImage()
		end,
		desc = "Paste image from clipboard",
	},
	-- ["<localleader>:"] = {
	-- 	"actions.open_cmdline",
	-- 	opts = {
	-- 		shorten_path = true,
	-- 		modify = ":h",
	-- 	},
	-- 	desc = "Open the command line with the current directory as an argument",
	-- },
}

return keymaps
