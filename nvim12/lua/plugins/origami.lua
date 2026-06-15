--
-- chrisgrieser/nvim-origami

vim.pack.add {
  'https://github.com/chrisgrieser/nvim-origami',
}

require('origami').setup {
  foldKeymaps = {
    setup = false,
  },
}

-- vim.keymap.set('n', 'h', function() require('origami').h() end)
-- vim.keymap.set('n', 'l', function() require('origami').l() end)
vim.keymap.set('n', '^', function()
  require('origami').caret()
end)
vim.keymap.set('n', '$', function()
  require('origami').dollar()
end)
