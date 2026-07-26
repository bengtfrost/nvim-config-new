# nvim-config

Personal Neovim configuration. Tested on Debian 13 (Trixie) / Suckless dwm and st terminal with NVIM v0.12.4.

## Requirements

- Neovim ≥ 0.11
- A Nerd Font

## Install

```bash
git clone git@github.com:bengtfrost/nvim-config-new.git ~/.config/nvim
```

lazy.nvim bootstraps itself on first launch.

## Structure

```
~/.config/nvim/
├── init.lua
└── lua/
    ├── core/
    │   ├── options.lua       # Editor options
    │   └── keymaps.lua       # Key mappings
    └── plugins/
        ├── colorscheme.lua   # Nightfox / Carbonfox
        ├── comment.lua       # numToStr/Comment.nvim
        ├── completion.lua    # nvim-cmp + LuaSnip
        ├── formatter.lua     # conform.nvim
        ├── lsp.lua           # LSP configuration (vim.lsp.config)
        ├── telescope.lua     # Telescope + fzf-native
        ├── treesitter.lua    # Treesitter syntax highlighting
        ├── ui.lua            # nvim-tree file explorer
        └── utils.lua         # which-key, mini.icons
```

## Key Mappings

### General
- `<leader>` = Space
- `<leader>s` - Save file
- `<leader>q` - Quit window
- `<leader>Q` - Quit all (force)
- `<leader>h` - Clear search highlights

### Navigation
- `<C-h/j/k/l>` - Navigate windows
- `<C-Up/Down/Left/Right>` - Resize windows
- `<A-j/k>` - Move lines up/down

### LSP (Language Server)
- `gd` - Go to definition
- `gD` - Go to declaration
- `gr` - Go to references
- `gi` - Go to implementation
- `K` - Hover documentation
- `<leader>rn` - Rename symbol
- `<leader>ca` - Code actions
- `[d` / `]d` - Previous/Next diagnostic
- `<leader>e` - Show line diagnostics

### Telescope
- `<leader>ff` - Find files
- `<leader>fg` - Live grep
- `<leader>fb` - Find buffers
- `<leader>fh` - Find help
- `<leader>fo` - Find old files
- `<leader>fr` - Resume previous search
- `<leader>fD` - Find diagnostics

### File Explorer (NvimTree)
- `<leader>n` - Toggle file explorer
- `h` - Go up/close folder
- `l` - Go down/open folder/file
- `a` - Add file/folder
- `d` - Delete file/folder
- `r` - Rename
- `?` - Show help

### Formatting
- `<leader>fd` - Format document/selection (uses conform.nvim)

### Comments
- `<leader>gc` - Toggle line comment
- `<leader>gb` - Toggle block comment

## Troubleshooting

Check LSP status in Neovim:
```vim
:LspInfo
:LspLog
```

## License

MIT
