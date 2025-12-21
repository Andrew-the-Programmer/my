local utils = require("map_utils")
local lua_fn = utils.lua_fn

local M = {}

---@class FiletypeConfig
---@field pattern string|string[]
---@field keymaps Keymap[] | nil
---@field callback fun(ev: table): any | nil
M.FiletypeConfig = {}

---@param o {pattern: string|string[], keymaps: Keymap[] | nil, callback: fun(ev: table): any | nil}
function M.FiletypeConfig:new(o)
	o = My.lua.IfNil(o, {})
	self.__index = self
	o = setmetatable(o, self)
	return o
end

function M.FiletypeConfig:Apply()
	vim.api.nvim_create_autocmd({ "BufEnter" }, {
		pattern = self.pattern,
		callback = function(ev)
			if self.callback ~= nil then
				self.callback(ev)
			end
			if self.keymaps ~= nil then
				for _, v in pairs(self.keymaps) do
					v:AddToBuffer(ev.buf)
				end
			end
		end,
	})
end

local function main()
	--NOTE: ORDER MATTERS! default first
	local configs = {
		"default",
		"translation",
		"markdown",
		"html",
		"cpp",
		"python",
		"tex",
		"lua",
		"json",
	}

	local parent = "user.filetype_specific."

	for _, v in pairs(configs) do
		local file = parent .. v
		---@type FiletypeConfig
		local fc = require(file)
		fc:Apply()
	end
end

My.FiletypeConfig = M.FiletypeConfig

main()

return M
