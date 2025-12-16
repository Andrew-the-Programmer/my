local M = {}
local util = require("obsidian.util")
local run_job = require("obsidian.async").run_job
local obsidian = require("obsidian")
local Path = require("obsidian.path")
local oip = require("user.plugins-config.obsidian.obsidian_img_paste")

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
	Path.new(dst):parent():mkdir({ exist_ok = true, parents = true })
	local cmd = ('cp "%s" "%s"'):format(src, dst)
	local suc = os.execute(cmd)
	if type(suc) == "number" and suc ~= 0 then
		error("Could not copy path to img")
	end
end

---@param opts { fname: string|?, path: obsidian.Path|string} Options.
function M.SaveImg(opts)
	local client = obsidian.get_client()
	local img_folder = Path.new(client.opts.attachments.img_folder)
	if not img_folder:is_absolute() then
		img_folder = client.dir / client.opts.attachments.img_folder
	end

	local path = Path.new(opts.path)
	local fname = opts.fname

	if fname == nil then
		fname = M.UniqueFigName(path.name)
	end

	local suffix = Path.new(fname).suffix

	if not suffix then
		fname = fname .. path.suffix
	end

	local dst_file = Path.new(img_folder):joinpath(fname)

	M.Copy(path, dst_file)

	util.insert_text(client.opts.attachments.img_text_func(client, dst_file))
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
		My.nvim.InsertLine("")
		My.nvim.GoDown()
	end
end

return M
