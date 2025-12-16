local overseer = require("overseer")

local M = {}

M.config = require("user.overseer.config")
M.opts = require("user.overseer.opts")

overseer.setup(M.opts)

return M
