local ls = require("luasnip")

require("user.plugins-config.LuaSnip.snippets.markdown.codeblocks")
require("user.plugins-config.LuaSnip.snippets.markdown.macros")

ls.filetype_extend("markdown_inline", { "markdown" })
