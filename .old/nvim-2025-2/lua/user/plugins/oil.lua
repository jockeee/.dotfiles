--
-- https://github.com/stevearc/oil.nvim
-- File explorer, edit your filesystem like a buffer
--
-- Keymaps
--    g?  help

return {
  'stevearc/oil.nvim',
  keys = {
    {
      '-',
      function() require('oil').toggle_float() end,
      { desc = 'Oil' },
    },
  },
  -- dependencies = { 'nvim-tree/nvim-web-devicons' },
  -- dependencies = { { 'echasnovski/mini.icons', opts = {} } },
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    columns = {
      'icon',
      -- "permissions",
      -- "size",
      -- "mtime",
    },
    -- Buffer-local options to use for oil buffers
    buf_options = {
      buflisted = false,
      bufhidden = 'hide',
    },
    -- Window-local options to use for oil buffers
    win_options = {
      wrap = false,
      signcolumn = 'no',
      cursorcolumn = false,
      foldcolumn = '0',
      spell = false,
      list = false,
      conceallevel = 3,
      concealcursor = 'nvic',
    },
    delete_to_trash = true, -- Send deleted files to system trash instead of permanently deleting them (:h oil-trash)
    skip_confirm_for_simple_edits = false, -- Skip the confirmation popup for simple operations (:help oil.skip_confirm_for_simple_edits)
    constrain_cursor = 'editable', -- Constrain the cursor to the editable parts of the oil buffer. Set to `false` to disable, or "name" to keep it on the file names
    watch_for_changes = true, -- Set to true to watch the filesystem for changes and reload oil
    keymaps = {
      -- :h oil-actions
      --
      -- Default keymaps
      ['g?'] = { 'actions.show_help', mode = 'n' },
      ['<CR>'] = 'actions.select',
      ['<C-s>'] = { 'actions.select', opts = { vertical = true } },
      ['<C-h>'] = false,
      -- ["<C-h>"] = { "actions.select", opts = { horizontal = true } },
      ['<C-t>'] = { 'actions.select', opts = { tab = true } },
      ['<C-p>'] = 'actions.preview',
      ['<C-c>'] = { 'actions.close', mode = 'n' },
      ['<C-l>'] = 'actions.refresh',
      ['-'] = { 'actions.parent', mode = 'n' },
      ['_'] = { 'actions.open_cwd', mode = 'n' },
      ['`'] = { 'actions.cd', mode = 'n' }, -- sets cwd
      ['~'] = { 'actions.cd', opts = { scope = 'tab' }, mode = 'n' },
      ['gs'] = { 'actions.change_sort', mode = 'n' },
      ['gx'] = 'actions.open_external',
      ['g.'] = { 'actions.toggle_hidden', mode = 'n' },
      ['g\\'] = { 'actions.toggle_trash', mode = 'n' },

      -- Extra keymaps
      ['q'] = { 'actions.close', mode = 'n' },
    },
    view_options = {
      show_hidden = true, -- Show files and directories that start with "."
    },
    float = {
      padding = 2, -- Padding around the floating window
      -- max_width and max_height can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
      max_width = 0.7,
      max_height = 0.5,
      border = 'rounded',
      win_options = {
        -- winblend = 10,
      },
    },
  },
  -- config = function(_, opts)
  --   local oil = require 'oil'
  --   oil.setup(opts)
  --
  --   -- vim.keymap.set('n', '-', oil.toggle_float, { desc = 'Oil' })
  -- end,
}
