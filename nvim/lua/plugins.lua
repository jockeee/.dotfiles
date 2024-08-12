--
-- plugins.lua

return {
  'nvim-lua/plenary.nvim', -- lua functions that many plugins use
  { 'nvim-tree/nvim-web-devicons', event = 'VeryLazy' }, -- icons, via nerd font

  -- Visual
  { 'folke/todo-comments.nvim', event = { 'BufReadPre', 'BufNewFile' } }, -- highlight todo, notes, etc in comments
  require 'user.plugins.colorscheme',
  require 'user.plugins.telescope',
  require 'user.plugins.todo-comments', -- highlight todo, notes, etc in comments
  require 'user.plugins.trouble', -- pretty diagnostics, references, telescope results, quickfix and location list
  require 'user.plugins.which-key', -- show keybinds

  -- Editing
  require 'user.plugins.copilot',
  require 'user.plugins.dial', -- enhanced increment/decrement, keyword cycle (true/false), and more
  require 'user.plugins.nvim-autopairs', -- automatically insert or delete brackets, parens, quotes in pair
  require 'user.plugins.nvim-surround', -- add/change/delete surrounding delimiter pairs with ease
  require 'user.plugins.treesj', -- split/join blocks of code
  require 'user.plugins.treesitter', -- highlight, edit, and navigate code

  -- Functionality
  require 'user.plugins.auto-session', -- sessions based on working directory
  require 'user.plugins.harpoon', -- quick navigation
  require 'user.plugins.vim-tmux-navigator', -- tmux & split window navigation with C-hjkl\

  -- Git
  require 'user.plugins.gitsigns', -- adds git related signs to the gutter, and utilities for managing changes
  require 'user.plugins.neogit', -- interactive git interface

  -- SQL
  require 'user.plugins.sql', -- vim-dadbod, vim-dadbod-ui, vim-dadbod-completion

  -- Autocompletion
  require 'user.plugins.nvim-cmp', -- autocompletion, snippets

  -- Formatting
  require 'user.plugins.conform', -- formatting

  -- LSP, debug, linting and formatting tools
  require 'user.plugins.lsp-config',
}
