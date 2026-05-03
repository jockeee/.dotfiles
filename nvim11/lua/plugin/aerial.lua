--
-- stevearc/aerial.nvim

-- Code outline
--
-- You will need to have either Treesitter or a working LSP client.
-- You can configure your preferred source(s) with the backends option (see Options).
-- https://github.com/stevearc/aerial.nvim#options

return {
  'stevearc/aerial.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  keys = {
    {
      '<leader>a',
      function()
        require('aerial').toggle { focus = true } -- https://github.com/stevearc/aerial.nvim/blob/master/doc/api.md#toggleopts
      end,
      mode = 'n',
      desc = 'Aerial',
    },
  },
  dependencies = {
    'nvim-treesitter/nvim-treesitter', -- optional
    -- 'nvim-tree/nvim-web-devicons', -- optional
  },
  config = function()
    local aerial = require 'aerial'
    aerial.setup {
      -- backends = { 'lsp', 'treesitter', 'markdown', 'asciidoc', 'man' },

      layout = {
        -- These control the width of the aerial window.
        -- They can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
        -- min_width and max_width can be a list of mixed types.
        -- max_width = {40, 0.2} means "the lesser of 40 columns or 20% of total"
        max_width = { 80, 0.2 }, -- d: 40, 0.2
        width = nil,
        min_width = 40, -- d: 10

        -- key-value pairs of window-local options for aerial window (e.g. winhl)
        -- win_opts = { -- d: {}
        --   winblend = 10,
        -- },

        -- Determines the default direction to open the aerial window. The 'prefer'
        -- options will open the window in the other direction *if* there is a
        -- different buffer in the way of the preferred direction
        -- Enum: prefer_right, prefer_left, right, left, float
        default_direction = 'float', -- d: prefer_right

        -- Determines where the aerial window will be opened
        --   edge   - open aerial at the far right/left of the editor
        --   window - open aerial to the right/left of the current window
        placement = 'edge', -- d: window

        -- When the symbols change, resize the aerial window (within min/max constraints) to fit
        resize_to_content = true, -- d: true

        -- Preserve window size equality with (:h CTRL-W_=)
        preserve_equality = false, -- d: false
      },

      -- Determines how the aerial window decides which buffer to display symbols for
      --   window - aerial window will display symbols for the buffer in the window from which it was opened
      --   global - aerial window will display symbols for the current window
      attach_mode = 'global', -- d: window

      keymaps = {
        -- close keybinds
        -- `q` works by default
        ['<C-c>'] = 'actions.close',
        ['<Esc>'] = 'actions.close',
      },

      -- A list of all symbols to display. Set to false to display all symbols.
      -- This can be a filetype map (see :h aerial-filetype-map)
      --  :h SymbolKind
      -- filter_kind = {
      --   'Class',
      --   'Constructor',
      --   'Enum',
      --   'Function',
      --   'Interface',
      --   'Module',
      --   'Method',
      --   'Struct',
      -- },

      -- When jumping to a symbol, highlight the line for this many ms.
      -- Set to false to disable
      highlight_on_jump = 300, -- d: 300

      -- Jump to symbol in source window when the cursor moves
      autojump = false,

      -- Automatically open aerial when entering supported buffers.
      -- This can be a function (see :h aerial-open-automatic)
      open_automatic = false,

      -- Run this command after jumping to a symbol (false will disable)
      post_jump_cmd = 'normal! zz',

      -- use on_attach to set keymaps when aerial has attached to a buffer
      -- on_attach = function(bufnr)
      --   vim.keymap.set('n', '[[', aerial.prev, { buffer = bufnr, desc = 'Aerial Prev' })
      --   vim.keymap.set('n', ']]', aerial.next, { buffer = bufnr, desc = 'Aerial Next' })
      -- end,
    }
  end,
}
