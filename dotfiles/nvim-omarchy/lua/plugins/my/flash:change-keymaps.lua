-- https://github.com/folke/flash.nvim
-- flash.nvim lets you navigate your code with search labels, enhanced
-- character motions, and Treesitter integration.
return {
  "folke/flash.nvim",
  keys = function(_, keys)
    return {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash",
      },
      {
        "S",
        mode = { "n", "x", "o" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      },
    }
  end,
}
