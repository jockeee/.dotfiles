--
-- plugins.lua

return {
  { 'nvim-lua/plenary.nvim', lazy = false, }, -- lua functions that many plugins use

  -- Visual
  require 'user.plugins.colorscheme',
  require 'user.plugins.lualine',       -- statusline
  require 'user.plugins.oil',           -- file explorer
  require 'user.plugins.telescope',
  require 'user.plugins.todo-comments', -- highlight todo, notes, etc in comments
  require 'user.plugins.trouble',       -- pretty diagnostics, references, telescope results, quickfix and location list
  require 'user.plugins.which-key',     -- show keybinds

  -- Editing
  require 'user.plugins.aerial',         -- code outline
  require 'user.plugins.copilot',
  require 'user.plugins.mini',           -- various small independent plugins/modules
  require 'user.plugins.multicursor',
  require 'user.plugins.nvim-autopairs', -- automatically insert or delete brackets, parens, quotes in pair
  require 'user.plugins.sideways',       -- move function arguments (parameters) left and right
  require 'user.plugins.treesj',         -- split/join blocks of code -- Disabled: testing mini-splitjoin
  require 'user.plugins.treesitter',     -- highlight, edit, and navigate code

  -- Functionality
  require 'user.plugins.auto-session',       -- sessions based on working directory
  require 'user.plugins.harpoon',            -- quick navigation
  require 'user.plugins.toggleterm',         -- terminal in a floating window
  require 'user.plugins.vim-tmux-navigator', -- tmux & split window navigation with C-hjkl\

  -- Formatting / LSP / Completion
  require 'user.plugins.conform',
  require 'user.plugins.lsp',
  require 'user.plugins.completion',

  -- Git
  require 'user.plugins.gitsigns', -- adds git related signs to the gutter, and utilities for managing changes

  -- Markdown
  require 'user.plugins.markdown',

  -- SQL
  require 'user.plugins.vim-dadbod', -- vim-dadbod, vim-dadbod-ui, vim-dadbod-completion
}
