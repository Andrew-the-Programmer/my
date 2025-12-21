local mt = My.term

local float = mt.FloatTerm:new()
float:Load()

vim.keymap.set("n", "<leader>tt", function()
    float:Open()
end, { desc = "Open float terminal" })

vim.keymap.set(
    { "n" },
    "<leader>te",
    mt.ExecuteBuffer,
    { desc = "Execute current buffer's file", noremap = true, silent = true }
)

