local mt = My.term
local mo = My.oil

local M = {}

---@class OilTerm : FloatTerm
M.OilTerm = mt.FloatTerm.new_subclass({
    display_name = "OilTerm",
})

function M.OilTerm:OpenOil()
	local dir = self:GetCwd()
	self:Unfocus()
	mo.functions.OpenOil(dir)
end

function M.OilTerm:OpenFromOil()
	local dir = mo.functions.GetProperCwd()
    self:ChangeDir(dir)
end

---@param opts SendConfig|nil
function M.OilTerm:ExecuteFile(opts)
	local filepath = My.oil.functions.GetFullPathUnderCursor()
    mt.ExecuteFile(filepath, self, opts)
end

M.oil_term = M.OilTerm:new()

return M
