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
        -- Fixed: Run stylua via Mason or System Path
        lua = { "stylua" },

        -- Leverages your blazing fast ruff installation
        python = { "ruff_format" },

        -- Streamlined: Use dprint natively for all configurations and documents
        json = { "dprint" },
        yaml = { "dprint" },
        toml = { "taplo" },
        markdown = { "dprint" },

        -- Leverages your native shfmt package
        bash = { "shfmt" },
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
