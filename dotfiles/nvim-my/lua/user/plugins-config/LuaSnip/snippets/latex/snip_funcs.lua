local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local m = require("luasnip.extras").match
local rep = require("luasnip.extras").rep
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local r = ls.restore_node
local l = require("luasnip.extras").lambda
local p = require("luasnip.extras").partial
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local dl = require("luasnip.extras").dynamic_lambda

local M = {}

---@param trig string
---@param nodes table
function M.keyword(trig, nodes)
	return s({
		trig = trig,
		trigEngine = "pattern",
	}, nodes)
end

---@param trig string
---@param res string
function M.keyword_simple(trig, res)
	return s({
		trig = trig,
		trigEngine = "pattern",
	}, { t("\\" .. res) })
end

---@param trig string
---@param op string
function M.unary_operator(trig, op)
	return s({
		trig = trig .. " ",
		trigEngine = "pattern",
	}, {
		t(op .. " "),
	})
end

---@param trig string
---@param op string
function M.unary_operator_easy(trig, op)
	return s({
		trig = trig,
		trigEngine = "pattern",
	}, {
		t(op),
	})
end

---@param trig string
---@param op string
function M.binary_operator(trig, op)
	return s({
		trig = trig,
		trigEngine = "pattern",
	}, { t(op .. " ") })
end

---@param trig string
---@param op string
function M.binary_operator_auto(trig, op)
	return s({
		trig = trig,
		-- trigEngine = "pattern",
		snippetType = "autosnippet",
	}, { t(op .. " ") })
end

---@param trig string
---@param res string
function M.greek_letter(trig, res)
	return M.keyword_simple(trig, res)
end

---@param value string
function M.iso(value)
	return My.lua.If(value:len() > 1, "{" .. value .. "}", value)
end

---@param trig string
---@param nodes table
function M.autosnippet(trig, nodes)
	return s({
		trig = trig,
		snippetType = "autosnippet",
		wordTrig = false,
	}, nodes)
end

---@param trig string
---@param power string
function M.power(trig, power)
	return s({
		trig = trig,
		snippetType = "autosnippet",
		wordTrig = false,
	}, {
		t("^" .. M.iso(power)),
	})
end

---@param trig string
---@param func_name string
function M.unary_func(trig, func_name)
	return s({
		trig = trig,
		trigEngine = "pattern",
	}, {
		t("\\" .. func_name .. "{"),
		i(1),
		t("}"),
	})
end

---@param trig string
---@param func_name string
function M.env(trig, func_name)
	return s({
		trig = trig,
	}, {
		t({ "\\" .. func_name .. "{", "" }),
		i(1),
		t({ "", "}" }),
	})
end

---@param trig string
---@param func_name string
function M.unary_func_with_index(trig, func_name)
	return s(
		{
			trig = trig,
			trigEngine = "pattern",
		},
		fmta("\\<func><>{<>}", {
			func = t(func_name),
			i(1),
			i(2),
		})
	)
end

---@param id number
---@param choices table
---@param op string
function M.ind(id, choices, op)
	return {
		m(id, "^$", "", op .. "{"),
		c(id, choices),
		m(id, "^$", "", "}"),
	}
end
---@param id number
---@param choices table
function M.lind(id, choices)
	return M.ind(id, choices, "_")
end
---@param id number
---@param choices table
function M.uind(id, choices)
	return M.ind(id, choices, "^")
end

---@param nodes table|string|any
---@param lind_choices table
---@param uind_func (fun(string):table)|nil
function M.index(nodes, lind_choices, uind_func)
	if nodes == nil then
		error("nodes is nil")
	end
	if type(nodes) ~= "table" or nodes["op"] == nil then
		local op = nil
		if type(nodes) == "string" then
			op = t(nodes)
		else
			op = nodes
		end
		nodes = {
			["op"] = op,
		}
	end
	local def_nodes = {
		["lind"] = sn(1, M.lind(1, lind_choices)),
		["uind"] = d(2, function(args, snip, osnip)
			local i1 = args[1][1]
			local uind_choices = uind_func(i1)
			if #uind_choices == 0 then
				return sn(nil, {})
			else
				return sn(nil, M.uind(1, uind_choices))
			end
		end, { 1 }),
		["args"] = i(3),
	}
	if uind_func == nil then
		def_nodes["uind"] = t("")
	end
	local fnodes = My.lua.CombineTables(def_nodes, nodes)
	return fmta("<op><lind><uind>{<args>}", fnodes)
end

---@param nodes table|string|any
function M.domain_operator(nodes)
	return M.index(nodes, {
		sn(nil, { i(1) }),
		sn(nil, { i(1), t(" \\in "), i(2) }),
	}, nil)
end

---@param nodes table|string|any
function M.big_operator(nodes)
	return M.index(
		nodes,
		{
			sn(nil, { i(1) }),
			sn(nil, { i(1), t(" = "), i(2) }),
			sn(nil, { i(1), t(" \\in "), i(2) }),
		},
		---@param lind string
		---@return table
		function(lind)
			if lind:match("^.* = .*$") then
				return {
					sn(nil, { i(1, "\\infty") }),
				}
			else
				return {}
			end
		end
	)
end

---@param name string
function M.dont_repeat()
	return {
		condition = function(line_to_cursor, matched_trigger, captures)
			if matched_trigger == nil then
				return true
			end
			return My.lua.If(line_to_cursor:match("\\" .. matched_trigger .. "$"), false, true)
		end,
		show_condition = function(line_to_cursor, matched_trigger, captures)
			if matched_trigger == nil then
				return true
			end
			return My.lua.If(line_to_cursor:match("\\" .. matched_trigger .. "$"), false, true)
		end,
	}
end

---@param lhs string
---@param rhs string
function M.pair(lhs, rhs)
	return s({
		trig = lhs,
		wordTrig = false,
		snippetType = "autosnippet",
		priority = -100,
	}, {
		t(lhs),
		i(1),
		t(rhs),
	})
end

---@param lhs string
---@param rhs string
---@param ind string|nil
function M.lind_snip(lhs, rhs, ind)
	return s({
		trig = string.format("(%s)(%s)", lhs, rhs),
		trigEngine = "pattern",
		snippetType = "autosnippet",
	}, {
		f(function(_, snip)
			local c1 = snip.captures[1]
			local c2 = ind or snip.captures[2]
			return c1 .. "_" .. c2
		end),
	})
end

s({
	trig = "(%a)(%d)",
	trigEngine = "pattern",
	snippetType = "autosnippet",
}, {
	f(function(_, snip)
		local c1 = snip.captures[1]
		local c2 = snip.captures[2]
		return c1 .. "_" .. c2
	end),
})

return M
