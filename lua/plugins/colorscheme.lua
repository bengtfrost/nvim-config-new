-- lua/plugins/colorscheme.lua
-- Alternative Option: Carbonfox
return {
  {
    "EdenEast/nightfox.nvim",
    priority = 1000,
    lazy = false,
    config = function()
      require("nightfox").setup({
        options = {
          transparent = true, -- Set to true if you prefer foot's native background/opacity
          styles = {
            comments = "italic",
            keywords = "bold",
          }
        }
      })
      vim.cmd.colorscheme("carbonfox")
    end,
  }
}
