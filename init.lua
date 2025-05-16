vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
require("config.lazy")
---require("custom.statusline")
---clipboard--
vim.opt.clipboard = "unnamedplus"


--line number--

vim.opt.relativenumber = true
vim.opt.number = true  
vim.opt.numberwidth=3
vim.opt.laststatus=3
vim.opt.cmdheight = 1

---status line---
---vim.opt.statusline ="%F %M%=%Y   %l:%L|%c   "

--keymaps--
local map = vim.keymap.set
map('n',';',':')
map("n", "vv", "V", { noremap = true, silent = true })
map("n", "<leader>rn", function()
  vim.opt.relativenumber = not vim.opt.relativenumber:get()
  vim.opt.number = vim.opt.relativenumber:get()
end, { desc = "Toggle relative number" })

-- Toggle number with <leader>n
map("n", "<leader>n", function()
  vim.opt.relativenumber=false
  vim.opt.number = not vim.opt.number:get()
end, { desc = "Toggle number" })
