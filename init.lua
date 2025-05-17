--include--
require("config.lazy")


--indent--
vim.opt.expandtab=true
vim.opt.tabstop=4
vim.opt.softtabstop=4
vim.opt.shiftwidth=4
vim.opt.smarttab=true
vim.opt.autoindent=true
vim.opt.smartindent=true


--file--
vim.opt.undofile=true


---clipboard--
vim.opt.clipboard = "unnamedplus"


--line number--
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.cursorline=true
vim.opt.numberwidth=3

--cmd line--
vim.opt.cmdheight = 1


--keymaps--
local map = vim.keymap.set
map('n',';',':')
map("n", "vv", "V", { noremap = true, silent = true })
map("n", "<leader>rn", function()
  vim.opt.relativenumber = not vim.opt.relativenumber:get()
  vim.opt.number = vim.opt.relativenumber:get()
end, { desc = "Toggle relative number" })

map("n", "<leader>n", function()
  vim.opt.relativenumber=false
  vim.opt.number = not vim.opt.number:get()
end, { desc = "Toggle number" })
