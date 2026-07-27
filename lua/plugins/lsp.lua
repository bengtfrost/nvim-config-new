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
      "b0o/schemastore.nvim",
    },
    config = function()
      local cmp_nvim_lsp = require("cmp_nvim_lsp")
      local capabilities = cmp_nvim_lsp.default_capabilities()

      -- Helper function to get system executable path
      local function get_cmd(executable, args)
        local path = vim.fn.exepath(executable)
        if path == "" then
          -- Check common installation paths
          local common_paths = {
            vim.fn.expand("~/.cargo/bin/" .. executable),
            vim.fn.expand("~/.local/bin/" .. executable),
            vim.fn.expand("~/.npm-global/bin/" .. executable),
            "/usr/bin/" .. executable,
            "/usr/local/bin/" .. executable,
          }
          for _, p in ipairs(common_paths) do
            if vim.fn.executable(p) == 1 then
              path = p
              break
            end
          end
          if path == "" then
            vim.notify("Warning: " .. executable .. " not found in PATH", vim.log.levels.WARN)
            return { executable }
          end
        end
        if args then
          return vim.list_extend({ path }, args)
        end
        return { path }
      end

      -- Helper function for taplo (special handling)
      local function get_taplo_cmd()
        local taplo_path = vim.fn.exepath("taplo")
        if taplo_path == "" then
          -- Check common cargo installation paths
          local cargo_paths = {
            vim.fn.expand("~/.cargo/bin/taplo"),
            vim.fn.expand("~/.local/bin/taplo"),
            "/usr/local/bin/taplo",
            "/usr/bin/taplo",
          }
          for _, p in ipairs(cargo_paths) do
            if vim.fn.executable(p) == 1 then
              taplo_path = p
              break
            end
          end
          if taplo_path == "" then
            vim.notify("Warning: taplo not found in PATH or common cargo locations", vim.log.levels.WARN)
            return { "taplo", "lsp", "stdio" }
          end
        end
        return { taplo_path, "lsp", "stdio" }
      end

      -- 1. Global capabilities for all LSP servers
      vim.lsp.config("*", {
        capabilities = capabilities,
      })

      -- 2. Configure servers using vim.lsp.config

      -- Lua
      vim.lsp.config("lua_ls", {
        cmd = get_cmd("lua-language-server"),
        filetypes = { "lua" },
        root_markers = { ".luarc.json", ".luarc.jsonc", ".luacheckrc", ".stylua.toml", "stylua.toml", "selene.toml", ".git" },
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            workspace = {
              library = {
                vim.fn.expand("$VIMRUNTIME/lua"),
                vim.fn.stdpath("config") .. "/lua",
              },
              checkThirdParty = false,
            },
            diagnostics = {
              globals = { "vim", "require" },
            },
            telemetry = { enable = false },
            hint = { enable = true },
          },
        },
      })

      -- Python
      vim.lsp.config("basedpyright", {
        cmd = get_cmd("basedpyright-langserver"),
        filetypes = { "python" },
        root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", ".git" },
        settings = {
          basedpyright = {
            analysis = {
              typeCheckingMode = "basic",
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              pythonPath = "/usr/bin/python3",
            },
          },
        },
      })

      -- Rust
      vim.lsp.config("rust_analyzer", {
        cmd = get_cmd("rust-analyzer"),
        filetypes = { "rust" },
        root_markers = { "Cargo.toml", "Cargo.lock" },
        settings = {
          ["rust-analyzer"] = {
            check = {
              command = "clippy",
            },
          },
        },
      })

      -- TypeScript/JavaScript
      vim.lsp.config("ts_ls", {
        cmd = get_cmd("typescript-language-server", { "--stdio" }),
        filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
        root_markers = { "package.json", "tsconfig.json", ".git" },
        init_options = {
          hostInfo = "neovim",
        },
      })

      -- C/C++
      vim.lsp.config("clangd", {
        cmd = get_cmd("clangd"),
        filetypes = { "c", "cpp", "objc", "objcpp" },
        root_markers = { ".clangd", "compile_commands.json", "compile_flags.txt", ".git" },
        -- Suppress the offsetEncoding warning
        on_init = function(client, _)
          client.server_capabilities.offsetEncoding = { "utf-8" }
        end,
      })

      -- Bash
      vim.lsp.config("bashls", {
        cmd = get_cmd("bash-language-server", { "start" }),
        filetypes = { "sh", "bash" },
        root_markers = { ".git" },
      })

      -- JSON
      vim.lsp.config("jsonls", {
        cmd = get_cmd("vscode-json-language-server", { "--stdio" }),
        filetypes = { "json", "jsonc" },
        root_markers = { ".git" },
        settings = {
          json = {
            schemas = require("schemastore").json.schemas(),
            validate = { enable = true },
          },
        },
      })

      -- HTML
      vim.lsp.config("html", {
        cmd = get_cmd("vscode-html-language-server", { "--stdio" }),
        filetypes = { "html" },
        root_markers = { ".git" },
      })

      -- CSS
      vim.lsp.config("cssls", {
        cmd = get_cmd("vscode-css-language-server", { "--stdio" }),
        filetypes = { "css", "scss", "less" },
        root_markers = { ".git" },
      })

      -- Markdown
      vim.lsp.config("marksman", {
        cmd = get_cmd("marksman"),
        filetypes = { "markdown" },
        root_markers = { ".git" },
      })

      -- TOML
      vim.lsp.config("taplo", {
        cmd = get_taplo_cmd(),
        filetypes = { "toml" },
        root_markers = { ".git" },
        on_init = function(client, _)
          client.server_capabilities.semanticTokensProvider = nil
        end,
      })

      -- YAML
      vim.lsp.config("yamlls", {
        cmd = get_cmd("yaml-language-server", { "--stdio" }),
        filetypes = { "yaml", "yml" },
        root_markers = { ".git" },
        settings = {
          yaml = {
            schemas = require("schemastore").yaml.schemas(),
          },
        },
      })

      -- 3. Enable all configured LSP servers
      local servers_to_enable = {
        "lua_ls",
        "basedpyright",
        "rust_analyzer",
        "ts_ls",
        "clangd",
        "bashls",
        "jsonls",
        "html",
        "cssls",
        "marksman",
        "taplo",
        "yamlls",
      }

      for _, server in ipairs(servers_to_enable) do
        vim.lsp.enable(server)
      end

      -- 4. LSP keymaps via LspAttach
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

      -- 5. Setup Mason (only for tools not installed system-wide)
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = {},
        automatic_installation = false,
        handlers = {
          function(server_name)
            -- Skip all servers since they're installed system-wide
          end,
        },
      })
    end,
  },
}