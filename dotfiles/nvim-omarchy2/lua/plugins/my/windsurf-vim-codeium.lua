return {
  "Exafunction/windsurf.vim",
  config = function()
    vim.g.codeium_enabled = false
    vim.g.codeium_disable_bindings = 1

    vim.keymap.set("i", ";;", function()
      return vim.fn["codeium#Accept"]()
    end, { desc = "Codeium: accept", expr = true, silent = true })

    vim.keymap.set("i", "<A-'>", function()
      return vim.fn["codeium#CycleCompletions"](1)
    end, { desc = "Codeium: next", expr = true, silent = true })

    vim.keymap.set("i", '<A-">', function()
      return vim.fn["codeium#CycleCompletions"](-1)
    end, { desc = "Codeium: prev", expr = true, silent = true })
  end,
}
