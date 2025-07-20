--
-- plugins.lua

return {
  -- Lua
  require 'plugin.plenary', -- lua functions that many plugins use

  -- Colorscheme
  require 'plugin.colorscheme.nordic',

  -- Multipurpose
  require 'plugin.mini',
  require 'plugin.snacks',

  -- Visual
  require 'plugin.todo-comments', -- highlight todo, notes, etc in comments
  require 'plugin.trouble', -- pretty diagnostics, references, telescope results, quickfix and location list
  require 'plugin.which-key', -- show keymaps

  -- Editing
  require 'plugin.guess-indent', -- detect tabstop and shiftwidth
  require 'plugin.treesj', -- split/join code blocks

  -- Functionality
  require 'plugin.auto-session', -- sessions based on working directory
  require 'plugin.multicursor',
  require 'plugin.smart-splits',

  -- Completion, Formatting, Linting, LSP
  require 'plugin.conform', -- formatting
  require 'plugin.lsp',

  -- git
  require 'plugin.gitsigns',

  -- copilot
  require 'plugin.copilot',
  require 'plugin.copilotchat',
}
