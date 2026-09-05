-- lua/plugins/formatter.lua
return {
  {
    'stevearc/conform.nvim',
    event = { "BufWritePre" },
    cmd = { "ConformInfo", "Format" },
    keys = {
      {
        "<leader>fd",
        function()
          require("conform").format({ async = true, lsp_fallback = "always" })
        end,
        mode = { "n", "v" },
        desc = "Format Document/Selection",
      },
    },
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "ruff_format" },
        json = { "dprint" },
        yaml = { "dprint" },
        toml = { "taplo" },
        -- markdown = { "dprint" }, -- Disabled to avoid markdown formatting issues
        bash = { "shfmt" },
        sh = { "shfmt" },
        c = { "clang-format" },
        cpp = { "clang-format" },
      },
      format_on_save = {
        timeout_ms = 2000,
        lsp_fallback = "always",
      },
      formatters = {
        shfmt = { args = { "-i", "2" } },
        ["clang-format"] = {
          args = { "--style=llvm", "-assume-filename", "$FILENAME" },
        },
      },
    },
  },
}