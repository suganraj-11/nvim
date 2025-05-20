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


--buffer--
vim.opt.splitright=true
vim.opt.splitbelow=true


---clipboard--
vim.opt.clipboard = "unnamedplus"


--line number--
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.cursorline=true
vim.api.nvim_set_hl(0, 'CursorLine', { bg = 'NONE', underline = false })
vim.opt.numberwidth=3
vim.opt.signcolumn="no"

--cmd line--
vim.opt.cmdheight = 1
vim.opt.smartcase = true
vim.opt.ignorecase = true


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

map('n','gll',vim.diagnostic.open_float)


vim.keymap.set('n','<A-.>',"<CMD>Oil<CR>",{})



--- lsps ---
local lsp_configs = {}
for _, f in pairs(vim.api.nvim_get_runtime_file('lsp/*.lua', true)) do
  local server_name = vim.fn.fnamemodify(f, ':t:r')
  table.insert(lsp_configs, server_name)
end
print(lsp_configs)
vim.lsp.enable(lsp_configs)



vim.diagnostic.config {
    severity_sort = true,
    float = { border = 'rounded', source = 'if_many' },
    underline = { severity = vim.diagnostic.severity.ERROR },
    signs=false,
    ---  signs =  {
    ---    text = {
    ---      [vim.diagnostic.severity.ERROR] = '󰅚 ',
    ---      [vim.diagnostic.severity.WARN] = '󰀪 ',
    ---      [vim.diagnostic.severity.INFO] = '󰋽 ',
    ---      [vim.diagnostic.severity.HINT] = '󰌶 ',
    ---    },
    ---  } or {},
    virtual_text = {
        source = 'if_many',
        spacing = 2,
        format = function(diagnostic)
            local diagnostic_message = {
                [vim.diagnostic.severity.ERROR] = diagnostic.message,
                [vim.diagnostic.severity.WARN] = diagnostic.message,
                [vim.diagnostic.severity.INFO] = diagnostic.message,
                [vim.diagnostic.severity.HINT] = diagnostic.message,
            }
            return diagnostic_message[diagnostic.severity]
        end,
    },
}





---custom function----
local function get_directories()
    local directories = {}

    local handle = io.popen("fd . --type directory")
    if handle then
        for line in handle:lines() do
            table.insert(directories, line)
        end
        handle:close()
    else
        print("Failed to execute fd command")
    end

    return directories
end

vim.keymap.set("n", "<leader>fk", function()
    local Snacks = require("snacks")
    local dirs = get_directories()

    return Snacks.picker({
        finder = function()
            local items = {}
            for i, item in ipairs(dirs) do
                table.insert(items, {
                    idx = i,
                    file = item,
                    text = item,
                })
            end
            return items
        end,
        layout = {
            layout = {
                box = "horizontal",
                width = 0.5,
                height = 0.5,
                {
                    box = "vertical",
                    border = "rounded",
                    title = "Find directory",
                    { win = "input", height = 1, border = "bottom" },
                    { win = "list", border = "none" },
                },
            },
        },
        format = function(item, _)
            local file = item.file
            local ret = {}
            local a = Snacks.picker.util.align
            local icon, icon_hl = Snacks.util.icon(file.ft, "directory")
            ret[#ret + 1] = { a(icon, 3), icon_hl }
            ret[#ret + 1] = { " " }
            ret[#ret + 1] = { a(file, 20) }

            return ret
        end,
        confirm = function(picker, item)
            picker:close()
            Snacks.picker.pick("files", {
                dirs = { item.file },
            })
        end,
    })
end)
