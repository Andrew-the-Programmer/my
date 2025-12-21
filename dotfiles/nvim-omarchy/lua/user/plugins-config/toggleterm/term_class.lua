local ui = require("toggleterm.ui")
local Terminal = require("toggleterm.terminal").Terminal
local mt = My.toggleterm

local M = {}

function M.new_subclass(self, o)
    o = My.lua.IfNil(o, {})
    o.new_subclass = My.lua.IfNil(o.new_subclass, function (oo)
        return M.new_subclass(o, oo)
    end)
    self.__index = self
    o = setmetatable(o, self)
    return o
end

---@class Term : Terminal
---@field cwd string
---@field new_subclass fun(o: table):Term
M.Term = Terminal:new({
    display_name = "Term",
    newline_chr = "\r",
})

M.Term.new_subclass = function(o)
    return M.new_subclass(M.Term, o)
end

function M.Term:new(o)
    o = My.lua.IfNil(o, {})
    o.id = My.lua.IfNil(o.id, mt.functions.GetUniqueTermId())
    o.cwd = My.lua.IfNil(o.dir, mt.functions.GetProperCwd())
    o.on_open = My.lua.IfNil(o.on_open, function(term)
        term:Focus()
        term:ClearCommandLine()
    end)
    -- No effect
    -- o.on_exit = My.lua.IfNil(o.on_exit, function(term)
    --     term:Load()
    -- end)
    self.__index = self
    o = setmetatable(o, self)
    o:Load()
    return o
end

function M.Term:GetFile()
    return "/tmp/nvim_term" .. self.id .. ".txt"
end

--- @class SendConfig
--- @field check_error boolean
--- @field unfocus_terminal boolean
--- @field execute boolean
--- @field exit boolean
--- @field exit_if_error boolean
M.SendConfig = {
    check_error = false,
    unfocuse_terminal = false,
    execute = true,
    exit = false,
    exit_if_error = false,
}

function M.SendConfig:new(o)
    o = o or {}
    self.__index = self
    o = setmetatable(o, self)
    return o
end

--- Send single command
---@param cmd string|string[] command or table of args
---@param opts SendConfig|nil
---@param clear boolean|nil
function M.Term:Send(cmd, opts, clear)
    self:Open()
    clear = My.lua.IfNil(clear, false)
    if clear then
        self:ClearCommandLine()
    end
    opts = opts or M.SendConfig:new()
    local newline_chr = self.newline_chr
    if not opts.execute then
        newline_chr = ""
    end
    if type(cmd) == "table" then
        cmd = table.concat(cmd, " ")
    end
    cmd = mt.functions.with_cr(newline_chr, cmd)

    if opts.check_error then
        cmd = "[ $? -eq 0 ] && " .. cmd
    end
    if opts.exit_if_error then
        cmd = cmd .. " || exit $?"
    end
    if opts.exit then
        cmd = cmd .. " | exit $?"
    end

    -- print(self.job_id)
    vim.fn.chansend(self.job_id, cmd)
    self:scroll_bottom()
    if opts.execute and opts.unfocus_terminal and self:is_focused() then
        self:Unfocus()
    elseif not opts.unfocus_terminal and not self:is_focused() then
        self:Focus()
    end
end

--- Send a group of commands
---@param term Terminal
---@param cmds string[]|string[][]
---@param opts SendConfig
function M.Term:SendGroup(term, cmds, opts)
    opts = opts or M.SendConfig:new()
    opts.unfocus_terminal = false
    opts.execute = true
    opts.check_error = false
    opts.exit = false
    opts.exit_if_error = false

    for _, cmd in pairs(cmds) do
        M.Send(term, cmd, opts)
    end
end

---@param dir string
---@param opts SendConfig|nil
function M.Term:ChangeDir(dir, opts)
    local cd_cmd = "cd " .. dir .. " && pwd > " .. self:GetFile()
    self:Send(cd_cmd, opts)
    self.cwd = dir
end

function M.Term:GetSavedCwd()
    local file = self:GetFile()
    local cwd = My.sys.ReadFile(file)
    return cwd
end

function M.Term:Open()
    -- print(self.id, self.count, self.job_id)
    if self:is_open() then
        return
    end
    self:open()
end

function M.Term:Close()
    self:close()
end

function M.Term:Toggle()
    if self:is_open() then
        self:Close()
        return
    end
    self:Open()
end

function M.Term:Reopen()
    self:Close()
    self:Open()
end

function M.Term:Load()
    if self:is_open() then
        return
    end
    self:Open()
    self:Unfocus()
end

function M.Term:Focus()
    self:focus()
    vim.cmd("startinsert!")
end

function M.Term:Unfocus()
    ui.goto_previous()
    ui.stopinsert()
end

function M.Term:SaveCwd()
    self:ChangeDir(".")
end
function M.Term:GetCwd()
    local saved_cwd = self:GetSavedCwd()
    if saved_cwd ~= self.cwd then
        My.nvim.Notify("Term cwd didn't match the saved cwd")
        self.cwd = saved_cwd
    end
    return self.cwd
end

function M.Term:ClearCommandLine()
    local opts = M.SendConfig:new()
    opts.execute = false
    self:Send("\21", opts, false)
end

function M.Term:Clear()
    self:ClearCommandLine()
    self:clear()
end

---@param opts SendConfig|nil
function M.Term:EnterNormalMode(opts)
    opts = opts or M.SendConfig:new()
    opts.execute = false
    self:Send("\27", opts)
end

return M
