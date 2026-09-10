# nvim-config

Personal Neovim configuration for Neovim 0.12+. Optimized for development with LSP, formatting, dynamic wallpaper-based color schemes (Matugen/Noctalia), and modern editor features.

## Requirements

- Neovim ≥ 0.12
- A Nerd Font (for icons)
- Various LSP servers and formatters (see installation below)

## Quick Install

```bash
git clone git@github.com:bengtfrost/nvim-config-new.git ~/.config/nvim

```

lazy.nvim bootstraps itself on first launch. Run `:Lazy sync` to install all plugins.

## Required External Tools

Install the following tools for full functionality:

### LSP Servers

```bash
# Lua
sudo xbps-install lua-language-server  # Void Linux
# or: cargo install lua-language-server

# Python
uv tool install basedpyright
uv tool install ruff

# Rust
rustup component add rust-analyzer

# TypeScript/JavaScript
deno install -g npm:bash-language-server npm:yaml-language-server npm:vscode-langservers-extracted

# Bash
sudo xbps-install bash-language-server  # Void Linux
# or: npm install -g bash-language-server

# Markdown
wget -O ~/.local/bin/marksman [https://github.com/artempyanykh/marksman/releases/download/2026-02-08/marksman-linux-x64](https://github.com/artempyanykh/marksman/releases/download/2026-02-08/marksman-linux-x64)
chmod +x ~/.local/bin/marksman

# TOML/YAML
cargo install taplo-cli
npm install -g yaml-language-server

# C/C++
sudo xbps-install clang-tools-extra  # Includes clangd and clang-format

```

### Formatters

```bash
# General
cargo install stylua dprint tree-sitter-cli

# Python (already installed above)
uv tool install ruff

# Bash
sudo xbps-install shfmt

# TOML (already installed above)
cargo install taplo-cli

```

## Structure

```
~/.config/nvim/
├── init.lua              # Entry point, lazy.nvim setup
├── README.md             # This file
├── KEYMAPS.md            # Complete keymap reference
├── lua/
│   ├── core/
│   │   ├── options.lua   # Editor options (tabs, search, clipboard)
│   │   └── keymaps.lua   # Core key mappings (windows, buffers, editing)
│   ├── matugen.lua       # Matugen / Noctalia dynamic theme helper
│   └── plugins/
│       ├── base16.lua        # Dynamic base16 colorscheme integration (Matugen)
│       ├── comment.lua       # Comment.nvim (gc/gb mappings)
│       ├── completion.lua    # nvim-cmp + LuaSnip
│       ├── formatter.lua     # conform.nvim (formatting)
│       ├── lsp.lua           # LSP configuration (Neovim 0.12+ API)
│       ├── telescope.lua     # Telescope + fzf-native
│       ├── treesitter.lua    # Treesitter syntax highlighting
│       ├── ui.lua            # nvim-tree file explorer
│       └── utils.lua         # which-key, mini.icons, autopairs, trouble, mini.surround

```

## Key Mappings Summary

### General

* `<leader>` = Space
* `<leader>s` - Save file
* `<leader>q` - Quit window
* `<leader>Q` - Quit all (force)
* `<leader><leader>h` - Clear search highlights

### Navigation

* `<C-h/j/k/l>` - Navigate windows
* `<C-Up/Down/Left/Right>` - Resize windows
* `<A-j/k>` - Move lines up/down (normal/visual)

### Buffer Management

* `<leader>bn` - Next buffer
* `<leader>bp` - Previous buffer
* `<leader>bd` - Delete buffer

### LSP (Language Server Protocol)

* `gd` - Go to definition
* `gD` - Go to declaration
* `gR` - Go to references (updated to avoid mini.surround conflict)
* `gi` - Go to implementation
* `K` - Hover documentation
* `<leader>k` - Signature help
* `<leader>rn` - Rename symbol
* `<leader>ca` - Code actions
* `[d` / `]d` - Previous/Next diagnostic
* `<leader>e` - Show line diagnostics
* `<leader>dq` - Diagnostics to quickfix list
* `<leader>wa/wr/wl` - Workspace folder management

### Telescope (Fuzzy Finder)

* `<leader>ff` - Find files
* `<leader>fg` - Live grep
* `<leader>fb` - Find buffers
* `<leader>fh` - Find help tags
* `<leader>fo` - Find old files
* `<leader>fr` - Resume previous search
* `<leader>fD` - Find diagnostics

### File Explorer (NvimTree)

* `<leader>n` - Toggle file explorer
* Inside tree: `h`/`l` to navigate, `a`/`d`/`r` for file operations
* Full reference in KEYMAPS.md

### Formatting

* `<leader>fd` - Format document/selection (uses conform.nvim)

### Comments

* `<leader>gc` - Toggle line comment
* `<leader>gb` - Toggle block comment

### Completion (nvim-cmp)

* `<C-j>`/`<C-k>` - Navigate completion items
* `<Tab>`/`<S-Tab>` - Navigate and jump snippet points
* `<C-Space>` - Trigger completion manually
* `<CR>` - Confirm selection

### Surround (mini.surround)

* `sa` - Add surrounding (text object)
* `sd` - Delete surrounding
* `sr` - Replace surrounding
* `sf` - Find right surrounding
* `sF` - Find left surrounding
* `sh` - Highlight surrounding

### Trouble (Diagnostics)

* `<leader>xx` - Toggle diagnostics
* `<leader>xq` - Toggle quickfix list
* `<leader>xl` - Toggle location list

## Troubleshooting

### LSP Issues

Check LSP status in Neovim:

```vim
:LspInfo
:LspLog

```

### Plugin Issues

Check plugin health:

```vim
:checkhealth
:Lazy health

```

### Which-Key Not Showing

* Ensure `timeoutlen` is set (500ms by default in options.lua)
* Try pressing `<leader>` and waiting briefly

### Formatters Not Working

Verify formatter is installed:

```bash
which stylua ruff_format shfmt clang-format dprint taplo

```

### Common Issues

**Error: "attempt to index a boolean value" in completion.lua**

* Fixed in current version - pcall now properly handles the loader

**LSP not attaching to files**

* Run `:LspInfo` to see active servers
* Ensure the server executable is in your PATH
* Check `:LspLog` for error messages

**Keymap conflicts with mini.surround**

* `gr` changed to `gR` for references
* Other overlaps are intentional (s prefix with variants)

## License

MIT

