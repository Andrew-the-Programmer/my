return {
    "FeiyouG/commander.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
        local commander = require("commander")
        commander.add({
            {
                desc = "Open commander",
                cmd = require("commander").show,
                keys = { "n", "<Leader>fc" },
            },
        })
    end,
}
