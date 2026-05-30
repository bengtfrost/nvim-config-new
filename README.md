# nvim-config

Personal Neovim configuration. Tested on Fedora 44 / Sway with NVIM v0.12.2.

## Requirements

- Neovim ≥ 0.11
- A Nerd Font
- `make` (for telescope-fzf-native)
- `ripgrep` (for live grep)

## Install

```bash
git clone https://github.com/bengtfrost/nvim-config-new.git ~/.config/nvim
```

lazy.nvim bootstraps itself on first launch. Install LSP servers via `:Mason`.

## Structure

```
~/.config/nvim/
├── init.lua
└── lua/
    ├── core/
    │   ├── options.lua
    │   └── keymaps.lua
    └── plugins/
        ├── colorscheme.lua   # Nightfox / Carbonfox
        ├── comment.lua
        ├── completion.lua    # nvim-cmp + LuaSnip
        ├── formatter.lua     # conform.nvim
        ├── lsp.lua           # nvim-lspconfig + Mason
        ├── telescope.lua
        ├── treesitter.lua
        ├── ui.lua            # nvim-tree
        └── utils.lua         # which-key
```

## License

MIT
