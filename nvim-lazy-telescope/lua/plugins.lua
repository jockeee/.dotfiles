--
-- plugins.lua

return {
  -- Lua
  require 'plugin.plenary', -- lua functions that many plugins use

  -- Colorscheme
  require 'plugin.colorscheme.nordic',
  -- require 'plugin.colorscheme.catppuccin',
  -- require 'plugin.colorscheme.vscode',
  -- require 'plugin.colorscheme.kanagawa',

  -- Visual
  require 'plugin.lualine', -- statusline
  require 'plugin.nvim-tree', -- file explorer
  require 'plugin.nvim-web-devicons', -- icons
  require 'plugin.oil', -- file explorer
  require 'plugin.telescope',
  -- require 'plugin.snacks-picker',
  require 'plugin.todo-comments', -- highlight todo, notes, etc in comments
  require 'plugin.trouble', -- pretty diagnostics, references, telescope results, quickfix and location list
  require 'plugin.which-key', -- show keybinds
  -- require 'plugin.oklch-color-picker', -- colorize color codes
  require 'plugin.ccc', -- colorize color codes
  -- require 'plugin.nvim-colorizer', -- colorize color codes

  -- Editing
  require 'plugin.aerial', -- code outline
  require 'plugin.nvim-ufo', -- folding
  require 'plugin.mini', -- various small independent plugins/modules
  require 'plugin.multicursor',
  require 'plugin.nvim-autopairs', -- automatically insert or delete brackets, parens, quotes in pair
  require 'plugin.nvim-surround', -- add/change/delete surrounding delimiter pairs with ease
  require 'plugin.sideways', -- move function arguments (parameters) left and right
  require 'plugin.treesj', -- split/join blocks of code -- Disabled: testing mini-splitjoin
  require 'plugin.treesitter', -- highlight, edit, and navigate code

  -- Functionality
  require 'plugin.auto-session', -- sessions based on working directory
  require 'plugin.flash', -- quick navigation, buffer
  require 'plugin.harpoon', -- quick navigation, files
  require 'plugin.smart-splits', -- window navigation
  -- require 'plugin.vim-tmux-navigator', -- window navigation

  -- Formatting, LSP, Completion, Linting
  require 'plugin.conform',
  require 'plugin.lsp',
  require 'plugin.completion',
  require 'plugin.linting',

  -- Git
  require 'plugin.gitsigns', -- adds git related signs to the gutter, and utilities for managing changes

  -- SQL
  -- require 'plugin.vim-dadbod', -- vim-dadbod, vim-dadbod-ui, vim-dadbod-completion

  -- HTTP
  require 'plugin.hurl',

  -- Github Copilot
  require 'plugin.copilot', -- inline code completion
  require 'plugin.copilotchat', -- chat with copilot

  -- Local plugins
  -- require 'plugin.dev',

  -- Test plugins
  -- require 'plugin.test.bufferline', -- test as tabline
  -- require 'plugin.test.dropbar',
}
