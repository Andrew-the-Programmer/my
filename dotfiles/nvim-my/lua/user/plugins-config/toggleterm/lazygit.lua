local Terminal = require("toggleterm.terminal").Terminal
local mtt = My.toggleterm

local M = {}

M.lazygit = mtt.term.FloatTerm:new({
    cmd = "lazygit",
    dir = "git_dir",
    hidden = true,
    -- function to run on opening the terminal
    on_open = function(term)
        vim.cmd("startinsert!")
        vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
    end,
    -- function to run on closing the terminal
    on_close = function(term)
        vim.cmd("startinsert!")
    end,
})

function M.lazygit_toggle()
    M.lazygit:toggle()
end

vim.keymap.set("n", "<leader>tl", M.lazygit_toggle, { desc = "Toggle lazygit", noremap = true, silent = true })

return M
