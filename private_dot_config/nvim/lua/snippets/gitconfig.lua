local ls = require("luasnip")
local s = ls.snippet
local f = ls.function_node
local helpers = require("snippets.helpers")

return {
  s({ trig = "dc", desc = "divider comment" }, f(helpers.fill, {}, { user_args = { "#%- " } })),
}
