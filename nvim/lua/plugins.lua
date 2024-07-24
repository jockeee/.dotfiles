--
-- plugins.lua

return {
  'nvim-lua/plenary.nvim', -- lua functions that many plugins use

  -- Visual
  'tpope/vim-sleuth', -- auto set tabstop, shiftwidth, etc for each file based on its contents
  { 'stevearc/dressing.nvim', event = 'VeryLazy', opts = {} }, -- improve the default vim.ui interfaces
  require 'user.plugins.colorscheme',
  require 'user.plugins.lualine', -- statusline
  require 'user.plugins.nvim-tree', -- file explorer
  require 'user.plugins.todo-comments', -- highlight todo, notes, etc in comments
  require 'user.plugins.vim-tmux-navigator', -- tmux & split window navigation with C-hjkl\
  require 'user.plugins.which-key', -- show pending keybinds

  -- Editing
  require 'user.plugins.github-copilot',
  require 'user.plugins.nvim-autopairs', -- automatically insert or delete brackets, parens, quotes in pair
  require 'user.plugins.nvim-surround', -- add/change/delete surrounding delimiter pairs with ease
  require 'user.plugins.treesitter', -- highlight, edit, and navigate code
  -- 'tpope/vim-unimpaired', -- handy bracket mappings
  -- require 'user.plugins.comment',
  -- require 'user.plugins.mini', -- collection of various small independent plugins/modules

  -- Functionality
  require 'user.plugins.auto-session',
  require 'user.plugins.gitsigns', -- adds git related signs to the gutter, and utilities for managing changes
  require 'user.plugins.neogit', -- interactive git interface
  require 'user.plugins.telescope', -- fuzzy finder (files, lsp, etc)
  require 'user.plugins.toggleterm',
  require 'user.plugins.trouble', -- pretty diagnostics, references, telescope results, quickfix and location list

  -- LSP, Linting, Formatting, Autocompletion
  require 'user.plugins.nvim-cmp', -- autocompletion, snippets
  require 'user.plugins.lsp-config',
  require 'user.plugins.conform', -- formatting
}
