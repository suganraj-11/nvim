return {
    "nvim-treesitter/nvim-treesitter",
    --event = { "BufReadPost", "BufNewFile" },
--    lazy = true,
    build = ":TSUpdate",
    config = function () 
      local configs = require("nvim-treesitter.configs")

      configs.setup({
          ensure_installed = { "c", "lua","css","javascript", "html","dart" },
          sync_install = false,
          highlight = { enable = true },
          indent = { enable = true },  
        })
    end
 }
