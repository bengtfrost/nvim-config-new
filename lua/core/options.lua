-- lua/core/options.lua
local opt = vim.opt

-- [[ Context ]]
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.signcolumn = "yes"
opt.scrolloff = 8
opt.sidescrolloff = 8

-- [[ Look and Feel ]]
opt.termguicolors = true
opt.background = "dark"

-- [[ Tabs and Indentation ]]
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true

-- [[ Search ]]
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- [[ Files, Backup, Swap ]]
opt.backup = false
opt.writebackup = false
opt.swapfile = false
opt.undofile = true

-- Create undo directory
local undodir = vim.fn.stdpath("data") .. "/undodir"
if vim.fn.isdirectory(undodir) == 0 then
  vim.fn.mkdir(undodir, "p")
end
opt.undodir = undodir

-- [[ Performance / Behavior ]]
opt.hidden = true
opt.shortmess:append("I")
opt.updatetime = 250
opt.timeoutlen = 500
opt.completeopt = "menuone,noselect"

-- [[ Splitting ]]
opt.splitright = true
opt.splitbelow = true

-- [[ Clipboard Sync ]]
-- For Wayland (wl-clipboard) and X11 (xclip)
if vim.fn.executable("wl-copy") == 1 then
  opt.clipboard = "unnamedplus"
elseif vim.fn.executable("xclip") == 1 then
  opt.clipboard = "unnamedplus"
end

-- [[ Mouse Support ]]
opt.mouse = "a" -- Enable mouse support