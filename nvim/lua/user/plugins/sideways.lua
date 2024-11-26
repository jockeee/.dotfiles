--
-- https://github.com/AndrewRadev/sideways.vim
-- Move function arguments (and other delimited-by-something items) left and right.

return {
  'AndrewRadev/sideways.vim',
  event = { 'BufReadPre', 'BufNewFile' },
  opts = {},
  config = function()
    vim.keymap.set({ 'n', 'v' }, '<leader><left>', '<cmd>SidewaysLeft<cr>')
    vim.keymap.set({ 'n', 'v' }, '<leader><right>', '<cmd>SidewaysRight<cr>')
  end,
}
