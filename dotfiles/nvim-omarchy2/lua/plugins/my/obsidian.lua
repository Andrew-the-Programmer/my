return {
  "epwalsh/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = "markdown",

  dependencies = {
    "nvim-lua/plenary.nvim", -- the only required dependency
    "nvim-telescope/telescope.nvim", -- picker
  },

  keys = {
    { "<leader>on", "<cmd>ObsidianNew<cr>", desc = "New Obsidian note", mode = "n" },
    { "<leader>oo", "<cmd>ObsidianOpen<cr>", desc = "Open a note in the Obsidian app", mode = "n" },
    { "<leader>os", "<cmd>ObsidianQuickSwitch<cr>", desc = "Search Obsidian notes", mode = "n" },
    { "<leader>op", "<cmd>ObsidianPasteImg<cr>", desc = "Paste imate from clipboard under cursor", mode = "n" },
  },

  opts = {},
}
