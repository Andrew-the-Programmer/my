local mt = My.toggleterm

function My.toggleterm.set_terminal_keymaps()
    local opts = { buffer = 0 }
    vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
    vim.keymap.set("t", "<C-y>", function()
        ---@type Term
        local term = mt.functions.GetCurrentTerm()
        term:Close()
    end, { desc = "Unfocuse terminal" })
    vim.keymap.set("t", "<C-n>", function()
        ---@type Term
        local term = mt.functions.GetCurrentTerm()
        term:EnterNormalMode()
    end, { desc = "Enter normal mode" })
end

-- vim.keymap.set({ "t", "n" }, "<F1>", "<cmd>ToggleTerm<CR>")

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd("autocmd! TermOpen term://*toggleterm#* lua My.toggleterm.set_terminal_keymaps()")
