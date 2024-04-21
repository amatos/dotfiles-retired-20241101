return {
  {
    "gbprod/cutlass.nvim",
    event = "BufReadPost",
    opts = {
      cut_key = "x",
      override_del = true,
      registers = {
        select = "_",
        delete = "_",
        change = "_",
      },
    },
  },
}
