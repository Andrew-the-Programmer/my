return {
    -- https://github.com/nvim-telescope/telescope.nvim
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = {
        "nvim-lua/plenary.nvim",
        {
            -- https://github.com/nvim-telescope/telescope-fzf-native.nvim
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
            -- build = "make",
        },
        "nvim-telescope/telescope-ui-select.nvim",
        "nvim-telescope/telescope-frecency.nvim",
    },
    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")
        local builtin = require("telescope.builtin")
        local themes = require("telescope.themes")

        telescope.setup({
            defaults = {
                path_display = { "smart" },
                mappings = {
                    i = {
                        ["<C-k>"] = actions.move_selection_previous, -- move to prev result
                        ["<C-j>"] = actions.move_selection_next, -- move to next result
                        ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
                        ["<C-x>"] = actions.delete_buffer,
                        ["<C-s>"] = actions.select_vertical,
                        ["<C-h>"] = actions.select_horizontal,
                    },
                },
                sorter = "fuzzy_fzy",
                -- override_file_sorter = {},
                --[[ vimgrep_arguments = {
					"echo",
					"hello",
				}, ]]
            },
            extensions = {
                -- fzf = {
                -- 	fuzzy = true, -- false will only do exact matching
                -- 	-- override_generic_sorter = true, -- override the generic sorter
                -- 	-- override_file_sorter = true, -- override the file sorter
                -- 	case_mode = "ignore_case", -- or "ignore_case" or "respect_case"
                -- 	-- the default case_mode is "smart_case"
                -- },
                ["ui-select"] = {
                    themes.get_dropdown({}),
                },
                frecency = {
                    show_scores = true,
                    show_filter_column = false,
                },
            },
            pickers = {
                find_files = {
                    -- rg --files --hidden --no-ignore-vcs -g "\!**/.git/*" | rg "ignore"
                    --[[ find_command = {
						"ls",
						"-lhar",
					}, ]]
                    --[[
					find_command = {
						"rg",
						-- case insensitive
						"-i",
						"--files",
						"--hidden",
						-- Ignore .git dir
						"-g",
						"!**/.git/*",
						-- Include files ignored by git
						"--no-ignore-vcs",
						-- Include links
						"--follow",
					},
                    ]]
                },
            },
        })

        -- vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "find file" })
        vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "Find recent file" })
        vim.keymap.set("n", "<leader>fg", builtin.git_files, { desc = "find git file" })
        vim.keymap.set("n", "<leader>fl", builtin.live_grep, { desc = "Live grep" })
        vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find buffer" })
        vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find help" })
        vim.keymap.set("n", "<leader>fc", builtin.commands, { desc = "Find commands" })
        vim.keymap.set("n", "<leader>/", builtin.current_buffer_fuzzy_find, { desc = "Find in buffer" })
        vim.keymap.set("n", "<leader>fs", builtin.spell_suggest, { desc = "Find spell suggestions" })

        -- telescope.load_extension("ui-select")
        -- not sure if it works at all
        -- telescope.load_extension("frecency")
        -- Error: 'fzf' extension doesn't exist or isn't installed
        -- telescope.load_extension("fzf")
        -- This will load fzy_native and have it override the default file sorter
        -- telescope.load_extension("fzy_native")
    end,
}
