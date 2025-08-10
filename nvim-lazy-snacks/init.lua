--
-- init.lua

vim.loader.enable()

require 'user.globals'
require 'user.options'
require 'user.lazy'
require 'user.keymaps'

-- highlight when yanking text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking text',
  group = vim.api.nvim_create_augroup('custom-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
