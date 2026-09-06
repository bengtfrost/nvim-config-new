# Neovim Keymap Summary

This document summarizes the primary keybindings configured in this Neovim setup.

## Leader Key

- `<Space>`

## I. Core Neovim Mappings (Global)

### Window Navigation & Management

| Key         | Mode   | Action                     | Defined In         |
| :---------- | :----- | :------------------------- | :----------------- |
| `<C-h>`     | Normal | Move to Left Window        | `core/keymaps.lua` |
| `<C-j>`     | Normal | Move to Down Window        | `core/keymaps.lua` |
| `<C-k>`     | Normal | Move to Up Window          | `core/keymaps.lua` |
| `<C-l>`     | Normal | Move to Right Window       | `core/keymaps.lua` |
| `<C-Up>`    | Normal | Increase Window Height     | `core/keymaps.lua` |
| `<C-Down>`  | Normal | Decrease Window Height     | `core/keymaps.lua` |
| `<C-Left>`  | Normal | Decrease Window Width      | `core/keymaps.lua` |
| `<C-Right>` | Normal | Increase Window Width      | `core/keymaps.lua` |
| `<leader>q` | Normal | Quit Current Window (`:q`) | `core/keymaps.lua` |
| `<leader>Q` | Normal | Quit All (Force) (`:qa!`)  | `core/keymaps.lua` |

### Buffer Management

| Key          | Mode   | Action                         | Defined In         |
| :----------- | :----- | :----------------------------- | :----------------- |
| `<leader>bn` | Normal | Next Buffer (`:bnext`)         | `core/keymaps.lua` |
| `<leader>bp` | Normal | Previous Buffer (`:bprevious`) | `core/keymaps.lua` |
| `<leader>bd` | Normal | Delete Buffer (`:bdelete`)     | `core/keymaps.lua` |

### Editing & Text Manipulation

| Key     | Mode   | Action                               | Defined In         |
| :------ | :----- | :----------------------------------- | :----------------- |
| `<A-j>` | Normal | Move Line Down                       | `core/keymaps.lua` |
| `<A-k>` | Normal | Move Line Up                         | `core/keymaps.lua` |
| `<A-j>` | Visual | Move Selection Down                  | `core/keymaps.lua` |
| `<A-k>` | Visual | Move Selection Up                    | `core/keymaps.lua` |
| `<`     | Visual | Decrease Indent (Keep Visual)        | `core/keymaps.lua` |
| `>`     | Visual | Increase Indent (Keep Visual)        | `core/keymaps.lua` |
| `p`     | Visual | Paste over Selection (Keep Yank Buf) | `core/keymaps.lua` |

### File Operations

| Key         | Mode   | Action           | Defined In         |
| :---------- | :----- | :--------------- | :----------------- |
| `<leader>s` | Normal | Save File (`:w`) | `core/keymaps.lua` |

### Miscellaneous

| Key                 | Mode   | Action                  | Defined In         |
| :------------------ | :----- | :---------------------- | :----------------- |
| `<leader><leader>h` | Normal | Clear Search Highlights | `core/keymaps.lua` |

## II. Plugin Key Mappings

### Formatting (Conform)

| Key              | Mode           | Action                        | Defined In                  |
| :--------------- | :------------- | :---------------------------- | :-------------------------- |
| **`<leader>fd`** | Normal, Visual | **Format Document/Selection** | **`plugins/formatter.lua`** |

### Language Server Protocol (LSP) - Contextual

_(These generally only work when an LSP server is attached to the current buffer)_

| Key          | Mode           | Action                                 | Defined In        |
| :----------- | :------------- | :------------------------------------- | :---------------- |
| `gd`         | Normal         | Go to Definition                       | `plugins/lsp.lua` |
| `gD`         | Normal         | Go to Declaration                      | `plugins/lsp.lua` |
| `gi`         | Normal         | Go to Implementation                   | `plugins/lsp.lua` |
| `<leader>D`  | Normal         | Go to Type Definition                  | `plugins/lsp.lua` |
| `gR`         | Normal         | Go to References                       | `plugins/lsp.lua` |
| `K`          | Normal         | Show Hover Documentation               | `plugins/lsp.lua` |
| `<leader>k`  | Normal         | Show Signature Help                    | `plugins/lsp.lua` |
| `<leader>rn` | Normal         | Rename Symbol                          | `plugins/lsp.lua` |
| `<leader>ca` | Normal, Visual | Code Actions                           | `plugins/lsp.lua` |
| `<leader>lf` | Normal, Visual | LSP Formatting (Disabled, use Conform) | `plugins/lsp.lua` |
| `<leader>wa` | Normal         | Workspace: Add Folder                  | `plugins/lsp.lua` |
| `<leader>wr` | Normal         | Workspace: Remove Folder               | `plugins/lsp.lua` |
| `<leader>wl` | Normal         | Workspace: List Folders                | `plugins/lsp.lua` |
| `<leader>e`  | Normal         | Show Line Diagnostics (Float)          | `plugins/lsp.lua` |
| `[d`         | Normal         | Go to Previous Diagnostic              | `plugins/lsp.lua` |
| `]d`         | Normal         | Go to Next Diagnostic                  | `plugins/lsp.lua` |
| `<leader>dq` | Normal         | Diagnostics Quickfix List              | `plugins/lsp.lua` |

### Telescope (Fuzzy Finder)

| Key          | Mode   | Action             | Defined In              |
| :----------- | :----- | :----------------- | :---------------------- |
| `<leader>ff` | Normal | Find Files         | `plugins/telescope.lua` |
| `<leader>fg` | Normal | Find by Live Grep  | `plugins/telescope.lua` |
| `<leader>fb` | Normal | Find Buffers       | `plugins/telescope.lua` |
| `<leader>fh` | Normal | Find Help Tags     | `plugins/telescope.lua` |
| `<leader>fo` | Normal | Find Old Files     | `plugins/telescope.lua` |
| `<leader>fr` | Normal | Resume Last Search | `plugins/telescope.lua` |
| `<leader>fD` | Normal | Find Diagnostics   | `plugins/telescope.lua` |

### NvimTree (File Explorer)

| Key                        | Mode   | Action                         | Defined In                   |
| :------------------------- | :----- | :----------------------------- | :--------------------------- |
| `<leader>n`                | Normal | Toggle File Explorer           | `plugins/ui.lua` (keys)      |
| _(Inside NvimTree Window)_ |        |                                |                              |
| `h` / `<BS>`               | Normal | Navigate Parent / Close Folder | `plugins/ui.lua` (on_attach) |
| `l` / `<CR>`/ `o`          | Normal | Open File / Expand Folder      | `plugins/ui.lua` (on_attach) |
| `v`                        | Normal | Open in Vertical Split         | `plugins/ui.lua` (on_attach) |
| `s`                        | Normal | Open in Horizontal Split       | `plugins/ui.lua` (on_attach) |
| `<Tab>`                    | Normal | Preview File (no focus)        | `plugins/ui.lua` (on_attach) |
| `a`                        | Normal | Add File/Directory             | `plugins/ui.lua` (on_attach) |
| `d`                        | Normal | Delete File/Directory          | `plugins/ui.lua` (on_attach) |
| `r`                        | Normal | Rename File/Directory          | `plugins/ui.lua` (on_attach) |
| `x`                        | Normal | Cut File/Directory             | `plugins/ui.lua` (on_attach) |
| `c`                        | Normal | Copy File/Directory            | `plugins/ui.lua` (on_attach) |
| `p`                        | Normal | Paste File/Directory           | `plugins/ui.lua` (on_attach) |
| `y`                        | Normal | Copy Filename                  | `plugins/ui.lua` (on_attach) |
| `Y`                        | Normal | Copy Relative Path             | `plugins/ui.lua` (on_attach) |
| `gy`                       | Normal | Copy Absolute Path             | `plugins/ui.lua` (on_attach) |
| `.`                        | Normal | Run Command on Node            | `plugins/ui.lua` (on_attach) |
| `-`                        | Normal | Change Root to Parent          | `plugins/ui.lua` (on_attach) |
| `H`                        | Normal | Toggle Hidden Files Filter     | `plugins/ui.lua` (on_attach) |
| `I`                        | Normal | Toggle GitIgnore Filter        | `plugins/ui.lua` (on_attach) |
| `R`                        | Normal | Reload Tree                    | `plugins/ui.lua` (on_attach) |
| `?`                        | Normal | Toggle Help                    | `plugins/ui.lua` (on_attach) |
| `q`                        | Normal | Close NvimTree Window          | `plugins/ui.lua` (on_attach) |

### Commenting (Comment.nvim)

| Key          | Mode           | Action               | Defined In            |
| :----------- | :------------- | :------------------- | :-------------------- |
| `<leader>gc` | Normal, Visual | Toggle Line Comment  | `plugins/comment.lua` |
| `<leader>gb` | Normal, Visual | Toggle Block Comment | `plugins/comment.lua` |

### Completion (nvim-cmp)

| Key               | Mode   | Action                              | Defined In               |
| :---------------- | :----- | :---------------------------------- | :----------------------- |
| `<C-k>`/`<S-Tab>` | Insert | Select Previous Item / Snippet Jump | `plugins/completion.lua` |
| `<C-j>`/`<Tab>`   | Insert | Select Next Item / Snippet Jump     | `plugins/completion.lua` |
| `<C-b>`           | Insert | Scroll Documentation Up             | `plugins/completion.lua` |
| `<C-f>`           | Insert | Scroll Documentation Down           | `plugins/completion.lua` |
| `<C-Space>`       | Insert | Trigger Completion                  | `plugins/completion.lua` |
| `<C-e>`           | Insert | Abort Completion                    | `plugins/completion.lua` |
| `<CR>`            | Insert | Confirm Selection                   | `plugins/completion.lua` |

### Surround (mini.surround)

| Key  | Mode           | Action                         | Defined In          |
| :--- | :------------- | :----------------------------- | :------------------ |
| `sa` | Normal, Visual | Add Surrounding (text object)  | `plugins/utils.lua` |
| `sd` | Normal, Visual | Delete Surrounding             | `plugins/utils.lua` |
| `sr` | Normal, Visual | Replace Surrounding            | `plugins/utils.lua` |
| `sf` | Normal, Visual | Find Right Surrounding         | `plugins/utils.lua` |
| `sF` | Normal, Visual | Find Left Surrounding          | `plugins/utils.lua` |
| `sh` | Normal, Visual | Highlight Surrounding          | `plugins/utils.lua` |
| `srn`| Normal, Visual | Replace Next Surrounding       | `plugins/utils.lua` |
| `srl`| Normal, Visual | Replace Previous Surrounding   | `plugins/utils.lua` |
| `sfn`| Normal, Visual | Find Next Right Surrounding    | `plugins/utils.lua` |
| `sfl`| Normal, Visual | Find Previous Right Surrounding| `plugins/utils.lua` |
| `sFn`| Normal, Visual | Find Next Left Surrounding     | `plugins/utils.lua` |
| `sFl`| Normal, Visual | Find Previous Left Surrounding | `plugins/utils.lua` |

### Trouble (Diagnostics)

| Key          | Mode   | Action                               | Defined In          |
| :----------- | :----- | :----------------------------------- | :------------------ |
| `<leader>xx` | Normal | Toggle Diagnostics (Trouble)         | `plugins/utils.lua` |
| `<leader>xq` | Normal | Toggle Quickfix (Trouble)            | `plugins/utils.lua` |
| `<leader>xl` | Normal | Toggle Location List (Trouble)       | `plugins/utils.lua` |

### Autopairs

| Key  | Mode   | Action                    | Defined In          |
| :--- | :----- | :------------------------ | :------------------ |
| `(`  | Insert | Auto-close parentheses    | `plugins/utils.lua` |
| `{`  | Insert | Auto-close curly braces   | `plugins/utils.lua` |
| `[`  | Insert | Auto-close square brackets| `plugins/utils.lua` |
| `'`  | Insert | Auto-close single quotes  | `plugins/utils.lua` |
| `"`  | Insert | Auto-close double quotes  | `plugins/utils.lua` |

## III. Which-Key Discovery

- Press `<leader>` (Space) in Normal Mode and **wait** briefly to see a popup listing available mappings starting with `<leader>`.
- Groups like `Telescope`, `LSP`, and `+` help organize the display.
- Which-Key automatically detects and displays your keymaps with descriptions.

## Keymap Overlap Notes

The following overlaps are **intentional and harmless**:

### mini.surround Prefix Overlaps
- `sr` (Replace surrounding) overlaps with `srn`/`srl` (Next/Previous)
- `sd` (Delete surrounding) overlaps with `sdn`/`sdl`
- `sf`/`sF` (Find surrounding) overlap with `sfn`/`sfl` and `sFn`/`sFl`
- `sh` (Highlight surrounding) overlaps with `shn`/`shl`

These are designed this way - Vim resolves the longest matching key sequence first.

### Fixed Overlaps
- `gr` changed to `gR` for LSP references to avoid conflict with `g` prefix commands

## Troubleshooting Keymaps

- **Delays**: If you experience delays with multi-key sequences, adjust `timeoutlen` in `core/options.lua` (default: 500ms)
- **Missing descriptions**: Keymaps without descriptions won't appear in Which-Key. Add `desc` to your mappings
- **Check health**: Run `:checkhealth` to identify any keymap conflicts
