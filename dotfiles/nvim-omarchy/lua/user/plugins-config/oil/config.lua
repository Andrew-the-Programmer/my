local oil = require("oil")

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
-- vim.api.nvim_create_autocmd("BufEnter", {
-- 	pattern = "*",
-- 	callback = function()
--         if vim.bo.buftype == "terminal" then
--             require(oilconfig .. ".keymaps.term")
--         end
-- 	end,
-- })

require("user.plugins-config.oil.keymaps.term")
require("user.plugins-config.oil.keymaps.nvim")

local opts = require("user.plugins-config.oil.opts")

oil.setup(opts)
