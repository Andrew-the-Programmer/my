local M = {}

local vim_keymaps = require("user.pre-plugins-config.keymaps.vim")
local ibus_switch = require("user.pre-plugins-config.keymaps.ibus_switch")

---@type Keymap[]
local keymaps = My.lua.CombineLists(vim_keymaps, ibus_switch)

for _, keymap in ipairs(keymaps) do
	keymap:Add()
end

return M
