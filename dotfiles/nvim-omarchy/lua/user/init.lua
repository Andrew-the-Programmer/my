local M = {}

My = require("user.My")

M.pre_plugins = require("user.pre-plugins-config")
require("user.lazy_plugins_init")
M.plugins_config = require("user.plugins-config")
require("user.filetype_specific")
M.src = require("user.src")
M.overseer = require("user.overseer")

return M
