-- plugins/my_statusline/statusline.lua
local filetype=""
local gitstatus="" 
local currbranch=""
local branch = ""
local function get_git_branch()
  currbranch = vim.b.gitsigns_head
  if currbranch and currbranch ~= "" then
    branch ="  on " .. currbranch
    return
  end
    branch = ""
end


local function get_git_status()
  return vim.b.gitsigns_status or ""
end


local function filetype_lower()
  local ft = vim.bo.filetype or ""
  return ft ~= "" and ft:lower() or ""
end

vim.api.nvim_create_autocmd({"BufEnter"},{
  callback = function()
      filetype=filetype_lower()
      get_git_branch()
        gitstatus=get_git_status()
      vim.cmd("redrawstatus") 
  end
})
vim.api.nvim_create_autocmd("User", {
  pattern = "GitSignsUpdate",
  callback = function()
    get_git_branch()
    gitstatus=get_git_status()
    vim.cmd("redrawstatus")
  end,
})
local function statusline()
  return table.concat({
  ---  " [%{mode()}]   ",
    " %f",                       -- File path
    "%M",                      -- Modified flag
    " ", gitstatus,      -- Git diff from gitsigns
    "%=",                      -- Right align
    filetype or "",
    "  ",                    -- Filetype
    "%l:%L|%v:%{len(getline('.'))}",
    branch or "",          -- Branch name
    "  ",
  })
end

vim.o.statusline = "%!v:lua.Statusline()"

_G.Statusline = statusline
