-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Move to ends of line
vim.keymap.set("n", "H", "^")
vim.keymap.set("n", "L", "g_")

-- Redo
vim.keymap.set("n", "U", "<C-r>", { desc = "Redo" })

-- Copy to clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Copy to clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Copy line to clipboard" })

-- Paste from clipboard
vim.keymap.set({ "n", "v" }, "<leader>p", [["+p]], { desc = "Paste from clipboard" })
vim.keymap.set("n", "<leader>P", [["+P]], { desc = "Paste line from clipboard" })

-- buffer copy/paste
vim.keymap.set("n", "<leader>by", "<cmd>%y+<CR>", { desc = "Copy entire buffer to clipboard" })
vim.keymap.set("n", "<leader>bp", 'ggVG"+p', { desc = "Paste entire buffer to clipboard" })

-- Select and move lines up/down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected line(s) down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected line(s) up" })
