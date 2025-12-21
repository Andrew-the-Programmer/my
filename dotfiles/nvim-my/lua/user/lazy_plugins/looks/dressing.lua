return {
    -- https://github.com/stevearc/dressing.nvim
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    config = function()
        require("dressing").setup()
    end,
}
