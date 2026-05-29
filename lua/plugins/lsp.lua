-- lua/plugins/lsp.lua
return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Only use Mason for what isn't natively available on your system path
      {
        'williamboman/mason.nvim',
        config = function()
          require('mason').setup({
            ensure_installed = {
              'lua_ls',
              'stylua',
            },
          })
        end,
      },
      'williamboman/mason-lspconfig.nvim',
      'hrsh7th/nvim-cmp',
      'hrsh7th/cmp-nvim-lsp',
      'stevearc/conform.nvim',
    },
    config = function()
      local cmp_nvim_lsp = require('cmp_nvim_lsp')
      local capabilities = cmp_nvim_lsp.default_capabilities()

      -- 1. Apply global configurations & capabilities using the wildcard '*'
      vim.lsp.config('*', {
        capabilities = capabilities,
      })

      -- 2. Modern LspAttach Autocommand (Replaces the old manual on_attach loops)
      vim.api.nvim_create_autocmd('LspAttach', {
        desc = 'LSP actions and keymaps',
        callback = function(args)
          local bufnr = args.buf
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if not client then return end

          local map = vim.keymap.set
          local opts = { buffer = bufnr, noremap = true, silent = true }

          -- Disable LSP formatting requests to prioritize Conform
          if client.supports_method("textDocument/formatting") then
             opts.desc = "LSP Formatting (Disabled, use Conform)"
             map({'n', 'v'}, "<leader>lf", "<cmd>echo 'Use Conform for formatting'<CR>", opts)
          end

          -- Standard LSP Navigation and Refactoring Keymaps
          map('n', 'gD', vim.lsp.buf.declaration, vim.tbl_extend('force', opts, { desc = 'Go to Declaration' }))
          -- Keep any additional mapping lines you had configured here...
        end,
      })

      -- 3. Configure and Enable System-managed Servers
      local system_servers = {
        'ts_ls',                  -- Installed via npm global
        'basedpyright',           -- Installed via uv tool
        'rust_analyzer',          -- Pre-installed system package
        'clangd',                 -- Installed via dnf clang
        'marksman',               -- Handled via custom path download
        'bashls',                 -- Installed via npm global
        'taplo',                  -- Installed via npm global
        'jsonls', 'html', 'cssls' -- Extracted servers via npm global
      }

      for _, server in ipairs(system_servers) do
        vim.lsp.enable(server)
      end

      -- 4. Configure and Enable Mason-managed Servers
      require('mason-lspconfig').setup({})

      vim.lsp.config('lua_ls', {
        root_markers = { "init.lua", ".git" }, -- Native 0.11+ root markers replacing lspconfig.util
        settings = {
          Lua = {
            runtime = { version = 'Neovim' },
            workspace = {
              library = { vim.fn.expand('$VIMRUNTIME/lua'), vim.fn.stdpath('config') .. '/lua' },
              checkThirdParty = false,
            },
            diagnostics = { globals = { 'vim', 'require' } },
            telemetry = { enable = false },
            hint = { enable = true },
          },
        },
      })
      
      vim.lsp.enable('lua_ls')
    end,
  },
}
