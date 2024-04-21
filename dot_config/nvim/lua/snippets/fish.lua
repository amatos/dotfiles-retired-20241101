local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt
local fill = require("snippets.helpers").fill

return {
  s({ trig = "dc", desc = "divider comment" }, f(fill, {}, { user_args = { "#%- " } })),

  s({ trig = "#!", desc = "shebang" }, t("#!/usr/bin/env fish")),

  s(
    { trig = "if", desc = "if ... end" },
    fmt(
      [[
        if {}
            {}
        end
      ]],
      { i(1), i(0) }
    )
  ),

  s(
    { trig = "elif", desc = "else if ..." },
    fmt(
      [[
        else if {}
            {}
      ]],
      { i(1), i(0) }
    )
  ),

  s(
    { trig = "fori", desc = "for ... in ... end" },
    fmt(
      [[
        for {} in {}
            {}
        end
      ]],
      { i(1), i(2), i(0) }
    )
  ),

  s(
    { trig = "wh", desc = "while ... end" },
    fmt(
      [[
        while {}
            {}
        end
      ]],
      { i(1), i(0) }
    )
  ),

  s(
    { trig = "wht", desc = "while true ... end" },
    fmt(
      [[
        while true
            {}
        end
      ]],
      { i(0) }
    )
  ),

  s(
    { trig = "sw", desc = "switch ... case ... end" },
    fmt(
      [[
        switch {}
            case {}
                {}
        end
      ]],
      { i(1), i(2), i(0) }
    )
  ),

  s(
    { trig = "func", desc = "function ... end" },
    fmt(
      [[
        function {}
            {}
        end
      ]],
      { i(1), i(0) }
    )
  ),

  s({ trig = "dn", desc = "&>/dev/null" }, t("&>/dev/null")),

  s(
    { trig = "abbr", desc = "abbr -a ... --position ..." },
    fmt('abbr -a {} --position {} "{}"', { i(1), i(2, "command"), i(3) })
  ),
}
