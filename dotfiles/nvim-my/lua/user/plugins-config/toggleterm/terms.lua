local Terminal = require("toggleterm.terminal").Terminal
local mt = My.toggleterm

local M = {}

---@class FloatTerm : Term
M.FloatTerm = mt.term.Term.new_subclass({
    display_name = "FloatTerm",
    direction = "float",
    float_opts = {
        border = "double",
    },
})

---@class TermExecute : FloatTerm
M.TermExecute = M.FloatTerm.new_subclass({
    display_name = "TermExecute",
})

local eterm = M.TermExecute:new()

---@param file string
---@param term Term
---@param opts SendConfig|nil
function M.ExecuteFile(file, term, opts)
    ---@type Term
    term = My.lua.IfNil(term, eterm)
    local nil_opts = (opts == nil)
    opts = opts or mt.term.SendConfig:new()
    if nil_opts then
        opts.execute = false
    end
    local dir = vim.fn.fnamemodify(file, ":p:h")
    term:ChangeDir(dir)
    term:Send(file, opts)
end

---@param opts SendConfig|nil
function M.ExecuteBuffer(opts, term)
    local buf = vim.api.nvim_get_current_buf()
    local file = vim.api.nvim_buf_get_name(buf)
    M.ExecuteFile(file, term, opts)
end

return M
