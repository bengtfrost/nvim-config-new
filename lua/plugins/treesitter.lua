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
    })

    -- v1: highlight and indent are enabled via vim.treesitter directly
    vim.api.nvim_create_autocmd("FileType", {
      callback = function(args)
        local ok = pcall(vim.treesitter.start, args.buf)
        if not ok then
          vim.bo[args.buf].syntax = "on"
        end
      end,
    })
  end,
}
