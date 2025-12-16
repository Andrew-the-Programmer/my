vim.keymap.set("i", "<C-f>", function()
    local fig_name = vim.api.nvim_get_current_line()
    -- local fig_name = "Penis"
    local fig_dir = "figures"
    local root = vim.b.vimtex.root
    local dir = root .. "/" .. fig_dir .. "/"
    local cmd = ".!inkscape-figures"
    local args = { "create", fig_name, dir }
    vim.cmd("silent exec '.!inkscape-figures create \"" .. fig_name .. '" "' .. dir .. "\"'")
    vim.cmd("w")
end, { desc = "Inkscape create figure" })

vim.keymap.set("n", "<localleader>ie", function()
    local fig_dir = "figures"
    local root = vim.b.vimtex.root
    local dir = root .. "/" .. fig_dir .. "/"

    local cmd = "silent exec '.!inkscape-figures edit \"" .. dir .. "\" > /dev/null 2>&1 &'"
    vim.cmd(cmd)

    -- to fix deleting line
    vim.cmd("undo")
    vim.cmd("w")

    vim.cmd("redraw!")
end, { desc = "Inkscape edit figures" })

-- inoremap <C-f> <Esc>: silent exec '.!inkscape-figures create "'.getline('.').'" "'.b:vimtex.root.'/figures/"'<CR><CR>:w<CR>
-- nnoremap <C-f> : silent exec '!inkscape-figures edit "'.b:vimtex.root.'/figures/" > /dev/null 2>&1 &'<CR><CR>:redraw!<CR>
