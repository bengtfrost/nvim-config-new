-- ~/.config/nvim/init.lua

-- Set leader key BEFORE loading plugins/keymaps
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Load core configuration
require('core.options')
require('core.keymaps')

-- [[ Install lazy.nvim package manager ]]
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local parent_dir = vim.fn.fnamemodify(lazypath, ':h')
  if vim.fn.isdirectory(parent_dir) == 0 then
    vim.fn.mkdir(parent_dir, 'p')
  end
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    '--branch=stable',
    'https://github.com/folke/lazy.nvim.git',
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and load plugins via lazy.nvim ]]
require('lazy').setup('plugins', {
  checker = { enabled = true, notify = false },
  change_detection = { enabled = true, notify = false },
  rocks = {
    hererocks = false, -- Disables hererocks execution and suppresses luarocks errors/warnings
  },
})

-- [[ Disable Unused Default Providers ]]
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

-- [[ Diagnostics Configuration ]]
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    source = true, -- was "always" in <0.10, now boolean
    border = "rounded",
  },
})

-- Ensure sign column is always present to prevent text jitter
vim.opt.signcolumn = 'yes:1'

-- [[ Auto Commands ]]

-- Highlight yanked text briefly
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  group = highlight_group,
  pattern = '*',
  callback = function()
    vim.highlight.on_yank({ timeout = 300 })
  end,
})

-- Auto-close NvimTree when it's the last window remaining
local nvimtree_group = vim.api.nvim_create_augroup('NvimTreeClose', { clear = true })
vim.api.nvim_create_autocmd('BufEnter', {
  group = nvimtree_group,
  pattern = '*',
  callback = function()
    local wins = vim.api.nvim_list_wins()
    if #wins == 1 then
      local win = wins[1]
      if vim.api.nvim_win_is_valid(win) then
        local buf = vim.api.nvim_win_get_buf(win)
        if vim.bo[buf].filetype == 'NvimTree' then
          -- Defer slightly to let UI states stabilize safely
          vim.defer_fn(function()
            local current_wins = vim.api.nvim_list_wins()
            if #current_wins == 1 and vim.api.nvim_win_is_valid(current_wins[1]) then
              local current_buf = vim.api.nvim_win_get_buf(current_wins[1])
              if vim.bo[current_buf].filetype == 'NvimTree' then
                vim.cmd.quit()
              end
            end
          end, 50)
        end
      end
    end
  end,
})
