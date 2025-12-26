return {
  -- https://github.com/gbprod/substitute.nvim
  "gbprod/substitute.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = function(_, opts)
    local substitute = require("substitute")

    -- I would choose 's', but it's used in flash plugin
    vim.keymap.set("n", "e", substitute.operator, { desc = "Substitute with motion" })
    vim.keymap.set("n", "ee", substitute.line, { desc = "Substitute line" })
    vim.keymap.set("n", "E", substitute.eol, { desc = "Substitute to end of line" })
    vim.keymap.set("x", "e", substitute.visual, { desc = "Substitute in visual mode" })
  end,
}
