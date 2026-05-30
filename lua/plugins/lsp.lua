-- lua/plugins/lsp.lua
return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "williamboman/mason.nvim",
        config = function()
          -- Base mason setup takes configuration options, NOT tool lists
          require("mason").setup()
        end,
      },
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
      "stevearc/conform.nvim",
    },
    config = function()
      local cmp_nvim_lsp = require("cmp_nvim_lsp")
      local capabilities = cmp_nvim_lsp.default_capabilities()

      -- 1. Apply global configurations & capabilities using the wildcard '*'
      vim.lsp.config("*", {
        capabilities = capabilities,
      })

      -- 2. Modern LspAttach Autocommand
      vim.api.nvim_create_autocmd("LspAttach", {
        desc = "LSP actions and keymaps",
        callback = function(args)
          local bufnr = args.buf
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if not client then
            return
          end

          local map = vim.keymap.set
          local opts = { buffer = bufnr, noremap = true, silent = true }

          if client:supports_method("textDocument/formatting") then
            opts.desc = "LSP Formatting (Disabled, use Conform)"
            map({ "n", "v" }, "<leader>lf", "<cmd>echo 'Use Conform for formatting'<CR>", opts)
          end

          map(
            "n",
            "gD",
            vim.lsp.buf.declaration,
            vim.tbl_extend("force", opts, { desc = "Go to Declaration" })
          )
        end,
      })

      -- 3. Configure and Enable Simple System-managed Servers
      local system_servers = {
        "ts_ls",
        "basedpyright",
        "rust_analyzer",
        "clangd",
        "bashls",
        "jsonls",
        "html",
        "cssls",
      }

      for _, server in ipairs(system_servers) do
        vim.lsp.enable(server)
      end

      -- 4. Corrected: Let mason-lspconfig handle the automatic downloads
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "taplo", -- mason-lspconfig will now properly download the full LSP binary
        },
      })

      -- Marksman Configuration
      vim.lsp.config("marksman", {
        filetypes = { "markdown" },
      })
      vim.lsp.enable("marksman")

      -- Taplo Configuration
      vim.lsp.enable("taplo")

      -- Lua_ls Configuration
      vim.lsp.config("lua_ls", {
        root_markers = { "init.lua", ".git" },
        settings = {
          Lua = {
            runtime = { version = "Neovim" },
            workspace = {
              library = { vim.fn.expand("$VIMRUNTIME/lua"), vim.fn.stdpath("config") .. "/lua" },
              checkThirdParty = false,
            },
            diagnostics = { globals = { "vim", "require" } },
            telemetry = { enable = false },
            hint = { enable = true },
          },
        },
      })
      vim.lsp.enable("lua_ls")
    end,
  },
}
