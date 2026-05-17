--
-- plugins/init.lua

-- Colorscheme
require 'plugins.nordic'

-- Multipurpose
require 'plugins.mini'
require 'plugins.snacks'

-- Visual
require 'plugins.aerial' -- code outline
require 'plugins.fidget' -- notifications and LSP progress messages
require 'plugins.lualine'
require 'plugins.todo-comments'

-- Editing
require 'plugins.surround'
require 'plugins.treesitter'
require 'plugins.treesj' -- split/join code blocks
require 'plugins.vim-matchup' -- enhanced % matching
require 'plugins.origami' -- folding

-- Functionality
require 'plugins.smart-splits'

-- Completion, Formatting, LSP
require 'plugins.debug'
require 'plugins.blink' -- completion
require 'plugins.conform' -- formatting
require 'plugins.lsp'

-- git
require 'plugins.gitsigns'

-- ai
require 'plugins.copilot'
-- require 'plugins.codecompanion'
-- require 'plugins.folke-sidekick'
