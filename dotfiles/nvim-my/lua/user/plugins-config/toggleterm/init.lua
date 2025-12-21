My.toggleterm = {}

My.toggleterm.functions = require("user.plugins-config.toggleterm.functions")
My.toggleterm.term = require("user.plugins-config.toggleterm.term_class")
My.toggleterm.terms = require("user.plugins-config.toggleterm.terms")

My.term = My.lua.CombineTables(
    My.toggleterm.term,
    My.toggleterm.terms,
    My.toggleterm.functions
)

require("user.plugins-config.toggleterm.config")
require("user.plugins-config.toggleterm.keymaps")

-- print(My.term.Term.job_id)
-- print(My.term.FloatTerm.job_id)
-- print(My.term.TermExecute.job_id)


return My.term
