--
-- hakonharnes/img-clip.nvim

vim.pack.add {
  'https://github.com/hakonharnes/img-clip.nvim',
}

require('img-clip').setup {}

-- vim.keymap.set('n', '<leader>p', '<cmd>PasteImage<cr>', { desc = 'Paste image from clipboard' })

vim.keymap.set('n', '<Leader>i', function()
  Snacks.picker.files {
    ft = { 'jpg', 'jpeg', 'png', 'webp' },
    confirm = function(self, item, _)
      self:close()
      require('img-clip').paste_image({}, './' .. item.file) -- ./ is necessary for img-clip to recognize it as path
    end,
  }
end)
