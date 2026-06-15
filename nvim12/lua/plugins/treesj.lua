--
-- Wansmer/treesj

vim.pack.add {
  'https://github.com/Wansmer/treesj',
}

require('treesj').setup {
  use_default_keymaps = false,
}

vim.keymap.set('n', '<leader>j', '<cmd>TSJToggle<cr>', { desc = 'treesj: split/join' })
vim.keymap.set('n', '<leader>J', function()
  require('treesj').toggle {
    split = {
      recursive = true,
    },
  }
end, { desc = 'treesj: split/join (recursive)' })
