--
-- stevearc/aerial.nvim

vim.pack.add {
  'https://github.com/stevearc/aerial.nvim',
}

require('aerial').setup {
  -- backends = { 'lsp', 'treesitter', 'markdown', 'asciidoc', 'man' },

  layout = {
    -- These control the width of the aerial window.
    -- They can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
    -- min_width and max_width can be a list of mixed types.
    -- max_width = {40, 0.2} means "the lesser of 40 columns or 20% of total"
    -- max_width = { 80, 0.2 }, -- d: 40, 0.2
    -- max_width = 60, -- d: { 40, 0.2 }
    width = 40,
    -- min_width = 40, -- d: 10

    -- key-value pairs of window-local options for aerial window (e.g. winhl)
    -- win_opts = { -- d: {}
    --   winblend = 10,
    -- },

    -- Determines the default direction to open the aerial window. The 'prefer'
    -- options will open the window in the other direction *if* there is a
    -- different buffer in the way of the preferred direction
    -- Enum: prefer_right, prefer_left, right, left, float
    -- default_direction = 'right', -- d: prefer_right
    default_direction = 'float', -- d: prefer_right

    -- Determines where the aerial window will be opened
    --   edge   - open aerial at the far right/left of the editor
    --   window - open aerial to the right/left of the current window
    placement = 'window', -- d: window

    -- When the symbols change, resize the aerial window (within min/max constraints) to fit
    -- resize_to_content = false, -- d: true

    -- Preserve window size equality with (:h CTRL-W_=)
    preserve_equality = false, -- d: false

    win_opts = {
      winbar = ' ', -- blank top row, so aerial's first item lines up with the doc's first line
    },
  },

  -- Determines how the aerial window decides which buffer to display symbols for
  --   window - aerial window will display symbols for the buffer in the window from which it was opened
  --   global - aerial window will display symbols for the current window
  -- attach_mode = 'window', -- d: window

  keymaps = {
    -- close keybinds
    -- `q` works by default
    -- ['<C-c>'] = 'actions.close', -- used it with 'float' setting
    -- ['<esc>'] = 'actions.close', -- used it with 'float' setting
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
  -- highlight_on_jump = 300, -- d: 300

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

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'markdown',
  callback = function()
    -- skip preview/special markdown buffers
    if vim.bo.buftype ~= '' then
      return
    end
    require('aerial').open { focus = false, direction = 'right' }
  end,
})

vim.keymap.set('n', '<leader>a', function()
  local dir = vim.bo.filetype == 'markdown' and 'right' or 'float'
  require('aerial').toggle { focus = true, direction = dir }
end, { desc = 'Aerial' })

-- vim.keymap.set('n', '<leader>a', function()
--   require('aerial').toggle { focus = true }
-- end, { desc = 'Aerial' })

-- vim.api.nvim_create_autocmd('FileType', {
--   pattern = 'markdown',
--   callback = function()
--     if vim.bo.buftype ~= '' then return end -- skip special/preview buffers
--     require('aerial').open { direction = 'right', focus = false }
--   end,
-- })

-- used it with 'float' setting
--
-- vim.keymap.set('n', '<leader>a', function()
--   local dir = vim.bo.filetype == 'markdown' and 'right' or 'float'
--   require('aerial').toggle { focus = true, direction = dir }
-- end, { desc = 'Aerial' })
