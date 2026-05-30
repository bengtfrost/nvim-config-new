-- lua/plugins/lsp.lua
return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "williamboman/mason.nvim",
        config = function()
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

      -- 1. Apply global capabilities to all servers
      vim.lsp.config("*", {
        capabilities = capabilities,
      })

      -- 2. Server-specific configurations (before vim.lsp.enable)

      vim.lsp.config("rust_analyzer", {
        cmd = { vim.fn.exepath("rust-analyzer") },
        filetypes = { "rust" },
        root_markers = { "Cargo.toml", "Cargo.lock" },
      })

      vim.lsp.config("marksman", {
        filetypes = { "markdown" },
      })

      vim.lsp.config("lua_ls", {
        root_markers = { "init.lua", ".git" },
        settings = {
          Lua = {
            runtime = { version = "Neovim" },
            workspace = {
              library = {
                vim.fn.expand("$VIMRUNTIME/lua"),
                vim.fn.stdpath("config") .. "/lua",
              },
              checkThirdParty = false,
            },
            diagnostics = { globals = { "vim", "require" } },
            telemetry = { enable = false },
            hint = { enable = true },
          },
        },
      })

      -- 3. LSP keymaps via LspAttach
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
            map({ "n", "v" }, "<leader>lf",
              "<cmd>echo 'Use Conform for formatting (<leader>fd)'<CR>",
              vim.tbl_extend("force", opts, { desc = "LSP Formatting (Disabled, use Conform)" }))
          end

          -- Navigation
          map("n", "gD", vim.lsp.buf.declaration,
            vim.tbl_extend("force", opts, { desc = "Go to Declaration" }))
          map("n", "gd", vim.lsp.buf.definition,
            vim.tbl_extend("force", opts, { desc = "Go to Definition" }))
          map("n", "gi", vim.lsp.buf.implementation,
            vim.tbl_extend("force", opts, { desc = "Go to Implementation" }))
          map("n", "gr", vim.lsp.buf.references,
            vim.tbl_extend("force", opts, { desc = "Go to References" }))
          map("n", "<leader>D", vim.lsp.buf.type_definition,
            vim.tbl_extend("force", opts, { desc = "Go to Type Definition" }))

          -- Hover & Signature
          map("n", "K", vim.lsp.buf.hover,
            vim.tbl_extend("force", opts, { desc = "Hover Documentation" }))
          map("n", "<leader>k", vim.lsp.buf.signature_help,
            vim.tbl_extend("force", opts, { desc = "Signature Help" }))

          -- Refactoring
          map("n", "<leader>rn", vim.lsp.buf.rename,
            vim.tbl_extend("force", opts, { desc = "Rename Symbol" }))
          map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action,
            vim.tbl_extend("force", opts, { desc = "Code Action" }))

          -- Workspace
          map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder,
            vim.tbl_extend("force", opts, { desc = "Workspace: Add Folder" }))
          map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder,
            vim.tbl_extend("force", opts, { desc = "Workspace: Remove Folder" }))
          map("n", "<leader>wl", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, vim.tbl_extend("force", opts, { desc = "Workspace: List Folders" }))

          -- Diagnostics
          map("n", "<leader>e", vim.diagnostic.open_float,
            vim.tbl_extend("force", opts, { desc = "Show Line Diagnostics" }))
          map("n", "[d", vim.diagnostic.goto_prev,
            vim.tbl_extend("force", opts, { desc = "Previous Diagnostic" }))
          map("n", "]d", vim.diagnostic.goto_next,
            vim.tbl_extend("force", opts, { desc = "Next Diagnostic" }))
          map("n", "<leader>dq", vim.diagnostic.setloclist,
            vim.tbl_extend("force", opts, { desc = "Diagnostics Quickfix List" }))
        end,
      })

      -- 4. Enable system-managed servers
      local system_servers = {
        "ts_ls",
        "basedpyright",
        "rust_analyzer",
        "clangd",
        "bashls",
        "jsonls",
        "html",
        "cssls",
        "marksman",
      }
      for _, server in ipairs(system_servers) do
        vim.lsp.enable(server)
      end

      -- 5. Mason-managed LSP servers
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls" },
      })
      vim.lsp.enable("lua_ls")
      vim.lsp.enable("taplo")
    end,
  },
}
