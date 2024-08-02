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
  require 'user.plugins.telescope', -- fuzzy finder (files, lsp, etc)
  require 'user.plugins.todo-comments', -- highlight todo, notes, etc in comments
  require 'user.plugins.trouble', -- pretty diagnostics, references, telescope results, quickfix and location list
  require 'user.plugins.vim-tmux-navigator', -- tmux & split window navigation with C-hjkl\
  require 'user.plugins.which-key', -- show pending keybinds

  -- Editing
  require 'user.plugins.dial', -- enhanced increment/decrement plugin
  require 'user.plugins.github-copilot',
  require 'user.plugins.nvim-autopairs', -- automatically insert or delete brackets, parens, quotes in pair
  require 'user.plugins.nvim-surround', -- add/change/delete surrounding delimiter pairs with ease
  require 'user.plugins.treesj', -- split/join blocks of code
  require 'user.plugins.treesitter', -- highlight, edit, and navigate code
  require 'user.plugins.mini', -- collection of various small independent plugins/modules

  -- Functionality
  require 'user.plugins.auto-session',
  require 'user.plugins.toggleterm',

  -- Git
  require 'user.plugins.gitsigns', -- adds git related signs to the gutter, and utilities for managing changes
  require 'user.plugins.neogit', -- interactive git interface

  -- SQL
  'tpope/vim-dadbod',
  'kristijanhusak/vim-dadbod-completion',
  'kristijanhusak/vim-dadbod-ui',

  -- Autocompletion
  require 'user.plugins.nvim-cmp', -- autocompletion, snippets

  -- Formatting
  require 'user.plugins.conform', -- formatting

  -- LSP, debug, linting and formatting tools
  require 'user.plugins.lsp-config',
}
