local mt = My.term
local mo = My.oil
local oil = require("oil")

local M = {}

function M.GetProperCwd()
	local cwd = vim.fn.getcwd()
	if vim.bo.filetype == "oil" then
		cwd = oil.get_current_dir()
		if cwd == nil then
			error("Could not get oil cwd")
		end
	end
	return cwd
end

function M.GetFilenameUnderCursor()
	local entry = oil.get_cursor_entry()
	if not entry then
		return
	end
	local filename = entry.name
	return filename
end

function M.GetShortPathUnderCursor()
	local filename = M.GetFilenameUnderCursor()
	return "./" .. filename
end

function M.GetFullPathUnderCursor()
	local filename = M.GetFilenameUnderCursor()
	local cwd = oil.get_current_dir()
	return cwd .. filename
end

function M.OpenOil(dir)
	vim.cmd("Oil " .. dir)
end

function M.OpenOilInNvimCwd()
	local cwd = vim.fn.getcwd()
	M.OpenOil(cwd)
end

function M.MakeFileUnderCursorExecutable()
	local filepath = M.GetFullPathUnderCursor()
	My.sys.MakeFileExecutable(filepath)
end

return M
