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
        python = { "ruff_format" }, -- Leverages your blazing fast dnf ruff installation
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        toml = { "taplo" },
        markdown = { "prettier", "dprint" },
        bash = { "shfmt" }, -- Leverages your native dnf shfmt package
      },
      format_on_save = {
        timeout_ms = 1000,
        lsp_fallback = "always",
      },
      formatters = {
        shfmt = { args = { "-i", "2" } },
      },
    },
  },
}
