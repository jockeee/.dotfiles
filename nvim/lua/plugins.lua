--
-- lua/plugins.lua

return {
  -- Colorscheme
  require 'plugin.colorscheme.nordic',

  -- Multipurpose
  require 'plugin.mini',
  require 'plugin.snacks',

  -- Visual
  require 'plugin.lualine',
  require 'plugin.todo-comments', -- highlight todo, notes, etc in comments
  require 'plugin.which-key',

  -- Editing
  require 'plugin.guess-indent', -- detect tabstop and shiftwidth
  require 'plugin.trouble',
  require 'plugin.treesitter',
  require 'plugin.treesj', -- split/join code blocks
  require 'plugin.ufo', -- folding
  -- require 'kickstart.plugins.autopairs',

  -- Functionality
  require 'plugin.auto-session', -- sessions based on working directory
  require 'plugin.multicursor',
  require 'plugin.smart-splits',

  -- Completion, Formatting, Linting, LSP
  require 'plugin.blink', -- completion
  require 'plugin.conform', -- formatting
  require 'plugin.lsp',
  -- require 'kickstart.plugins.debug',
  -- require 'kickstart.plugins.lint',

  -- git
  require 'plugin.gitsigns',

  -- copilot
  require 'plugin.copilot',
  require 'plugin.copilotchat',
}
