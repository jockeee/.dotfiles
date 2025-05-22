--
-- https://github.com/AndrewRadev/sideways.vim
-- Move function arguments (and other delimited-by-something items) left and right.

return {
  'AndrewRadev/sideways.vim',
  event = { 'BufReadPre', 'BufNewFile' },
  opts = {},
  config = function()
    -- .vim plugin, no lua API

    vim.keymap.set({ 'n', 'v' }, '<leader><left>', '<cmd>SidewaysLeft<cr>', { desc = 'Sideways: Left' })
    vim.keymap.set({ 'n', 'v' }, '<leader><right>', '<cmd>SidewaysRight<cr>', { desc = 'Sideways: Right' })
  end,
}
