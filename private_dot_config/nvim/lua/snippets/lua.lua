local ls = require("luasnip")
local s = ls.snippet
local f = ls.function_node
local fill = require("snippets.helpers").fill

return {
  s({ trig = "dc", desc = "divider comment" }, f(fill, {}, { user_args = { "--%-- " } })),
}
