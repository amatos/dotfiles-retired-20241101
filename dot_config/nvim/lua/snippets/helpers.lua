local ls = require("luasnip")
local sn = ls.snippet_node
local i = ls.insert_node

local M = {}

M.fill = function(_, parent, args)
  local title = ""
  local chars = {}

  if #parent.snippet.env.LS_SELECT_RAW > 0 then
    for _, ele in ipairs(parent.snippet.env.LS_SELECT_RAW) do
      title = title .. ele .. " "
    end
  end

  for str in string.gmatch(args, "([^%%]+)") do
    table.insert(chars, str)
  end

  local snip = chars[1] .. " " .. title

  local _, c = unpack(vim.api.nvim_win_get_cursor(0))

  while #snip < (vim.bo.tw - c - 1) do
    snip = snip .. chars[2]
  end

  return snip
end

M.get_visual = function(_, parent)
  if #parent.snippet.env.LS_SELECT_RAW > 0 then
    return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
  else -- If LS_SELECT_RAW is empty, return a blank insert node
    return sn(nil, i(1))
  end
end

return M
