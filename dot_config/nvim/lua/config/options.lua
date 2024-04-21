-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.o.shiftwidth = 0
vim.o.tabstop = 2
vim.o.expandtab = true

vim.o.textwidth = 80
vim.o.colorcolumn = "+1"

vim.o.number = true
vim.o.relativenumber = true

vim.o.wrap = false

vim.g.diffopt = "filler,vertical,closeoff,internal"

vim.filetype.add({
  extension = {
    env = "conf",
  },
  filename = {
    [".env"] = "conf",
  },
  pattern = {
    ["%.env%.[%w_.-]+"] = "conf",
  },
})
