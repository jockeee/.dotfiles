--
-- plugins.lua

return {
  -- Lua
  require 'user.plugins.plenary', -- lua functions that many plugins use

  -- Colorscheme
  require 'user.plugins.colorscheme.nordic',
  -- require 'user.plugins.colorscheme.catppuccin',
  -- require 'user.plugins.colorscheme.vscode',
  -- require 'user.plugins.colorscheme.kanagawa',

  -- Visual
  require 'user.plugins.lualine', -- statusline
  require 'user.plugins.nvim-tree', -- file explorer
  require 'user.plugins.nvim-web-devicons', -- icons
  require 'user.plugins.oil', -- file explorer
  require 'user.plugins.telescope',
  -- require 'user.plugins.snacks-picker',
  require 'user.plugins.todo-comments', -- highlight todo, notes, etc in comments
  require 'user.plugins.trouble', -- pretty diagnostics, references, telescope results, quickfix and location list
  require 'user.plugins.which-key', -- show keybinds

  -- Editing
  require 'user.plugins.aerial', -- code outline
  require 'user.plugins.nvim-ufo', -- folding
  require 'user.plugins.mini', -- various small independent plugins/modules
  require 'user.plugins.multicursor',
  require 'user.plugins.nvim-autopairs', -- automatically insert or delete brackets, parens, quotes in pair
  require 'user.plugins.nvim-surround', -- add/change/delete surrounding delimiter pairs with ease
  require 'user.plugins.sideways', -- move function arguments (parameters) left and right
  require 'user.plugins.treesj', -- split/join blocks of code -- Disabled: testing mini-splitjoin
  require 'user.plugins.treesitter', -- highlight, edit, and navigate code

  -- Functionality
  require 'user.plugins.auto-session', -- sessions based on working directory
  require 'user.plugins.flash', -- quick navigation, buffer
  require 'user.plugins.harpoon', -- quick navigation, files
  require 'user.plugins.smart-splits', -- window navigation
  -- require 'user.plugins.vim-tmux-navigator', -- window navigation

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

  -- HTTP
  require 'user.plugins.hurl',

  -- Github Copilot
  require 'user.plugins.copilot', -- inline code completion
  require 'user.plugins.copilotchat', -- chat with copilot

  -- Local plugins
  -- require 'user.plugins.dev',

  -- Test plugins
  -- require 'user.plugins.test.bufferline', -- test as tabline
  -- require 'user.plugins.test.dropbar',
}
