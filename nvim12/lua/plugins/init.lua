--
-- plugins/init.lua

-- Colorscheme
require 'plugins.nordic'

-- Multipurpose
require 'plugins.mini'
require 'plugins.snacks'

-- Visual
require 'plugins.lualine'
require 'plugins.fidget' -- notifications and LSP progress messages

-- Editing
require 'plugins.treesitter'

-- Functionality
require 'plugins.smart-splits'

-- Completion, Formatting, Linting, LSP
require 'plugins.blink' -- completion
require 'plugins.conform' -- formatting
require 'plugins.lsp'

-- git
require 'plugins.gitsigns'
