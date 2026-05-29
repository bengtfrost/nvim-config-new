-- lua/plugins/treesitter.lua
return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    -- Ändrat från nvim-treesitter.configs till direkt anrop på nvim-treesitter
    require('nvim-treesitter').setup({
      ensure_installed = { 'python', 'javascript', 'typescript', 'lua', 'query', 'vim', 'vimdoc', 'c', 'bash', 'html', 'css', 'json', 'yaml', 'markdown', 'markdown_inline' },
      sync_install = false,
      auto_install = true,
      modules = {},
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
