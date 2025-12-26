return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "onsails/lspkind.nvim",
  },
  opts = function(_, opts)
    local cmp = require("cmp")
    local auto_select = true

    opts.mapping = cmp.mapping.preset.insert({
      ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
      ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
      ["<C-b>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<CR>"] = LazyVim.cmp.confirm({ select = auto_select }),
      ["<C-l>"] = LazyVim.cmp.confirm({ select = auto_select }),
      ["<tab>"] = function(fallback)
        return LazyVim.cmp.map({ "snippet_forward", "ai_nes", "ai_accept" }, fallback)()
      end,
    })

    opts.window = {
      completion = {
        scrollbar = false,
      },
    }

    local lspkind = require("lspkind")

    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "path" },
      }, {
        {
          name = "cmdline",
          option = {
            ignore_cmds = { "Man", "!" },
          },
        },
      }),
    })

    opts.formatting = {
      expandable_indicator = true,
      format = lspkind.cmp_format({
        mode = "symbol_text",
        maxwidth = 50,
        ellipsis_char = "...",
        menu = {
          ultisnips = "[UltiSnips]",
          luasnip = "[LuaSnip]",
          nvim_lsp = "[LSP]",
          buffer = "[Buffer]",
          path = "[PATH]",
          lazydev = "[LazyDev]",
          copilot = "[Copilot]",
        },
      }),
    }
  end,
}
