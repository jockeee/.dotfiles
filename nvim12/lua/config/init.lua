--
-- config/init.lua

require('config.globals')

--- === === === ===
--- autocmds
--- === === === ===

--- yank highlight

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking text',
  group = vim.api.nvim_create_augroup('g-yank-highlight', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

require('config.filetypes')
require('config.options')
require('config.keymaps')
