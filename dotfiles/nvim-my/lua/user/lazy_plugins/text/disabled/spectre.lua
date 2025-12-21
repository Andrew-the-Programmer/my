return {
    -- https://github.com/nvim-pack/nvim-spectre
    -- Find and replace
    "nvim-pack/nvim-spectre",
    config = function()
        local spectre = require("spectre")

        vim.keymap.set("n", "<leader>ss", function()
            spectre.toggle()
        end, {
            desc = "Toggle Spectre",
        })
        vim.keymap.set("n", "<leader>sw", function()
            spectre.open_visual({ select_word = true })
        end, {
            desc = "Search current word",
        })
        vim.keymap.set("n", "<leader>sf", function()
            spectre.open_file_search({ select_word = true })
        end, {
            desc = "Search on current file",
        })
    end,
}
