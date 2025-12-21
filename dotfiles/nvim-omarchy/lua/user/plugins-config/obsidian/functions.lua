local M = {}

local obsidian = require("obsidian")
local util = require("obsidian.util")
local Path = require("obsidian.path")
local Note = require("obsidian.note")

function M.GetImgName(ext)
	local fig_name = vim.api.nvim_get_current_line()
	local time = tostring(os.time())
	if fig_name ~= "" then
		fig_name = time .. "-" .. fig_name
	else
		fig_name = time
	end
	fig_name = fig_name .. "." .. ext
	return fig_name
end

function M.PasteImgLink(fig_name)
	My.nvim.SetLine("![[" .. fig_name .. "]]")
end

function M.GetImgFolder()
	local path = require("obsidian.path")
	local client = obsidian.get_client()
	local img_folder = path.new(client.opts.attachments.img_folder)
	return img_folder
end

function M.GetImgCmd(fig_path)
	local cmd = "~/my/scripts/inkscape-figures/main.py"
	cmd = vim.fn.expand(cmd)
	local args = "-path"
	local final_cmd = cmd .. " " .. args .. " " .. My.lua.Surround(fig_path, '"')
	return final_cmd
end

function M.GetImgCmd_edit(fig_path)
	local img_cmd = M.GetImgCmd(fig_path)
	local args = "-edit"
	local final_cmd = img_cmd .. " " .. args
	return final_cmd
end

function M.GetImgCmd_new(fig_path)
	local img_cmd = M.GetImgCmd(fig_path)
	local args = "-create -edit"
	local final_cmd = img_cmd .. " " .. args
	return final_cmd
end

---@param fig_path obsidian.Path|string
function M.ImageEdit(fig_path)
	fig_path = Path.new(fig_path)
	local ext = fig_path.suffix
	if ext == ".svg" then
		local cmd = M.GetImgCmd_edit(fig_path.filename)
		My.nvim.SilentExecCmdInBackground(cmd)
	elseif ext == ".png" or ext == ".jpg" then
		local cmd = "pinta " .. fig_path.filename
		My.nvim.SilentExecCmdInBackground(cmd)
	end
end

function M.FindNote(func)
	local fzf = require("fzf-lua")
	local client = obsidian.get_client()
	local dict = {}
	local function contents(fzf_cb)
		coroutine.wrap(function()
			local co = coroutine.running()
			local notes = client:find_notes("*")
			My.nvim.Notify("Found " .. #notes .. " notes")
			-- My.lua.Print(notes)
			local function insert(str, note)
				fzf_cb(str, function()
					coroutine.resume(co)
				end)
				if dict[str] ~= nil then
					error("duplicate: " .. str)
				end
				dict[str] = note
				coroutine.yield()
			end
			local function format(name, id, str)
				return ("<%s:%s>%s"):format(name, tostring(id), str)
			end
			for id, note in pairs(notes) do
				insert(format("id", id, note.id), note)
				for _, alias in pairs(note.aliases) do
					insert(format("alias", id, alias), note)
				end
				for _, tag in pairs(note.tags) do
					insert(format("tag", id, tag), note)
				end
			end
			fzf_cb()
		end)()
	end

	fzf.fzf_exec(contents, {
		actions = {
			["default"] = function(selected)
				local label = selected[1]
				func(dict[label], label)
			end,
		},
	})
end

function M.LinkLabelBounds()
	local open, close, _ = util.cursor_on_markdown_link()
	if open == nil or close == nil then
		return
	end
	local line = My.nvim.GetLine()
	local link = line:sub(open, close)
	local path, label, link_type = util.parse_cursor_link()
	local search = require("obsidian.search")
	if link_type == search.RefTypes.WikiWithAlias then
		if label == nil then
			return
		end
		local a, b = line:find(label, open, true)
		return a, b
	elseif link_type == search.RefTypes.Wiki then
		return
	end
end

function M.GetImgLinkPath()
	if not util.cursor_on_markdown_link() then
		return
	end

	local client = obsidian.get_client()
	local img_folder = Path.new(client.opts.attachments.img_folder)
	if not img_folder:is_absolute() then
		img_folder = client.dir / img_folder
	end
	local search = require("obsidian.search")

	local path, _, link_type = util.parse_cursor_link()

	if link_type == search.RefTypes.Wiki then
		return img_folder / path
	elseif link_type == search.RefTypes.Markdown then
		return client.dir.filename .. "/" .. path
	else
		print("Unknown link type: " .. link_type)
	end
end

---@param path obsidian.Path
---@return obsidian.Note
function M.GetNote(path)
	return Note.from_file(path)
end

---@return string|nil
function M.GetLinkTitle()
	if not util.cursor_on_markdown_link() then
		return
	end
	local path, _, _ = util.parse_cursor_link()
	local client = obsidian.get_client()
	local note_path = client:new_note_path({ id = path })
	local note = M.GetNote(note_path)
	return note.title
end

return M
