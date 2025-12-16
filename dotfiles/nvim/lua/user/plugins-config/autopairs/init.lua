local na = require("nvim-autopairs")
local Rule = require("nvim-autopairs.rule")
local npairs = require("nvim-autopairs")
local cond = require("nvim-autopairs.conds")

na.setup()

local function cond_disable_in_math()
	local synstack = My.nvim.get_synstack()
	return not My.lua.ListFind(synstack, "Math")
end

local function disable_in_math(symb)
	na.get_rules(symb)[1]:with_pair(cond_disable_in_math)
end

local function disable_pair(symb)
	na.get_rules(symb)[1]:with_pair(function()
		return false
	end)
end

-- I use LuaSnip for that, see user.plugins-config.LuaSnip.snippets.all
disable_pair("(")
disable_pair("[")
disable_pair("{")
disable_pair('"')
disable_pair("'")
