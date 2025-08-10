--
-- mini.lua

-- https://github.com/echasnovski/mini.deps#installation
-- Clone 'mini.nvim' manually in a way that it gets managed by 'mini.deps'
local path_package = vim.fn.stdpath('data') .. '/site/' -- ~/.local/share/nvim/site
local mini_path = path_package .. 'pack/deps/start/mini.nvim' -- ~/.local/share/nvim/site/pack/deps/start/mini.nvim
if not vim.uv.fs_stat(mini_path) then
  vim.cmd('echo "Installing `mini.nvim`" | redraw')
  local clone_cmd = {
    'git', 'clone', '--filter=blob:none',
    'https://github.com/echasnovski/mini.nvim', mini_path
  }
  vim.system(clone_cmd):wait()
  vim.cmd('packadd mini.nvim | helptags ALL')
  vim.cmd('echo "Installed `mini.nvim`" | redraw')
end

-- Set up 'mini.deps' (customize to your liking)
require('mini.deps').setup({ path = { package = path_package } })
vim.keymap.set('n', '<leader>zl', '<cmd>DepsUpdate<cr>', { desc = 'MiniDeps Update' })

local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

Config.dofile 'deps/nordic.lua'

add('nvim-lua/plenary.nvim')  -- lua functions that many plugins use

add('j-hui/fidget.nvim')
add('folke/flash.nvim')
add('folke/lazydev.nvim')

Config.dofile('deps/snacks.lua')

add('folke/trouble.nvim')
add('folke/ts-comments.nvim')

add({
  source = 'nvim-treesitter/nvim-treesitter',
  checkout = 'main',
  monitor = 'main',
  -- Perform action after every checkout
  hooks = { post_checkout = function() vim.cmd('TSUpdate') end },
})

add('mason-org/mason.nvim')

-- later('zbirenbaum/copilot.lua')
add('github/copilot.vim')

now(function()
  --
  -- Visual
  --
  -- Config.dofile 'plugins/cursorword'
  require('mini.icons').setup()
  require('mini.statusline').setup()

  require('fidget').setup({
          progress = { -- make fidget less noisy
            suppress_on_insert = true, -- suppress new messages while in insert mode -- default: false
            ignore_done_already = true, -- ignore new tasks that are already complete -- default: false
            ignore_empty_message = true, -- ignore new tasks that don't contain a message  default: false

            display = {
              done_ttl = 1, -- time a message persist after completion
            },
          },
  })

  -- tryout
  require('mini.cursorword').setup(
    vim.api.nvim_set_hl(0, 'MiniCursorword', { bg = '#3c3836', underline = false })
  ) -- Highlight word under cursor
  require('mini.trailspace').setup() -- Highlight trailing spaces

  -- -- OLD Visual
  -- require 'user.plugins.lualine', -- statusline
  -- require 'user.plugins.nvim-tree', -- file explorer
  -- require 'user.plugins.nvim-web-devicons', -- icons
  -- require 'user.plugins.oil', -- file explorer
  -- require 'user.plugins.telescope',
  -- -- require 'user.plugins.snacks-picker',
  -- require 'user.plugins.todo-comments', -- highlight todo, notes, etc in comments
  -- require 'user.plugins.trouble', -- pretty diagnostics, references, telescope results, quickfix and location list
  -- require 'user.plugins.which-key', -- show keybinds
  -- -- require 'user.plugins.oklch-color-picker', -- colorize color codes
  -- require 'user.plugins.ccc', -- colorize color codes
  -- -- require 'user.plugins.nvim-colorizer', -- colorize color codes
  --


  --
  -- Editing
  --

  -- -- OLD Editing
  -- require 'user.plugins.aerial', -- code outline
  -- require 'user.plugins.nvim-ufo', -- folding
  -- require 'user.plugins.multicursor',
  -- TESTING mini.pairs - require 'user.plugins.nvim-autopairs', -- automatically insert or delete brackets, parens, quotes in pair
  -- TESTING mini.surround - require 'user.plugins.nvim-surround', -- add/change/delete surrounding delimiter pairs with ease
  -- require 'user.plugins.sideways', -- move function arguments (parameters) left and right
  -- require 'user.plugins.treesj', -- split/join blocks of code -- Disabled: testing mini-splitjoin
  -- require 'user.plugins.treesitter', -- highlight, edit, and navigate code

  -- tryout
  require('mini.surround').setup() -- surround text objects
  require('mini.pairs').setup() -- automatically insert or delete brackets, parens, quotes in pair
  require('mini.splitjoin').setup() -- Split/Join code blocks

  require('mason').setup()

  vim.keymap.set('n', '<leader>zm', '<cmd>Mason<cr>', { desc = 'Mason' })


  --
  -- Functionality
  --

  -- -- OLD Functionality
  -- require 'user.plugins.auto-session', -- sessions based on working directory
  -- require 'user.plugins.flash', -- quick navigation, buffer
  -- require 'user.plugins.harpoon', -- quick navigation, files
  -- require 'user.plugins.smart-splits', -- window navigation
  -- -- require 'user.plugins.vim-tmux-navigator', -- window navigation
 

  --
  -- Formatting, LSP, Completion, Linting
  --

  -- -- OLD Formatting, LSP, Completion, Linting
  -- require 'user.plugins.conform',
  -- require 'user.plugins.lsp',
  -- require 'user.plugins.completion',
  -- require 'user.plugins.linting',


  --
  -- Not sorted
  --

  --
  -- -- OLD Git
  -- require 'user.plugins.gitsigns', -- adds git related signs to the gutter, and utilities for managing changes
  --
  -- -- OLD Markdown
  -- require 'user.plugins.markdown',
  --
  -- -- OLD SQL
  -- require 'user.plugins.vim-dadbod', -- vim-dadbod, vim-dadbod-ui, vim-dadbod-completion
  --
  -- -- OLD HTTP
  -- require 'user.plugins.hurl',
  --
  -- -- OLD Github Copilot
  -- require 'user.plugins.copilot', -- inline code completion
  -- require 'user.plugins.copilotchat', -- chat with copilot
  --
  -- -- OLD Local plugins
  -- -- require 'user.plugins.dev',
  --
  -- -- OLD Test plugins
  -- -- require 'user.plugins.test.bufferline', -- test as tabline
  -- -- require 'user.plugins.test.dropbar',

end)


