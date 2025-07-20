--
-- https://github.com/stevearc/oil.nvim
-- File explorer, edit your filesystem like a buffer

return {
  'stevearc/oil.nvim',
  event = 'VimEnter',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  -- dependencies = { { 'echasnovski/mini.icons', opts = {} } },
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    delete_to_trash = true, -- Send deleted files to system trash instead of permanently deleting them (:help oil-trash)
    keymaps = {
      ['<C-h>'] = false,
      ['<C-s>'] = false,
    },
    view_options = {
      show_hidden = false, -- Show files and directories that start with "."
    },
    float = {
      padding = 20, -- Padding around the floating window
      border = 'rounded',
      win_options = {
        winblend = 10,
      },
    },
  },
  config = function(_, opts)
    local oil = require 'oil'
    oil.setup(opts)

    vim.keymap.set('n', '-', oil.toggle_float, { desc = 'Previous todo comment' })
  end,
}
