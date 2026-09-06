-- lua/plugins/comment.lua
return {
  "numToStr/Comment.nvim",
  config = function()
    local comment = require("Comment")

    comment.setup({
      -- Disable default mappings to avoid delays with which-key
      create_default_mappings = false,
      -- Optional: Add padding to comments
      padding = true,
      -- Optional: Ignore certain filetypes
      ignore = nil,
    })

    -- Define custom keymaps
    local map = vim.keymap.set

    -- Toggle line comment
    map({ "n", "v" }, "<leader>gc", function()
      comment.api.toggle.linewise.current()
    end, { desc = "Toggle comment line" })

    -- Toggle block comment
    map({ "n", "v" }, "<leader>gb", function()
      comment.api.toggle.blockwise.current()
    end, { desc = "Toggle comment block" })
  end,
}
