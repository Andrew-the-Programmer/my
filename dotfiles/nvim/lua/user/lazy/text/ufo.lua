return {
	-- https://github.com/kevinhwang91/nvim-ufo
	-- Plugin for folds
	"kevinhwang91/nvim-ufo",
	dependencies = {
		"kevinhwang91/promise-async",
	},
	config = function()
		vim.o.foldcolumn = "1" -- '0' is not bad
		vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
		vim.o.foldlevelstart = 99
		vim.o.foldenable = true

		local ufo = require("ufo")

		local handler = function(virtText, lnum, endLnum, width, truncate)
			local newVirtText = {}
			local suffix = (" 󰇘 %d "):format(endLnum - lnum)
			local sufWidth = vim.fn.strdisplaywidth(suffix)
			local targetWidth = width - sufWidth
			local curWidth = 0
			for _, chunk in ipairs(virtText) do
				local chunkText = chunk[1]
				local chunkWidth = vim.fn.strdisplaywidth(chunkText)
				if targetWidth > curWidth + chunkWidth then
					table.insert(newVirtText, chunk)
				else
					chunkText = truncate(chunkText, targetWidth - curWidth)
					local hlGroup = chunk[2]
					table.insert(newVirtText, { chunkText, hlGroup })
					chunkWidth = vim.fn.strdisplaywidth(chunkText)
					-- str width returned from truncate() may less than 2nd argument, need padding
					if curWidth + chunkWidth < targetWidth then
						suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
					end
					break
				end
				curWidth = curWidth + chunkWidth
			end
			table.insert(newVirtText, { suffix, "MoreMsg" })
			return newVirtText
		end

		ufo.setup({
			provider_selector = function(bufnr, filetype, buftype)
				return { "indent" }
			end,
			fold_virt_text_handler = handler,
		})

		-- vim.keymap.set("n", "<leader>zo", ufo.openAllFolds, { desc = "Open all folds" })
		-- vim.keymap.set("n", "<leader>za", ufo.openAllFolds, { desc = "Open all folds" })
		-- vim.keymap.set("n", "<leader>zr", ufo.openAllFolds, { desc = "Open all folds" })
		-- vim.keymap.set("n", "<leader>zr", ufo.openAllFolds, { desc = "Open all folds" })
		-- vim.keymap.set("n", "<leader>zm", ufo.closeFoldsWith, { desc = "Close all folds" })
		-- vim.keymap.set("n", "zM", ufo.closeAllFolds, { desc = "Close all folds" })
		-- vim.keymap.set("n", "<leader>zr", ufo.openFoldsExceptKinds, { desc = "Open folds except kind" })
		-- -- closeAllFolds == closeFoldsWith(0)
		-- vim.keymap.set("n", "<leader>zm", ufo.closeFoldsWith, { desc = "Close folds with kind" })
		vim.keymap.set("n", "zK", function()
			local winid = ufo.peekFoldedLinesUnderCursor()
			if not winid then
				vim.lsp.buf.hover()
			end
		end, { desc = "Peek fold under cursor" })
	end,
}
