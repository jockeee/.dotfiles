--
-- yank highlight

local active = true

if not active then return end

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking text',
  group = vim.api.nvim_create_augroup('config-yank-highlight', { clear = true }),
  callback = function() vim.hl.on_yank() end,
})
