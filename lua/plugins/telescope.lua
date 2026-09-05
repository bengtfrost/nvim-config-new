-- lua/plugins/telescope.lua
return {
  {
    "nvim-telescope/telescope.nvim",
    branch = "master",  -- Use master for latest stable features
    lazy = true,
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = function()
          return vim.fn.executable("make") == 1
        end,
      },
    },
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>",  desc = "[F]ind [F]iles" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>",   desc = "[F]ind by [G]rep" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>",     desc = "[F]ind [B]uffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>",   desc = "[F]ind [H]elp" },
      { "<leader>fo", "<cmd>Telescope oldfiles<cr>",    desc = "[F]ind [O]ld Files" },
      { "<leader>fr", "<cmd>Telescope resume<cr>",      desc = "[F]ind [R]esume" },
      { "<leader>fD", "<cmd>Telescope diagnostics<cr>", desc = "[F]ind [D]iagnostics" },
    },
    config = function()
      local telescope = require("telescope")
      
      telescope.setup({
        defaults = {
          prompt_prefix = " ",
          selection_caret = " ",
          layout_strategy = "horizontal",
          layout_config = {
            horizontal = { preview_width = 0.55 },
            vertical = { mirror = false },
          },
          sorting_strategy = "ascending",
          file_ignore_patterns = {
            "%.git/",
            "node_modules/",
            "%.lock",
            "__pycache__/",
            "%.ipynb",
            "%.o",
            "%.a",
            "%.out",
            "%.class",
          },
        },
        pickers = {
          find_files = {
            -- Optional: Use ripgrep for faster file finding
            -- find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
          },
          live_grep = {
            -- Optional: Include hidden files
            -- additional_args = { "--hidden" },
          },
        },
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          },
        },
      })

      -- Load extensions
      pcall(telescope.load_extension, "fzf")
    end,
  },
}