--
-- plugins.lua

return {
  'nvim-lua/plenary.nvim', -- lua functions that many plugins use
  { 'nvim-tree/nvim-web-devicons', event = 'VeryLazy' }, -- icons, via nerd font

  -- Visual
  require 'user.plugins.colorscheme',
  require 'user.plugins.lualine', -- statusline
  require 'user.plugins.nvim-colorizer', -- color highlighter
  require 'user.plugins.nvim-tree', -- file tree
  require 'user.plugins.oil', -- file explorer
  require 'user.plugins.telescope',
  require 'user.plugins.todo-comments', -- highlight todo, notes, etc in comments
  require 'user.plugins.trouble', -- pretty diagnostics, references, telescope results, quickfix and location list
  require 'user.plugins.which-key', -- show keybinds

  -- Editing
  require 'user.plugins.aerial', -- code outline
  require 'user.plugins.copilot',
  require 'user.plugins.dial', -- enhanced increment/decrement, keyword cycle (true/false), and more
  require 'user.plugins.mini', -- various small independent plugins/modules
  require 'user.plugins.multicursor',
  require 'user.plugins.nvim-autopairs', -- automatically insert or delete brackets, parens, quotes in pair
  -- require 'user.plugins.nvim-surround', -- add/change/delete surrounding delimiter pairs with ease -- back to mini.surround
  require 'user.plugins.sideways', -- move function arguments (parameters) left and right
  require 'user.plugins.treesj', -- split/join blocks of code -- Disabled: testing mini-splitjoin
  require 'user.plugins.treesitter', -- highlight, edit, and navigate code

  -- Functionality
  require 'user.plugins.auto-session', -- sessions based on working directory
  require 'user.plugins.harpoon', -- quick navigation
  require 'user.plugins.toggleterm', -- terminal in a floating window
  require 'user.plugins.vim-tmux-navigator', -- tmux & split window navigation with C-hjkl\

  -- Git
  require 'user.plugins.gitsigns', -- adds git related signs to the gutter, and utilities for managing changes
  require 'user.plugins.diffview',
  require 'user.plugins.git-conflict',
  require 'user.plugins.neogit', -- interactive git interface

  -- SQL
  require 'user.plugins.vim-dadbod', -- vim-dadbod, vim-dadbod-ui, vim-dadbod-completion
  -- require 'user.plugins.nvim-dbee',

  -- Markdown
  require 'user.plugins.markdown',

  -- Autocompletion
  require 'user.plugins.nvim-cmp', -- autocompletion, snippets

  -- Formatting
  require 'user.plugins.conform', -- formatting

  -- LSP, debug, linting and formatting tools
  require 'user.plugins.lsp-config',
  require 'user.plugins.debug',
}
