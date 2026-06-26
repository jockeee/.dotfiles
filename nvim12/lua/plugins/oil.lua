--
-- stevearc/oil.nvim

vim.pack.add {
  'https://github.com/stevearc/oil.nvim',
}

require('oil').setup {
  columns = {
    'icon',
    'permissions',
    'size',
    'mtime',
  },
}

vim.keymap.set('n', '-', '<cmd>Oil<cr>', { desc = 'oil: Open parent directory' })
