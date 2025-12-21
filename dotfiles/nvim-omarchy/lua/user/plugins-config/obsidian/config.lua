local obsidian = require("obsidian")
local Path = require("obsidian.path")

vim.g.vim_markdown_math = 1
vim.opt.conceallevel = 2

-- Optional, customize how note IDs are generated given an optional title.
---@param title string|?
---@return string
local function note_id_func(title)
	local suffix = ""
	if title ~= nil then
		-- If title is given, transform it into valid file name.
		suffix = title
		suffix = suffix:gsub(" ", "-")
		-- suffix = suffix:gsub("[^A-Za-z0-9-]", "")
		suffix = suffix:lower()
	else
		-- If title is nil, just add 4 random uppercase letters to the suffix.
		for _ = 1, 4 do
			suffix = suffix .. string.char(math.random(65, 90))
		end
	end
	local id = math.random(100, 999)
	return id .. "-" .. suffix
end

local mappings = require("user.plugins-config.obsidian.keymaps")

local status, workspaces = pcall(require, "user.plugins-config.obsidian.workspaces")
if not status then
    return nil
end

local opts = {
	-- would be cool if it frontmattered new nodes
	disable_frontmatter = false,
	workspaces = workspaces,
	-- notes_subdir = "notes",
	completion = {
		nvim_cmp = true,
		-- Trigger completion at 2 chars.
		min_chars = 2,
	},
	mappings = mappings,
	new_notes_location = "new_notes",
	note_id_func = note_id_func,
}

obsidian.setup(opts)
