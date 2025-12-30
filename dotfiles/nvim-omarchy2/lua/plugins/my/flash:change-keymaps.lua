-- https://github.com/folke/flash.nvim
-- flash.nvim lets you navigate your code with search labels, enhanced
-- character motions, and Treesitter integration.
return {
  "folke/flash.nvim",
  -- disable lazyvim keymaps, see config/keymaps.lua
  keys = function(_, _)
    return {}
  end,
}
