return {
	-- https://github.com/mfussenegger/nvim-lint
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")

		lint.linters_by_ft = {
			bash = { "shellcheck" },
			python = { "pylint", "ruff" },
			lua = { "selene" },
			ruby = { "rubocop" },
			markdown = {
				"write_good",
				"alex",
				-- "markdownlint",
				-- "proselint",
				-- "textlint",
			},
			sql = { "sqlfluff" },
			["*"] = {
				-- "todo_comments",
				-- "codespell",
				"typos",
			},
		}

		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				local ft = vim.bo.filetype
				lint.try_lint()
				lint.try_lint(lint.linters_by_ft["*"])
				if lint.linters_by_ft[ft] == nil then
					lint.try_lint(lint.linters_by_ft["_"])
				end
			end,
		})
	end,
}
