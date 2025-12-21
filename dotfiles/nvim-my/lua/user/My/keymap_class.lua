local utils = require("map_utils")
local lua_fn = utils.lua_fn

local M = {}

---@class Keymap
---@field lhs_map table<string, string[]>
---@field rhs string|fun()
---@field opts table|nil
M.Keymap = {}

---@alias KeymapTable { mode: string|string[], lhs: string|string[], rhs: string|fun(), opts: table|nil}

---@param o { lhs_map: table<string, string[]>, rhs: string|fun(), opts: table|nil}
function M.Keymap:new_table(o)
	self.__index = self
	o = setmetatable(o, self)
	return o
end

---@param lhs_map table<string, string[]>
---@param rhs string|fun()
---@param opts table|nil
function M.Keymap:new_map(lhs_map, rhs, opts)
	return M.Keymap:new_table({
		lhs_map = lhs_map,
		rhs = rhs,
		opts = opts,
	})
end

---@param mode string|string[]
---@param lhs string|string[]
---@param rhs string|fun()
---@param opts table|nil
function M.Keymap:new_nvim(mode, lhs, rhs, opts)
	if type(mode) == "string" then
		mode = { mode }
	end
	if type(lhs) == "string" then
		lhs = { lhs }
	end
	local lhs_map = {}
	for _, l in ipairs(lhs) do
		lhs_map[l] = mode
	end
	return M.Keymap:new_map(lhs_map, rhs, opts)
end

function M.Keymap:Add()
	for l, modes in pairs(self.lhs_map) do
		vim.keymap.set(modes, l, self.rhs, self.opts)
	end
end

function M.Keymap:AddToBuffer(buf)
	buf = My.lua.IfNil(buf, 0)
	for lhs, modes in pairs(self.lhs_map) do
		for _, mode in pairs(modes) do
			vim.api.nvim_buf_set_keymap(buf, mode, lhs, lua_fn(self.rhs), self.opts)
		end
	end
end

---@param keymaps_table KeymapTable
---@return Keymap[]
function M.KeymapsTableToList(keymaps_table)
	---@type Keymap[]
	local keymaps_list = {}
	for lhs, t in pairs(keymaps_table) do
		local keymap = M.Keymap:new_nvim(t.mode, lhs, t.rhs, t.opts)
		table.insert(keymaps_list, keymap)
	end
	return keymaps_list
end

return M
