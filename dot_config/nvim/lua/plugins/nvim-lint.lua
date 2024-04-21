return {
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        gitcommit = { "commitlint" },
        sql = { "sqlfluff" },
        yaml = { "yamllint" },
        bash = { "shellcheck" },
        sh = { "shellcheck" },
      },
      linters = {
        commitlint = {
          args = {
            "--config ~/.config/git/commitlint.config.js",
          },
        },
      },
    },
  },
}
