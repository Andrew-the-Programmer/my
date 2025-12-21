local M = {}

M.options = require("user.pre-plugins-config.options")
M.keymaps = require("user.pre-plugins-config.keymaps")
M.events = require("user.pre-plugins-config.events")
M.commands = require("user.pre-plugins-config.commands")
-- M.theme = require("user.pre-plugins-config.theme")

require("user.pre-plugins-config.textit")

return M
