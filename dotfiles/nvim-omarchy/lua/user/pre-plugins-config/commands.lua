local function ReloadConfig()
	vim.cmd("source " .. vim.env.MYVIMRC)
	vim.notify("Nvim configuration reloaded!", vim.log.levels.INFO)
end

vim.api.nvim_create_user_command("ReloadConfig", ReloadConfig, { nargs = 0, desc = "Reload neovim config" })

vim.api.nvim_create_user_command("Wroot", function()
	vim.cmd("w !sudo tee % > /dev/null")
	My.nvim.Notify("Saved file as root")
end, { nargs = 0, desc = "Write file as root" })
