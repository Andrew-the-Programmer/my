return {
  "snacks.nvim",
  opts = function(_, opts)
    table.insert(opts.dashboard.preset.keys, 1, {
      icon = "💡",
      key = "i",
      desc = "New Idea",
      action = function()
        vim.cmd("cd ~/tmp/Ideas")
        require("lazy").load({ plugins = { "obsidian.nvim" } })
        vim.cmd("ObsidianNew")
      end,
    })
  end,
}
