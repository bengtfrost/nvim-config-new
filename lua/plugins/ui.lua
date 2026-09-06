-- lua/plugins/ui.lua
return {
  -- Icons
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
  },

  -- File Explorer
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      { "<leader>n", "<cmd>NvimTreeToggle<CR>", desc = "Toggle file explorer" },
    },
    config = function()
      require("nvim-tree").setup({
        disable_netrw = true,
        hijack_netrw = true,

        filters = {
          dotfiles = false,
          custom = { ".git", "node_modules", ".cache" },
          exclude = {},
        },

        git = {
          enable = true,
          ignore = false,
          timeout = 400,
        },

        view = {
          width = 35,
          side = "left",
          preserve_window_proportions = true,
          signcolumn = "yes",
        },

        actions = {
          open_file = {
            quit_on_open = false,
            resize_window = true,
          },
        },

        renderer = {
          indent_markers = {
            enable = true,
          },
          icons = {
            webdev_colors = true,
            git_placement = "before",
            padding = " ",
            symlink_arrow = " ➛ ",
            show = {
              file = true,
              folder = true,
              folder_arrow = true,
              git = true,
            },
            glyphs = {
              default = "󰈚",
              symlink = "",
              folder = {
                default = "",
                open = "",
                empty = "󰜌",
                empty_open = "󰜌",
                symlink = "",
                symlink_open = "",
              },
              git = {
                unstaged = "✗",
                staged = "✓",
                unmerged = "",
                renamed = "➜",
                untracked = "★",
                deleted = "󰆴",
                ignored = "◌",
              },
            },
          },
        },

        on_attach = function(bufnr)
          local api = require("nvim-tree.api")
          local map = vim.keymap.set
          local opts = { buffer = bufnr, noremap = true, silent = true, nowait = true }

          -- Navigation
          map("n", "h", api.node.navigate.parent_close, opts)
          map("n", "l", api.node.open.edit, opts)
          map("n", "<CR>", api.node.open.edit, opts)
          map("n", "o", api.node.open.edit, opts)
          map("n", "<2-LeftMouse>", api.node.open.edit, opts)
          map("n", "v", api.node.open.vertical, opts)
          map("n", "s", api.node.open.horizontal, opts)
          map("n", "<Tab>", api.node.open.preview, opts)

          -- File operations
          map("n", "a", api.fs.create, opts)
          map("n", "d", api.fs.remove, opts)
          map("n", "r", api.fs.rename, opts)
          map("n", "x", api.fs.cut, opts)
          map("n", "c", api.fs.copy.node, opts)
          map("n", "p", api.fs.paste, opts)

          -- Copy paths
          map("n", "y", api.fs.copy.filename, opts)
          map("n", "Y", api.fs.copy.relative_path, opts)
          map("n", "gy", api.fs.copy.absolute_path, opts)

          -- Tree operations
          map("n", ".", api.node.run.cmd, opts)
          map("n", "-", api.tree.change_root_to_parent, opts)
          map("n", "H", api.tree.toggle_hidden_filter, opts)
          map("n", "I", api.tree.toggle_gitignore_filter, opts)
          map("n", "R", api.tree.reload, opts)
          map("n", "?", api.tree.toggle_help, opts)
          map("n", "q", api.tree.close, opts)
        end,
      })
    end,
  },
}
