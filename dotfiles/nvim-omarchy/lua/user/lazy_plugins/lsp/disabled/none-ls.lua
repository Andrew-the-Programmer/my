local function Sources(null_ls)
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
    local sources = My.lua.CombineLists({
            -- Code Actions
            -- Injects actions to fix typos found by cspell
            -- null_ls.builtins.diagnostics.cspell,
            -- null_ls.builtins.code_actions.cspell,
            -- "javascript", "javascriptreact", "typescript", "typescriptreact", "vue"
            -- Injects actions to fix ESLint issues or ignore broken rules.
            -- null_ls.builtins.code_actions.eslint,
            -- Injects code actions for Git operations
            null_ls.builtins.code_actions.gitsigns,
            -- "go", "javascript", "lua", "python", "typescript"
            -- The Refactoring library based off the Refactoring book by Martin Fowler.
            null_ls.builtins.code_actions.refactoring,
            -- running functions on Tree-sitter nodes
            -- null_ls.builtins.code_actions.ts_node_action,
        }, {

            -- "javascript", "javascriptreact", "typescript",
            -- "typescriptreact", "vue", "css", "scss", "less", "html",
            -- "json", "jsonc", "yaml", "markdown", "markdown.mdx",
            -- "graphql", "handlebars"
            null_ls.builtins.formatting.prettier,
            -- prettier, as a daemon, for ludicrous formatting speed.
            -- null_ls.builtins.formatting.prettier_d_slim,
            -- Makes prettier fast.
            -- null_ls.builtins.formatting.prettierd,
            -- CLI for prettier-eslint
            -- null_ls.builtins.formatting.prettier_eslint

            -- One CLI to format your repo
            null_ls.builtins.formatting.treefmt.with({
                -- treefmt requires a config file
                condition = function(utils)
                    return utils.root_has_file("treefmt.toml")
                end,
            }),
        },
        -- bash
        {
            null_ls.builtins.code_actions.shellcheck,
            null_ls.builtins.diagnostics.shellcheck,
            null_ls.builtins.formatting.shfmt,
            -- "bash", "csh", "ksh", "sh", "zsh"
            null_ls.builtins.formatting.beautysh,
            -- Improves shell scripts
            null_ls.builtins.formatting.shellharden,
        },
        -- python
        {
            null_ls.builtins.diagnostics.pylint,
            null_ls.builtins.diagnostics.ruff,

            null_ls.builtins.formatting.prettier,
            null_ls.builtins.formatting.black,
            -- Sorts imports
            null_ls.builtins.formatting.isort,
            -- Removes unused imports and unused variables
            -- null_ls.builtins.formatting.autoflake,
            -- auto-import libraries
            null_ls.builtins.formatting.pyflyby,
            -- The Google Python code formatter
            -- null_ls.builtins.formatting.pyink,
        },
        -- c++
        {
            -- null_ls.builtins.diagnostics.cpplint,
            null_ls.builtins.formatting.clang_format,
            null_ls.builtins.formatting.uncrustify,
        },
        -- lua
        {
            null_ls.builtins.diagnostics.selene,
            -- null_ls.builtins.diagnostics.luacheck,
            -- null_ls.builtins.formatting.lua_format,
            null_ls.builtins.formatting.stylua,

        },
        -- ruby
        {
            null_ls.builtins.diagnostics.rubocop,
            null_ls.builtins.formatting.rubocop,
        },
        -- markdown
        {
            -- English prose linter, whatever it means...
            -- null_ls.builtins.diagnostics.write_good,
            -- null_ls.builtins.diagnostics.alex,
            -- null_ls.builtins.diagnostics.markdownlint,
            -- null_ls.builtins.diagnostics.mdl,
            -- null_ls.builtins.diagnostics.proselint,
            -- null_ls.builtins.diagnostics.textidote,
            -- null_ls.builtins.diagnostics.textlint,

            -- A tool to format codeblocks inside markdown and org documents.
            -- null_ls.builtins.formatting.cbfmt,

            -- create md table of contents (put <!-- toc -->)
            null_ls.builtins.formatting.markdown_toc,

            -- null_ls.builtins.formatting.mdformat,

            -- A changelog formatter
            -- null_ls.builtins.formatting.ocdc,

            -- null_ls.builtins.formatting.remark,

            -- The terrafmt command formats terraform blocks embedded in Markdown files.
            null_ls.builtins.formatting.terrafmt,

            null_ls.builtins.formatting.textlint,

            null_ls.builtins.hover.dictionary,
        },
        -- json, yaml
        {
            -- null_ls.builtins.diagnostics.vacuum,
        },
        -- cmake
        {
            null_ls.builtins.formatting.cmake_format,
        },
        -- tex
        {
            -- null_ls.builtins.formatting.latexindent,
        },
        -- OTHER
        {
            -- mark TODO comments as warnings
            null_ls.builtins.diagnostics.todo_comments,
            -- null_ls.builtins.diagnostics.trail_space,
            -- null_ls.builtins.diagnostics.typos,
        })
    return sources
end

return {
    {
        -- https://github.com/jose-elias-alvarez/null-ls.nvim
        -- Deprecated
        -- Use none-ls
        "jose-elias-alvarez/null-ls.nvim",
        event = "VeryLazy",
    },
    {
        -- https://github.com/nvimtools/none-ls.nvim
        -- I still don't understand what it's for
        -- It improves lua formatting so I'll keep it
        "nvimtools/none-ls.nvim",
        dependencies = {
            "jose-elias-alvarez/null-ls.nvim",
        },
        config = function()
            local null_ls = require("null-ls")

            null_ls.setup({
                sources = Sources(null_ls),
            })
        end,
    },
}
