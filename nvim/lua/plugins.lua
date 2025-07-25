--
-- lua/plugins.lua

---@type LazySpec
return {
  -- Colorscheme
  require 'plugin.colorscheme.nordic',

  -- Multipurpose
  require 'plugin.mini',
  require 'plugin.snacks',

  -- Visual
  require 'plugin.aerial', -- code outline
  -- require 'plugin.ccc', -- colorize color codes
  require 'plugin.colorizer', -- colorize color codes
  require 'plugin.lualine',
  require 'plugin.todo-comments', -- highlight todo, notes, etc in comments
  require 'plugin.which-key',

  -- Editing
  -- require 'plugin.comment',
  require 'plugin.guess-indent', -- detect tabstop and shiftwidth
  require 'plugin.multicursor',
  require 'plugin.sideways', -- move delimited-by-something items left and right
  require 'plugin.surround',
  require 'plugin.trouble',
  require 'plugin.treesitter',
  require 'plugin.treesj', -- split/join code blocks
  require 'plugin.ufo', -- folding

  -- Functionality
  require 'plugin.auto-session', -- sessions based on working directory
  require 'plugin.flash',
  require 'plugin.harpoon',
  require 'plugin.smart-splits',

  -- Completion, Formatting, Linting, LSP
  require 'plugin.debug',
  require 'plugin.blink', -- completion
  require 'plugin.conform', -- formatting
  require 'plugin.fidget', -- lsp status updates
  require 'plugin.lazydev',
  require 'plugin.lint',
  require 'plugin.lsp',

  -- git
  require 'plugin.gitsigns',

  -- copilot
  require 'plugin.copilot',
  require 'plugin.codecompanion',
  -- require 'plugin.avante',
  -- require 'plugin.copilotchat',
}
