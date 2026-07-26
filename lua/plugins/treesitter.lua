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
      -- Enable these features
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
      },
    })
  end,
}