local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

return {
  s(
    { trig = "sd!", desc = "Saudade page" },
    fmt(
      [[
        <html lang="en">
          <head>
            <meta charset="UTF-8" />
            <meta name="viewport" content="width=device-width, initial-scale=1.0" />
            <title>{}</title>
            <link rel="stylesheet" href="/style.css" />

            <!-- saudade includes -->
            <script src="/saudade.js@root" type="module"></script>
          </head>
          <body>
            {}
          </body>
        </html>
      ]],
      { i(1), i(0) }
    )
  ),
}
