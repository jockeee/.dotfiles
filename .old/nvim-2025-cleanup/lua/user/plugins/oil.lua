--
-- https://github.com/stevearc/oil.nvim
-- File explorer, edit your filesystem like a buffer
--
-- Keymaps
--    g?  help

return {
  'stevearc/oil.nvim',
  event = 'VimEnter',
  -- dependencies = { 'nvim-tree/nvim-web-devicons' },
  -- dependencies = { { 'echasnovski/mini.icons', opts = {} } },
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    columns = {
      "icon",
      -- "permissions",
      -- "size",
      -- "mtime",
    },
    -- Buffer-local options to use for oil buffers
    buf_options = {
      buflisted = false,
      bufhidden = "hide",
    },
    -- Window-local options to use for oil buffers
    win_options = {
      wrap = false,
      signcolumn = "no",
      cursorcolumn = false,
      foldcolumn = "0",
      spell = false,
      list = false,
      conceallevel = 3,
      concealcursor = "nvic",
    },
    delete_to_trash = true,                -- Send deleted files to system trash instead of permanently deleting them (:h oil-trash)
    skip_confirm_for_simple_edits = false, -- Skip the confirmation popup for simple operations (:help oil.skip_confirm_for_simple_edits)
    constrain_cursor = "editable",         -- Constrain the cursor to the editable parts of the oil buffer. Set to `false` to disable, or "name" to keep it on the file names
    watch_for_changes = true,              -- Set to true to watch the filesystem for changes and reload oil
    keymaps = {
      ['<C-h>'] = false,
      -- ['<C-s>'] = false, -- You used to use C-s for save. oil uses is to open cword under cursor in split, file or folder
    },
    view_options = {
      show_hidden = true, -- Show files and directories that start with "."
    },
    float = {
      padding = 20, -- Padding around the floating window
      border = 'rounded',
      win_options = {
        -- winblend = 10,
      },
    },
  },
  config = function(_, opts)
    local oil = require 'oil'
    oil.setup(opts)

    vim.keymap.set('n', '-', oil.toggle_float, { desc = 'Oil' })
  end,
}
