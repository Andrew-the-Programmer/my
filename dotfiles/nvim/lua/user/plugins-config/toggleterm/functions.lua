local toggleterm = require("toggleterm.terminal")

local M = {}

local __term_count = 0

---@return number
function M.GetUniqueTermId()
	__term_count = __term_count + 1
	return __term_count
end

---@return string
function M.GetProperCwd()
	local cwd = vim.fn.getcwd()
	return cwd
end

---Combine arguments into strings separated by new lines
---@param newline_chr string
---@param args string|string[]
---@return string
function M.with_cr(newline_chr, args)
	if type(args) == "string" then
		return args .. newline_chr
	end
	local result = {}
	for _, str in ipairs(args) do
		table.insert(result, M.with_cr(newline_chr, str))
	end
	return table.concat(result, "")
end

---@return Term[]
function M.GetAllTerminals()
    return toggleterm.get_all()
end

---@param bufnr number
---@return Term
function M.GetTermByBufnr(bufnr)
    for _, term in pairs(M.GetAllTerminals()) do
        if term.bufnr == bufnr then
            return term
        end
    end
    error("Terminal not found for bufnr: " .. bufnr)
end

---@return Term
function M.GetCurrentTerm()
    return M.GetTermByBufnr(vim.api.nvim_get_current_buf())
end

return M
