-- lua/plugins/treesitter.lua
return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    require('nvim-treesitter').setup({
      ensure_installed = {
        'python', 'javascript', 'typescript', 'lua', 'query',
        'vim', 'vimdoc', 'c', 'bash', 'html', 'css', 'json',
        'yaml', 'markdown', 'markdown_inline',
      },
      -- highlight and indent are top-level in v1 (no configs sub-module)
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = {
        enable = true,
      },
    })
  end,
}
