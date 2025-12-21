require("user.plugins-config.oil.keymaps.term")
require("user.plugins-config.oil.keymaps.nvim")

local oil = require("user.plugins-config.oil.keymaps.oil")
local memes = require("user.plugins-config.oil.keymaps.group_operations")

local keymaps = My.lua.CombineTables(oil, memes)

return keymaps
