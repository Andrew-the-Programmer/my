local M = {}

--- Check if a file or directory exists in this path
function M.FileExists(file)
	local ok, err, code = os.rename(file, file)
	return ok or code == 13
	-- if not ok then
	--     if code == 13 then
	--         -- Permission denied, but it exists
	--         return true
	--     end
	-- end
	-- return true
end

--- Check if a directory exists in this path
function M.IsDir(path)
	-- print("path: " .. path)
	-- "/" works on both Unix and Windows
	return M.FileExists(path)
end

function M.MakeFileExecutable(file)
	vim.cmd("silent execute '!chmod +x \"" .. file .. "\"'")
end

function M.ReadFile(path)
	local file = io.open(path, "rb")
	if not file then
		return nil
	end
	local content = file:read("*a")
	file:close()
	return content
end

function M.CopyFile(file, folder)
	local cmd = "cp -r " .. file .. " " .. folder
	local output = My.lua.GetCmdOutput(cmd)
	if output ~= "" then
		My.nvim.Notify("Could not copy file: " .. file .. " to folder: " .. folder .. "\n" .. output)
	end
end

function M.DeleteFile(file)
	local cmd = "rm -r " .. file
	local output = My.lua.GetCmdOutput(cmd)
	if output ~= "" then
		My.nvim.Notify("Could not delete file: " .. file .. "\n" .. output)
	end
end

function M.FileBaseName(file)
	return vim.fn.fnamemodify(file, ":t:r")
end

function M.FileExt(file)
	return vim.fn.fnamemodify(file, ":e")
end

function M.capture(cmd, raw)
	local f = assert(io.popen(cmd, "r"))
	local s = assert(f:read("*a"))
	f:close()
	if raw then
		return s
	end
	s = string.gsub(s, "^%s+", "")
	s = string.gsub(s, "%s+$", "")
	s = string.gsub(s, "[\n\r]+", " ")
	return s
end

return M
