return {
  {
    "L3MON4D3/LuaSnip",
    keys = { { "<Tab>" } },
    opts = {
      store_selection_keys = "<Tab>",
    },
    config = function(_, opts)
      require("luasnip").setup(opts)

      require("luasnip.loaders.from_lua").lazy_load({ lazy_paths = { "~/.config/nvim/lua/snippets" } })
    end,
  },
}
