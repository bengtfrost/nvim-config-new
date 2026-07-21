-- lua/plugins/colorscheme.lua
return {
  {
    "marko-cerovac/material.nvim",
    priority = 1000,
    lazy = false,
    config = function()
      require("material").setup({
        contrast = {
          terminal = true,       -- Set to true if you prefer native background/opacity
          sidebars = true,       -- Enable contrast for sidebars
          floating_windows = true, -- Enable contrast for floating windows
          cursor_line = true,    -- Enable contrast for the cursor line
          non_current_windows = true, -- Enable contrast for non-current windows
        },
        styles = {
          comments = { italic = true },
          keywords = { bold = true },
        },
      })
      vim.g.material_style = "darker"
      vim.cmd.colorscheme("material")
    end,
  },
}
