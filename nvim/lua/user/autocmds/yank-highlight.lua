--
-- yank highlight

local g_yank_highlight = vim.api.nvim_create_augroup('g-yank-highlight', { clear = true })

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking text',
  group = g_yank_highlight,
  callback = function()
    vim.highlight.on_yank()
  end,
})
