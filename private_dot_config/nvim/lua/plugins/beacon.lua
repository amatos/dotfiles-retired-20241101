return {
  {
    "rainbowhxch/beacon.nvim",
    event = "CursorMoved",
    cond = function()
      return not vim.g.neovide
    end,
  },
}
