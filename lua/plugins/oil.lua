return
  {
    'stevearc/oil.nvim',
    lazy=false,
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {},
    config = function()
     --- require("oil").setup({
     ---   columns = {"icon","size","mtime"},
     --- })
      require("oil").setup()
      vim.keymap.set('n','<C-l>',"<CMD>Oil<CR>",{})
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "oil",
        callback = function()
          vim.keymap.set("n", "q", ":bd<CR>", { buffer = true, silent = true })
        end,
      })
    ---  vim.api.nvim_create_autocmd({ "BufWritePost", "BufLeave", "TextChanged" }, {
    ---    pattern = "oil",
    ---    callback = function()
    ---      -- Adjust based on your snacks implementation
    ---      require("snacks.picker.smart").refresh()
    ---    end,
---  })
    end,

    -- Optional dependencies
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
  }

