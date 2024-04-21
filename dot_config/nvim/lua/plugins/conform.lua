local util = require("conform.util")

return {
  {
    "stevearc/conform.nvim",

    -- @class ConformOpts
    opts = {
      formatters_by_ft = {
        -- lua
        lua = { "stylua" },

        -- data/conf
        sql = { "prettier" },
        json = { "prettier" },
        toml = { "taplo" },
        yaml = { "prettier" },

        -- web
        html = { "prettier" },
        liquid = { "prettier" },
        css = { "stylelint", "prettier" },
        scss = { "stylelint", "prettier" },
        javascript = { "eslint", "prettier" },
        typescript = { "eslint", "prettier" },
        vue = { "eslint", "prettier" },
        markdown = { "prettier" },

        -- php
        php = { "pint" },
        blade = { "blade-formatter", "rustywind" },

        -- shell
        sh = { "shellcheck", "shfmt" },
        fish = { "fish_indent" },

        -- misc
        ruby = { "prettier" },
      },
      formatters = {
        shfmt = {
          prepend_args = { "--indent=2", "--case-indent", "--binary-next-line", "--func-next-line" },
        },
        pint = {
          meta = {
            url = "https://github.com/laravel/pint",
            description = "Laravel Pint is an opinionated PHP code style fixer for minimalists. Pint is built on top of PHP-CS-Fixer and makes it simple to ensure that your code style stays clean and consistent.",
          },
          command = util.find_executable({
            vim.fn.stdpath("data") .. "/mason/bin/pint",
            "vendor/bin/pint",
          }, "pint"),
          args = { "$FILENAME" },
          stdin = false,
        },
      },
    },
  },
}
