return {
    -- https://github.com/mbbill/undotree
    "mbbill/undotree",
    config = function()
        vim.keymap.set("n", "<leader>tu", vim.cmd.UndotreeToggle, { desc = "Toggle undotree" })
    end,
}
