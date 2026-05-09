--
-- plugins/init.lua

require 'plugins.lazydev'

-- Colorscheme
require 'plugins.nordic'

-- Multipurpose
require 'plugins.mini'

-- Visual
require 'plugins.lualine'
require 'plugins.fidget' -- notifications and LSP progress messages

-- Editing
require 'plugins.treesitter'

-- Functionality
require 'plugins.smart-splits'

  -- Completion, Formatting, Linting, LSP
require 'plugins.conform' -- formatting
require 'plugins.lsp'

-- git
require 'plugins.gitsigns'


-- conform
-- mini completion sources, compare to blink, add lazydev pre lsp?
