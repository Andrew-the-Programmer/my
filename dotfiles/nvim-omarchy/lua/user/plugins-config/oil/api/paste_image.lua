local M = {}
local oip = require("user.plugins-config.obsidian.obsidian_img_paste")
local oil = require("oil")
local mo = My.oil
local Path = require("obsidian.path")
local util = require("obsidian.util")

function M.Id(n)
	local s = ""
	for _ = 1, n do
		s = s .. tostring(math.random(0, 9))
	end
	return s
end

---@return string
function M.UniqueFigName(fig_name)
	if fig_name == nil then
		local date = os.date("%d-%m-%y")
		local time = os.date("%H-%M-%S")
		local id = M.Id(3)
		return ("%s_%s_%s"):format(date, time, id)
	end
	return M.UniqueFigName() .. "_" .. fig_name
end

function M.Copy(src, dst)
	local cmd = ('cp "%s" "%s"'):format(src, dst)
	local suc = os.execute(cmd)
	if type(suc) == "number" and suc ~= 0 then
		error("Could not copy path to img")
	end
end

---@param opts { fname: string|?, path: obsidian.Path|string} Options.
function M.SaveImg(opts)
	local path = Path.new(opts.path)
	local fname = opts.fname

	if fname == nil then
		fname = M.UniqueFigName(path.name)
	end

	local suffix = Path.new(fname).suffix

	if not suffix then
		fname = fname .. path.suffix
	end

	local oil_cwd = oil.get_current_dir()
	local dst_file = Path.new(oil_cwd):joinpath(fname)

	M.Copy(path, dst_file)
end

function M.PasteImage(fig_name)
	local this_os = util.get_os()
	if not (this_os == util.OSType.Linux or this_os == util.OSType.FreeBSD) then
		error("image saving not implemented for OS '" .. this_os .. "'")
	end

	if oip.clipboard_is_img() then
		print("image found in clipboard")
		fig_name = M.UniqueFigName(fig_name)
		local tmp_file = Path.new(("/tmp/nvim_obsidian/%s.png"):format(fig_name))
		tmp_file:parent():mkdir({ exist_ok = true, parents = true })
		local cmd = ('xclip -selection clipboard -target image/png -o > "%s"'):format(tmp_file.filename)
		local suc = os.execute(cmd)
		if type(suc) == "number" and suc ~= 0 then
			error("Could not copy path to img")
		end
		M.SaveImg({ path = tmp_file, fname = fig_name })
		return
	end

	print("image NOT found in clipboard")

	local clipboard = vim.fn.getreg("+")
	local path_list = My.lua.Split(clipboard, "\n")
	for _, path in pairs(path_list) do
		M.SaveImg({ path = path })
	end
end

function M.CopyImage()
	local img = mo.functions.GetFullPathUnderCursor()
	vim.cmd(('!cat "%s" | xclip -selection clipboard -target image/png -i'):format(img))
end

return M
