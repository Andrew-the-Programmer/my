return {
  "epwalsh/obsidian.nvim",
  opts = function(_, opts)
    opts.workspaces = {
      {
        name = "Ideas",
        path = "~/tmp/Ideas",
        overrides = {
          notes_subdir = "ideas",
        },
      },
    }
  end,
}
