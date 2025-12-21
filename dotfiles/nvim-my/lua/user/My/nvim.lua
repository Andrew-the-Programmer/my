local M = {}

function M.Notify(msg)
	vim.notify(msg, vim.log.levels.INFO)
end

---@class Pos
---@field row integer
---@field col integer
M.Pos = {}

function M.Pos:new(row, col)
	local o = {}
	o.row = row
	o.col = col
	self.__index = self
	o = setmetatable(o, self)
	return o
end

function M.Pos:move(pos)
	return M.Pos:new(self.row + pos.row, self.col + pos.col)
end

function M.Pos:move_col(i)
	return self:move(M.Pos:new(0, i))
end

function M.Pos:move_row(i)
	return self:move(M.Pos:new(i, 0))
end

function M.Pos:unpack()
	return self.row, self.col
end

---@deprecated
function M.Execute(list_of_functions)
	list_of_functions = list_of_functions or {}

	if #list_of_functions == 0 then
		return
	end

	local first_func = table.remove(list_of_functions, 1)

	vim.defer_fn(function()
		first_func()
		M.Execute(list_of_functions)
	end, 0)
end

function M.GetBufFile(buf)
	buf = buf or vim.api.nvim_get_current_buf()
	local file = vim.api.nvim_buf_get_name(buf)
	return file
end

function M.MakeBufExecutable(buf)
	local file = M.GetBufFile(buf)
	local cmd = "!chmod +x " .. My.lua.Surround(file, '"')
	vim.cmd(cmd)
end

---@param cmd string
function M.SilentExecCmdInBackground(cmd)
	vim.cmd("silent exec " .. My.lua.Surround("!tmux new -d " .. My.lua.Surround(cmd, '"'), "'"))
end

---@param cmd string
function M.ExecCmd(cmd)
	vim.cmd("exec " .. My.lua.Surround("!" .. cmd, "'"))
end

--- @param expr string see vim.fn.getpos
---@return Pos
function M.GetPos(expr)
	local _, row, col = unpack(vim.fn.getpos(expr))
	return M.Pos:new(row, col)
end

---@return Pos
function M.GetCursorPos()
	return M.GetPos(".")
end

---@param pos Pos
function M.SetCursor(pos)
	-- vim.fn.setpos(".", { 0, pos[1], pos[2], 0 })
	vim.fn.cursor(pos.row, pos.col)
end

---@param pos Pos
function M.MoveCursor(pos)
	M.SetCursor(M.GetCursorPos():move(pos))
end

---@return Pos, Pos
function M.GetVisualSelection()
	local s, e = M.GetPos("v"), M.GetPos(".")
	if s.row > e.row or (s.row == e.row and s.col > e.col) then
		s, e = e, s
	end
	if vim.fn.mode() == "V" then
		return M.Pos:new(s.row, 1), M.Pos:new(e.row, M.GetLine(e.row):len())
	end
	-- For Chinese symbols (idk)
	local function CharIsStrange(char)
		if string.len(char) == 0 then
			return true
		end
		local byte = string.byte(char)
		return 0xe0 <= byte and byte <= 0xef
	end
	if CharIsStrange(M.GetChar(e)) then
		e.col = e.col + 2
	end
	return s, e
end

---@param text string
---@param from Pos
---@param to Pos
function M.SubstituteText(text, from, to)
	local buffer = 0
	local lines = vim.api.nvim_buf_get_lines(buffer, from.row - 1, to.row, true)

	local lines_text = table.concat(lines, "\n")

	local s = from.col
	local e = to.col

	for l = from.row, to.row - 1 do
		e = e + lines[l - from.row + 1]:len() + 1
	end

	lines_text = My.lua.Substitute(lines_text, text, s, e)

	lines = My.lua.Split(lines_text, "\n")

	vim.api.nvim_buf_set_lines(buffer, from.row - 1, to.row, true, lines)
end

---@param text string
function M.SubstituteVisualSelection(text)
	local from, to = M.GetVisualSelection()
	to.col = to.col - 1
	M.SubstituteText(text, from, to)
end

-- vim.keymap.set("v", "<C-x>", function()
-- 	M.SubstituteVisualSelection("text")
-- end, { desc = "Substitute visual selection" })

---@param n integer? n > 0 -> go down / n < 0 -> go up
function M.GoDown(n)
	n = My.lua.IfNil(n, 1)
	local row, col = M.GetCursorPos():unpack()
	vim.api.nvim_win_set_cursor(0, { row + n, col })
end

---@param n integer n > 0 -> go right / n < 0 -> go left
function M.GoRight(n)
	n = My.lua.IfNil(n, 1)
	local row, col = M.GetCursorPos():unpack()
	vim.api.nvim_win_set_cursor(0, { row, col + n })
end

---@deprecated
---@param cmd string
function M.InsertCmdOutput(cmd)
	vim.cmd("silent exec " .. My.lua.Surround("r!" .. cmd, "'"))
end

---@deprecated
---@param cmd string
---@param opts table | nil
function M.SetLineWithCmdOutput(cmd, opts)
	opts = opts or {}
	local line_number = opts.line_number or "."
	vim.cmd("silent exec " .. My.lua.Surround(line_number .. "!" .. cmd, "'"))
end

---@deprecated
---@param cmd string
---@param opts table | nil
function M.AppendCmdOutput(cmd, opts)
	opts = opts or {}
	local sep = opts.sep or ""
	local line = vim.api.nvim_get_current_line()
	local cmd_l = My.lua.EchoCmd(line .. sep, "-n")
	cmd = cmd_l .. " && " .. cmd
	M.SetLineWithCmdOutput(cmd, opts)
end

---@param n integer|?
---@param opts {buffer: integer|?, strict_indexing: boolean|?} | ?
function M.GetLine(n, opts)
	opts = opts or {}
	n = n or 0
	local buffer = opts.buffer or 0
	local strict_indexing = opts.strict_indexing or true
	if n == 0 then
		return vim.api.nvim_get_current_line()
	end
	return vim.api.nvim_buf_get_lines(buffer, n - 1, n, strict_indexing)[1]
end

function M.BufBeginPos()
	return M.Pos:new(1, 1)
end

---@param buf integer|nil
function M.BufEndPos(buf)
	buf = buf or 0
	local row = vim.api.nvim_buf_line_count(buf)
	local line = M.GetLine(row)
	local col = line:len() + 1
	return M.Pos:new(row, col)
end

---@param from Pos
---@param to Pos
---@return string
function M.GetText(from, to)
	local buffer = 0
	local lines = vim.api.nvim_buf_get_text(buffer, from.row - 1, from.col - 1, to.row - 1, to.col, {})
	return table.concat(lines, "\n")
end

---@param pos Pos
---@return string
function M.GetChar(pos)
	return M.GetText(pos, pos)
end

---@param text string
---@param opts { buffer: integer|?, line_number: integer|? } | ?
function M.SetLine(text, opts)
	opts = opts or {}
	local row, _ = M.GetCursorPos():unpack()
	local line_number = opts.line_number or row
	local buffer = opts.buffer or 0
	local s = line_number - 1
	local f = line_number
	local lines = vim.api.nvim_buf_get_lines(buffer, s, f, true)
	lines[line_number - s] = text
	vim.api.nvim_buf_set_lines(buffer, s, f, true, lines)
end

---@param text string
---@param opts { buffer: integer|?, pos: Pos|? }|?
function M.InsertText(text, opts)
	opts = opts or {}
	local pos = opts.pos or M.GetCursorPos()
	M.SubstituteText(text, pos, pos:move_col(-1))
end

---@param text string
---@param opts table | nil
---@param opts.line_number integer | nil after which line
---@param opts.buffer integer | nil
function M.InsertLine(text, opts)
	opts = opts or {}
	local row, _ = M.GetCursorPos():unpack()
	local line_number = opts.line_number or row
	local buffer = opts.buffer or 0
	local s = line_number - 1
	local f = line_number
	local lines = vim.api.nvim_buf_get_lines(buffer, s, f, true)
	table.insert(lines, line_number - s + 1, text)
	vim.api.nvim_buf_set_lines(buffer, s, f, true, lines)
end

---@param text string
---@param opts table | nil
---@param opts.sep string | nil sep between current line and text
---@param opts.line_number integer | nil
---@param opts.buffer integer | nil
function M.AppendText(text, opts)
	opts = opts or {}
	local sep = opts.sep or ""
	local line_number = opts.line_number or 0
	local line = M.GetLine(line_number)
	M.SetLine(line .. sep .. text, opts)
end

---@param text string
---@param opts table | nil
---@param opts.sep string | nil sep between current line and text
---@param opts.line_number integer | nil
---@param opts.buffer integer | nil
function M.PrependText(text, opts)
	opts = opts or {}
	local sep = opts.sep or ""
	local line_number = opts.line_number or 0
	local line = M.GetLine(line_number)
	M.SetLine(text .. sep .. line, opts)
end

function M.PutText(text, opts)
	opts = opts or {}
	local how = opts.how or "nl"
	if how == "nl" then
		M.InsertLine(text, opts)
	elseif how == "a" then
		M.AppendText(text, opts)
	elseif how == "s" then
		M.SetLine(text, opts)
	end
end

--- Return the visually selected text as an array with an entry for each line
--- @return string[]|nil lines The selected text as an array of lines.
function M.get_visual_selection_text()
	local _, srow, scol = unpack(vim.fn.getpos("v"))
	local _, erow, ecol = unpack(vim.fn.getpos("."))

	-- visual line mode
	if vim.fn.mode() == "V" then
		if srow > erow then
			return vim.api.nvim_buf_get_lines(0, erow - 1, srow, true)
		else
			return vim.api.nvim_buf_get_lines(0, srow - 1, erow, true)
		end
	end

	-- regular visual mode
	if vim.fn.mode() == "v" then
		if srow < erow or (srow == erow and scol <= ecol) then
			-- NOTE: (ecol - 1) for chinese
			return vim.api.nvim_buf_get_text(0, srow - 1, scol - 1, erow - 1, ecol - 1, {})
		else
			return vim.api.nvim_buf_get_text(0, erow - 1, ecol - 1, srow - 1, scol, {})
		end
	end

	-- visual block mode
	if vim.fn.mode() == "\22" then
		local lines = {}
		if srow > erow then
			srow, erow = erow, srow
		end
		if scol > ecol then
			scol, ecol = ecol, scol
		end
		for i = srow, erow do
			table.insert(
				lines,
				vim.api.nvim_buf_get_text(0, i - 1, math.min(scol - 1, ecol), i - 1, math.max(scol - 1, ecol), {})[1]
			)
		end
		return lines
	end
end

-- does not work
function M.EnterNormalMode()
	local esc = vim.api.nvim_replace_termcodes("<esc>", true, false, true)
	vim.api.nvim_feedkeys(esc, "n", true)
	-- vim.cmd("startinsert")
	-- vim.cmd("norm! i")
	-- vim.cmd("")
end

function M.Dir()
	return vim.fn.expand("%:p:h")
end

function M.File()
	return vim.fn.expand("%:p")
end

function M.FileBaseName()
	return My.sys.FileBaseName(M.File())
end

function M.ViewInside(pos_1, pos2)
	M.SetCursor(pos_1)
	vim.cmd("normal v")
	M.SetCursor(pos2)
end

function M.get_synstack()
	local line = vim.fn.line(".")
	local col = vim.fn.col(".")
	local syns = vim.fn.synstack(line, col)
	local result = {}

	for _, syn_id in ipairs(syns) do
		local syn_name = vim.fn.synIDattr(syn_id, "name")
		table.insert(result, syn_name)
	end
	return result
end

return M
