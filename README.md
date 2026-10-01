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
wget -O ~/.local/bin/marksman https://github.com/artempyanykh/marksman/releases/download/2026-02-08/marksman-linux-x64
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

# Python
uv tool install ruff

# Bash
sudo xbps-install shfmt

# TOML
cargo install taplo-cli
```

## Structure

```
~/.config/nvim/
├── init.lua              # Entry point, lazy.nvim setup, diagnostics config
├── README.md             # This file
├── KEYMAPS.md            # Complete keymap reference
├── lazy-lock.json        # Plugin version lock
├── lua/
│   ├── core/
│   │   ├── options.lua   # Editor options (tabs, search, clipboard, filetypes)
│   │   └── keymaps.lua   # Core key mappings (windows, buffers, editing, diagnostics)
│   ├── matugen.lua       # Matugen / Noctalia dynamic theme helper
│   └── plugins/
│       ├── base16.lua        # Dynamic base16 colorscheme (Matugen-driven)
│       ├── comment.lua       # Comment.nvim (gc/gb mappings)
│       ├── completion.lua    # nvim-cmp + LuaSnip
│       ├── formatter.lua     # conform.nvim (formatting)
│       ├── lsp.lua           # LSP configuration (Neovim 0.12+ API)
│       ├── telescope.lua     # Telescope + fzf-native
│       ├── treesitter.lua    # Treesitter syntax highlighting
│       ├── ui.lua            # nvim-tree file explorer
│       └── utils.lua         # which-key, mini.icons, autopairs, trouble, mini.surround
```

---

## Key Mappings — Complete Reference

### Leader Key

- **`<leader>` = `Space`**

### Core — Files, Buffers, Windows

| Key          | Mode   | Action                          |
| :----------- | :----- | :------------------------------ |
| `<leader>s`  | Normal | Save file (`:w`)                |
| `<leader>q`  | Normal | Quit current window (`:q`)      |
| `<leader>Q`  | Normal | Quit all, force (`:qa!`)        |
| `<leader>bn` | Normal | Next buffer                     |
| `<leader>bp` | Normal | Previous buffer                 |
| `<leader>bd` | Normal | Delete buffer                   |
| `<leader>n`  | Normal | Toggle NvimTree file explorer   |

### Window Navigation

| Key          | Mode   | Action                  |
| :----------- | :----- | :---------------------- |
| `<C-h>`      | Normal | Move to left window     |
| `<C-j>`      | Normal | Move to bottom window   |
| `<C-k>`      | Normal | Move to top window      |
| `<C-l>`      | Normal | Move to right window    |
| `<C-Up>`     | Normal | Increase window height  |
| `<C-Down>`   | Normal | Decrease window height  |
| `<C-Left>`   | Normal | Decrease window width   |
| `<C-Right>`  | Normal | Increase window width   |

### Editing & Text Manipulation

| Key     | Mode   | Action                                  |
| :------ | :----- | :-------------------------------------- |
| `<A-j>` | Normal | Move current line down                  |
| `<A-k>` | Normal | Move current line up                    |
| `<A-j>` | Visual | Move selected lines down                |
| `<A-k>` | Visual | Move selected lines up                  |
| `<`     | Visual | Decrease indent (stay in visual mode)   |
| `>`     | Visual | Increase indent (stay in visual mode)   |
| `p`     | Visual | Paste over selection (keep yank buffer) |

### Search

| Key                 | Mode   | Action                       |
| :------------------ | :----- | :--------------------------- |
| `<leader><leader>h` | Normal | Clear search highlights      |

### Telescope (Fuzzy Finder)

| Key          | Mode   | Action                       |
| :----------- | :----- | :--------------------------- |
| `<leader>ff` | Normal | Find files                   |
| `<leader>fg` | Normal | Live grep (search in files)  |
| `<leader>fb` | Normal | Find open buffers            |
| `<leader>fh` | Normal | Find help tags               |
| `<leader>fo` | Normal | Find old/recent files        |
| `<leader>fr` | Normal | Resume previous search       |
| `<leader>fD` | Normal | Find diagnostics             |

### LSP — Language Server Protocol

**Available when a language server is attached to the current buffer.**

#### Navigation

| Key          | Mode   | Action                                  | Notes                                                          |
| :----------- | :----- | :-------------------------------------- | :------------------------------------------------------------- |
| `gd`         | Normal | Go to definition                        | Works on usages, not definitions                               |
| `gD`         | Normal | Go to declaration                       | Useful in C/C++ for forward declarations                       |
| `gi`         | Normal | Go to implementation                    | Best on traits/interfaces to find impl blocks                  |
| `gR`         | Normal | Go to references                        | Opens quickfix list with all usages                            |
| `<leader>D`  | Normal | Go to type definition                   | Best on variables (returns their type), not on the type itself |

> **Tip:** `gd` on a struct usage jumps to the definition. `<leader>D` on a *variable* jumps to the variable's type. If you see **"No location found"**, you're on a symbol that has no separate type definition (e.g., a struct definition itself, or a literal).

#### Hover & Signature

| Key         | Mode   | Action                  |
| :---------- | :----- | :---------------------- |
| `K`         | Normal | Hover documentation     |
| `<leader>k` | Normal | Signature help          |

#### Refactoring

| Key          | Mode           | Action               |
| :----------- | :------------- | :------------------- |
| `<leader>rn` | Normal         | Rename symbol        |
| `<leader>ca` | Normal, Visual | Code actions         |

#### Workspace

| Key          | Mode   | Action                        |
| :----------- | :----- | :---------------------------- |
| `<leader>wa` | Normal | Workspace: Add folder         |
| `<leader>wr` | Normal | Workspace: Remove folder      |
| `<leader>wl` | Normal | Workspace: List folders       |

#### Formatting

| Key          | Mode           | Action                                                         |
| :----------- | :------------- | :------------------------------------------------------------- |
| `<leader>fd` | Normal, Visual | **Format document/selection** (via conform.nvim) — **use this** |
| `<leader>lf` | Normal, Visual | Disabled — prints a notice to use `<leader>fd`                 |

### Diagnostics

| Key          | Mode   | Action                            |
| :----------- | :----- | :-------------------------------- |
| `<leader>e`  | Normal | Show diagnostic float             |
| `[d`         | Normal | Previous diagnostic               |
| `]d`         | Normal | Next diagnostic                   |
| `<leader>dq` | Normal | Send diagnostics to quickfix list |
| `<leader>xx` | Normal | Toggle Trouble diagnostics panel  |
| `<leader>xq` | Normal | Toggle Trouble quickfix panel     |
| `<leader>xl` | Normal | Toggle Trouble location list      |

### Comments (Comment.nvim)

| Key          | Mode           | Action                |
| :----------- | :------------- | :-------------------- |
| `<leader>gc` | Normal, Visual | Toggle line comment   |
| `<leader>gb` | Normal, Visual | Toggle block comment  |

### Completion (nvim-cmp)

| Key          | Mode   | Action                                              |
| :----------- | :----- | :-------------------------------------------------- |
| `<C-j>`      | Insert | Select next completion item                         |
| `<C-k>`      | Insert | Select previous completion item                     |
| `<Tab>`      | Insert | Next item / next snippet placeholder / indent       |
| `<S-Tab>`    | Insert | Previous item / previous snippet placeholder        |
| `<C-b>`      | Insert | Scroll documentation up                             |
| `<C-f>`      | Insert | Scroll documentation down                           |
| `<C-Space>`  | Insert | Trigger completion manually                         |
| `<C-e>`      | Insert | Abort/close completion menu                         |
| `<CR>`       | Insert | Confirm selected item                               |

### Surround (mini.surround)

| Key   | Mode           | Action                        |
| :---- | :------------- | :---------------------------- |
| `sa`  | Normal, Visual | Add surrounding               |
| `sd`  | Normal, Visual | Delete surrounding            |
| `sr`  | Normal, Visual | Replace surrounding           |
| `sf`  | Normal, Visual | Find right surrounding        |
| `sF`  | Normal, Visual | Find left surrounding         |
| `sh`  | Normal, Visual | Highlight surrounding         |
| `srn` | Normal, Visual | Replace next surrounding      |
| `srl` | Normal, Visual | Replace previous surrounding  |

> These are not conflicts — Vim resolves the longest matching sequence first. See KEYMAPS.md for details.

### File Explorer (NvimTree)

Inside the tree buffer (after pressing `<leader>n`):

| Key          | Action                          |
| :----------- | :------------------------------ |
| `h`          | Close folder / go to parent     |
| `l`          | Open folder / open file         |
| `<CR>`       | Open file / folder              |
| `v`          | Open in vertical split          |
| `s`          | Open in horizontal split        |
| `<Tab>`      | Preview file (no focus)         |
| `a`          | Add file/folder                 |
| `d`          | Delete                          |
| `r`          | Rename                          |
| `x`          | Cut                             |
| `c`          | Copy                            |
| `p`          | Paste                           |
| `y`          | Copy filename                   |
| `Y`          | Copy relative path              |
| `gy`         | Copy absolute path              |
| `.`          | Run command on node             |
| `-`          | Change root to parent           |
| `H`          | Toggle hidden files             |
| `I`          | Toggle gitignore filter         |
| `R`          | Reload tree                     |
| `?`          | Toggle help                     |
| `q`          | Close NvimTree window           |

### Which-Key Discovery

Press **`<leader>`** and wait briefly to see available mappings. Which-Key groups them automatically (Telescope, LSP, Trouble, etc.).

---

## Common Pitfalls and Tips

### "No location found" from `<leader>D`

This is normal. `<leader>D` asks for the **type** of the symbol under the cursor. If the cursor is on a definition (like `struct Foo`), there is no separate type — you're already looking at it. Use `gd` to jump to a definition, `<leader>D` to jump to a variable's type.

### LSP keymaps missing in a buffer

LSP keymaps (`gd`, `gD`, `K`, etc.) are attached **only when a language server is attached to the buffer**. Check with:

```vim
:checkhealth vim.lsp
```

Neovim 0.12 removed `:LspInfo`. Use `:checkhealth vim.lsp` instead. If you want the old command back, add to `init.lua`:

```lua
vim.api.nvim_create_user_command("LspInfo", "checkhealth vim.lsp", {
  desc = "Show LSP Info",
})
```

### rust-analyzer log noise

You may see these in `:LspLog`:

- `"No path was found"` — cosmetic startup message, harmless
- `"content modified" (-32801)` — normal LSP request cancellation while typing

Neither indicates a problem. To hide them:

```lua
vim.lsp.log.set_level("error")  -- was "warn"
```

### Formatting does not run on save

Check that the formatter is installed:

```bash
which stylua ruff_format shfmt clang-format dprint taplo
```

Then verify `conform.nvim` sees it:

```vim
:ConformInfo
```

## Troubleshooting

### Plugin health

```vim
:checkhealth
:Lazy health
```

### LSP diagnostics

```vim
:checkhealth vim.lsp
:LspLog
```

### Which-Key not showing

- Ensure `timeoutlen` is set in `options.lua` (default 500ms)
- Try pressing `<leader>` and waiting briefly

## License

MIT
