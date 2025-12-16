local ls = require("luasnip")
-- some shorthands...
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local l = require("luasnip.extras").lambda
local rep = require("luasnip.extras").rep
local p = require("luasnip.extras").partial
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local dl = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local types = require("luasnip.util.types")
local conds = require("luasnip.extras.conditions")
local conds_expand = require("luasnip.extras.conditions.expand")

local trig_engines = require("luasnip.nodes.util.trig_engines")

local M = {}

function M.pattern_matcher(line_to_cursor, trigger)
	-- My.lua.Print(string.format("pattern line: %s", line_to_cursor))
	-- My.lua.Print(string.format("pattern trigger: %s", trigger))
	return line_to_cursor:find(trigger .. "$")
end

function M.pattern_engine(trigger)
	-- My.lua.Print(string.format("pe trig: %s", trigger))
	return M.pattern_matcher
end

---@param line_to_cursor string
---@param trigger string
function M.bol_matcher(line_to_cursor, trigger)
	My.lua.Print(string.format("bol line: %s", line_to_cursor))
	My.lua.Print(string.format("bol trigger: %s", trigger))
	local m = line_to_cursor:match("^" .. trigger .. "$")
	My.lua.Print(m)
	return m, {}
end

---@param line_to_cursor string
---@param trigger string
function M.matcher(line_to_cursor, trigger)
    return nil

	-- look for match which ends at the cursor.
	-- put all results into a list, there might be many capture-groups.
	-- local find_res = { line_to_cursor:find(trigger .. "$") }
	--
	-- if #find_res > 0 then
	-- 	-- if there is a match, determine matching string, and the
	-- 	-- capture-groups.
	-- 	local captures = {}
	-- 	-- find_res[1] is `from`, find_res[2] is `to` (which we already know
	-- 	-- anyway).
	-- 	local from = find_res[1]
	-- 	local match = line_to_cursor:sub(from, #line_to_cursor)
	-- 	-- collect capture-groups.
	-- 	for i = 3, #find_res do
	-- 		captures[i - 2] = find_res[i]
	-- 	end
	--
	-- 	My.lua.Print("matcher: ")
	-- 	My.lua.Print(match)
	-- 	My.lua.Print(captures)
	-- 	return match, captures
	-- else
	-- 	return nil
	-- end
end

function M.engine(trigger)
	return M.matcher
end

ls.add_snippets("all", {
	s({
		trig = "abc",
		trigEngine = M.engine,
	}, {
		t("Triggered!"),
	}),
})
