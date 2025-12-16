return {
	{
		-- https://github.com/lervag/vimtex
		"lervag/vimtex",
        dependencies = {
            "preservim/vim-markdown",
        },
		lazy = false,
		init = function()
			vim.g.vim_markdown_math = 1
            vim.opt.conceallevel = 2
			vim.g.vimtex_view_method = "zathura"
            vim.g.vimtex_format_enabled = 1
			vim.g.vimtex_compiler_latexmk = {
				aux_dir = "aux",
				out_dir = "out",
				callback = 1,
				continuous = 1,
				executable = "latexmk",
				hooks = {},
				options = {
					"--shell-escape",
					-- "-verbose",
					-- "-file-line-error",
					"-synctex=1",
					"-interaction=nonstopmode",
				},
			}
			-- vim.g.vimtex_syntax_conceal = "abdgm"
			-- vim.g.tex_conceal = "abdgm"
			-- vim.g.vimtex_syntax_enabled = 1
		end,
	},
	--[[ {
        -- https://github.com/KeitaNakamura/tex-conceal.vim
        -- Don't work
        "KeitaNakamura/tex-conceal.vim",
        -- opts = {},
        config = function()
            vim.g.tex_conceal_frac = 1
            vim.g.conceallevel = 2
            vim.g.tex_conceal = "abdgm"

            -- require("tex-conceal").setup()
        end,
    } ]]
}
