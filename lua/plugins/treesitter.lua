-- lua/plugins/treesitter.lua
return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    require("nvim-treesitter").setup({
      ensure_installed = {
        "python",
        "javascript",
        "typescript",
        "lua",
        "query",
        "vim",
        "vimdoc",
        "rust",
        "c",
        "cpp",
        "bash",
        "html",
        "css",
        "json",
        "yaml",
        "markdown",
        "markdown_inline",
      },
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
      },
      -- Optional: Enable incremental selection
      -- incremental_selection = {
      --   enable = true,
      --   keymaps = {
      --     init_selection = "<C-space>",
      --     node_incremental = "<C-space>",
      --     scope_incremental = false,
      --     node_decremental = "<S-C-space>",
      --   },
      -- },
    })
  end,
}