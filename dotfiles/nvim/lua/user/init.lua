local M = {}

My = require("user.My")

M.pre_plugins = require("user.pre-plugins-config")
require("user.lazy_plugins_init")
require("user.filetype_specific")

return M
