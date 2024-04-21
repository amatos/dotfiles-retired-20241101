return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        -- general
        "comment",

        -- git
        "diff",
        "git_config",
        "git_rebase",
        "gitattributes",
        "gitcommit",
        "gitignore",

        -- data/conf
        "ini",
        "ssh_config",
        "toml",

        -- web
        "html",
        "css",
        "scss",
        "javascript",
        "jsdoc",
        "vue",

        -- php
        "php_only",
        "phpdoc",

        -- shell
        "bash",
        "fish",
      },
    },

    config = function(_, opts)
      ---@class ParserInfo[]
      local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

      parser_config.blade = {
        install_info = {
          url = "https://github.com/EmranMR/tree-sitter-blade",
          files = {
            "src/parser.c",
          },
          generate_requires_npm = true,
          requires_generate_from_grammar = true,
        },
        filetype = "blade",
      }

      require("nvim-treesitter.configs").setup(opts)
    end,
  },
}
