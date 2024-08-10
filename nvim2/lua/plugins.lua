--
-- plugins.lua

return {
  'nvim-lua/plenary.nvim', -- lua functions that many plugins use
  { 'nvim-tree/nvim-web-devicons', event = 'VeryLazy' }, -- icons, via nerd font

  -- Visual
  { 'folke/todo-comments.nvim', event = { 'BufReadPre', 'BufNewFile' } },  -- highlight todo, notes, etc in comments
  require 'user.plugins.colorscheme',
  require 'user.plugins.telescope',

  -- Editing
  require 'user.plugins.copilot',

  -- Functionality
  require 'user.plugins.auto-session', -- sessions based on working directory
  require 'user.plugins.vim-tmux-navigator', -- tmux & split window navigation with C-hjkl\
}
