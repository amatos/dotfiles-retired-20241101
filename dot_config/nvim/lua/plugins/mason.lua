return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        -- general
        "commitlint",
        "prettier",

        -- data/conf
        "yamllint",

        -- php
        "blade-formatter",
        "pint",
        "rustywind",

        -- shell
        "shellcheck",
        "shfmt",
      },
    },
  },
}
