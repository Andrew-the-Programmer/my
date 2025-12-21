local opts = {
	default_file_explorer = true,
	columns = {
		"icon",
		-- "permissions",
		-- "size",
		-- "mtime",
	},
	delete_to_trash = true,
	skip_confirm_for_simple_edits = false,
	prompt_save_on_select_new_entry = true,
	-- Set to true to watch the filesystem for changes and reload oil
	watch_for_changes = false,
	use_default_keymaps = false,
	view_options = {
		-- Show files and directories that start with "."
		show_hidden = false,
		-- This function defines what is considered a "hidden" file
		is_hidden_file = function(name, bufnr)
			return vim.startswith(name, ".") or name == "__pycache__"
		end,
		-- This function defines what will never be shown, even when `show_hidden` is set
		is_always_hidden = function(name, bufnr)
			return name == ".."
		end,
		sort = {
			{ "type", "asc" },
			{ "name", "asc" },
			{ "mtime", "desc" },
		},
	},
}

opts["keymaps"] = require("user.plugins-config.oil.keymaps")

return opts
