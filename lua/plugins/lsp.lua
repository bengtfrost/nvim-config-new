-- lua/plugins/lsp.lua
return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
      "b0o/schemastore.nvim",
    },
    config = function()
      local cmp_nvim_lsp = require("cmp_nvim_lsp")
      local capabilities = cmp_nvim_lsp.default_capabilities()

      -- Helper function to get system executable path
      local function get_cmd(executable, args, silent)
        local path = vim.fn.exepath(executable)
        if path == "" then
          local common_paths = {
            vim.fn.expand("~/.cargo/bin/" .. executable),
            vim.fn.expand("~/.local/bin/" .. executable),
            vim.fn.expand("~/.deno/bin/" .. executable),
            "/usr/local/bin/" .. executable,
            "/usr/bin/" .. executable,
          }
          for _, p in ipairs(common_paths) do
            if vim.fn.executable(p) == 1 then
              path = p
              break
            end
          end
          if path == "" then
            if not silent then
              vim.notify("Warning: " .. executable .. " not found in PATH", vim.log.levels.WARN)
            end
            return nil
          end
        end
        if args then
          return vim.list_extend({ path }, args)
        end
        return { path }
      end

      -- Global capabilities for all LSP servers
      vim.lsp.config("*", {
        capabilities = capabilities,
      })

      -- Server configurations
      local servers = {
        lua_ls = {
          executable = "lua-language-server",
          opts = {
            filetypes = { "lua" },
            root_markers = {
              ".luarc.json",
              ".luarc.jsonc",
              ".luacheckrc",
              ".stylua.toml",
              "stylua.toml",
              "selene.toml",
              ".git",
            },
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
          },
        },
        basedpyright = {
          executable = "basedpyright-langserver",
          args = { "--stdio" },
          opts = {
            filetypes = { "python" },
            root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", ".git" },
            settings = {
              basedpyright = {
                analysis = {
                  typeCheckingMode = "basic",
                  autoSearchPaths = true,
                  useLibraryCodeForTypes = true,
                },
              },
            },
          },
        },
        rust_analyzer = {
          executable = "rust-analyzer",
          opts = {
            filetypes = { "rust" },
            root_markers = { "Cargo.toml", "Cargo.lock" },
            settings = {
              ["rust-analyzer"] = {
                check = {
                  command = "clippy",
                },
              },
            },
          },
        },
        denols = {
          executable = "deno",
          opts = {
            filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
            root_markers = { "deno.json", "deno.jsonc" },
          },
        },
        ts_ls = {
          executable = "typescript-language-server",
          args = { "--stdio" },
          opts = {
            filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
            root_markers = { "package.json", "tsconfig.json" },
            single_file_support = false,
            init_options = {
              hostInfo = "neovim",
            },
          },
        },
        clangd = {
          executable = "clangd",
          opts = {
            filetypes = { "c", "cpp", "objc", "objcpp" },
            root_markers = { ".clangd", "compile_commands.json", "compile_flags.txt", ".git" },
            on_init = function(client, _)
              client.server_capabilities.offsetEncoding = { "utf-8" }
            end,
          },
        },
        bashls = {
          executable = "bash-language-server",
          args = { "start" },
          opts = {
            filetypes = { "sh", "bash" },
            root_markers = { ".git" },
          },
        },
        marksman = {
          executable = "marksman",
          opts = {
            filetypes = { "markdown" }, -- Removed markdown.mdx, handled by filetype detection
            root_markers = { ".marksman.toml", ".git" },
            single_file_support = true,
            -- Optional: marksman settings (if supported)
            -- settings = {
            --   marksman = {
            --     enable = true,
            --   },
            -- },
          },
        },
        taplo = {
          executable = "taplo",
          args = { "lsp", "stdio" },
          opts = {
            filetypes = { "toml" },
            root_markers = { ".git" },
            on_init = function(client, _)
              client.server_capabilities.semanticTokensProvider = nil
            end,
            settings = {
              schema = {
                enabled = false,
                catalogs = {},
              },
            },
          },
        },
        yamlls = {
          executable = "yaml-language-server",
          args = { "--stdio" },
          opts = {
            filetypes = { "yaml" }, -- Only yaml, yml is handled by filetype detection
            root_markers = { ".git", ".yamllint", "yamlfmt.yaml" },
            single_file_support = true,
            settings = {
              yaml = {
                schemas = require("schemastore").yaml.schemas(),
                format = {
                  enable = true,
                  singleQuote = false,
                  bracketSpacing = true,
                },
                validate = true,
                hover = true,
                completion = true,
                customTags = {
                  "!reference sequence",
                  "!include sequence",
                  "!tag scalar",
                },
              },
              redhat = {
                telemetry = {
                  enabled = false,
                },
              },
            },
          },
        },
        -- Optional: JSON language server for better JSON support
        -- jsonls = {
        --   executable = "json-language-server",
        --   args = { "--stdio" },
        --   opts = {
        --     filetypes = { "json", "jsonc" },
        --     root_markers = { ".git" },
        --     settings = {
        --       json = {
        --         schemas = require("schemastore").json.schemas(),
        --         validate = { enable = true },
        --       },
        --     },
        --   },
        -- },
      }

      -- Configure and enable each server
      local configured_servers = {}
      for name, server in pairs(servers) do
        local cmd = get_cmd(server.executable, server.args, true)
        if cmd then
          server.opts.cmd = cmd
          vim.lsp.config(name, server.opts)
          table.insert(configured_servers, name)
        end
      end

      for _, name in ipairs(configured_servers) do
        vim.lsp.enable(name)
      end

      -- LSP keymaps via LspAttach
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
            map(
              { "n", "v" },
              "<leader>lf",
              "<cmd>echo 'Use Conform for formatting (<leader>fd)'<CR>",
              vim.tbl_extend("force", opts, { desc = "LSP Formatting (Disabled)" })
            )
          end

          -- Navigation
          map(
            "n",
            "gD",
            vim.lsp.buf.declaration,
            vim.tbl_extend("force", opts, { desc = "Go to Declaration" })
          )
          map("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Go to Definition" }))
          map(
            "n",
            "gi",
            vim.lsp.buf.implementation,
            vim.tbl_extend("force", opts, { desc = "Go to Implementation" })
          )
          map("n", "gR", vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "Go to References" }))
          map(
            "n",
            "<leader>D",
            vim.lsp.buf.type_definition,
            vim.tbl_extend("force", opts, { desc = "Go to Type Definition" })
          )

          -- Hover & Signature
          map("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Hover Documentation" }))
          map(
            "n",
            "<leader>k",
            vim.lsp.buf.signature_help,
            vim.tbl_extend("force", opts, { desc = "Signature Help" })
          )

          -- Refactoring
          map(
            "n",
            "<leader>rn",
            vim.lsp.buf.rename,
            vim.tbl_extend("force", opts, { desc = "Rename Symbol" })
          )
          map(
            { "n", "v" },
            "<leader>ca",
            vim.lsp.buf.code_action,
            vim.tbl_extend("force", opts, { desc = "Code Action" })
          )

          -- Workspace
          map(
            "n",
            "<leader>wa",
            vim.lsp.buf.add_workspace_folder,
            vim.tbl_extend("force", opts, { desc = "Workspace: Add Folder" })
          )
          map(
            "n",
            "<leader>wr",
            vim.lsp.buf.remove_workspace_folder,
            vim.tbl_extend("force", opts, { desc = "Workspace: Remove Folder" })
          )
          map("n", "<leader>wl", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, vim.tbl_extend("force", opts, { desc = "Workspace: List Folders" }))

          -- Diagnostics
          map(
            "n",
            "<leader>e",
            vim.diagnostic.open_float,
            vim.tbl_extend("force", opts, { desc = "Show Line Diagnostics" })
          )
          map(
            "n",
            "[d",
            vim.diagnostic.goto_prev,
            vim.tbl_extend("force", opts, { desc = "Previous Diagnostic" })
          )
          map(
            "n",
            "]d",
            vim.diagnostic.goto_next,
            vim.tbl_extend("force", opts, { desc = "Next Diagnostic" })
          )
          map(
            "n",
            "<leader>dq",
            vim.diagnostic.setloclist,
            vim.tbl_extend("force", opts, { desc = "Diagnostics Quickfix List" })
          )
        end,
      })
    end,
  },
}
