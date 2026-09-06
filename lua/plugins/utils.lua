-- lua/plugins/utils.lua
return {
  -- WhichKey
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    dependencies = { "echasnovski/mini.icons" },
    config = function()
      local wk = require("which-key")

      wk.setup({
        plugins = {
          marks = true,
          registers = true,
          spelling = {
            enabled = true,
            suggestions = 20,
          },
        },
        icons = {
          breadcrumb = "»",
          separator = "➜",
          group = "+",
        },
        layout = {
          height = { min = 4, max = 25 },
          width = { min = 20, max = 50 },
          spacing = 3,
          align = "left",
        },
        -- Keep win options minimal to avoid rendering issues
        win = {
          border = "rounded",
          padding = { 1, 2, 1, 2 },
        },
      })
    end,
  },

  -- Mini Icons
  {
    "echasnovski/mini.icons",
    lazy = true,
  },

  -- Auto-pairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup()
    end,
  },

  -- Trouble (better diagnostics)
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
      { "<leader>xq", "<cmd>Trouble quickfix toggle<cr>",    desc = "Quickfix (Trouble)" },
      { "<leader>xl", "<cmd>Trouble loclist toggle<cr>",     desc = "Location List (Trouble)" },
    },
    opts = {
      -- Your Trouble config here
      use_diagnostic_signs = true,
    },
  },

  -- Mini Surround
  {
    "echasnovski/mini.surround",
    version = "*",
    config = function()
      require("mini.surround").setup()
    end,
  },

  -- Optional: Better escape
  -- {
  --   'max397574/better-escape.nvim',
  --   event = "InsertEnter",
  --   config = function()
  --     require('better_escape').setup()
  --   end,
  -- },
}
