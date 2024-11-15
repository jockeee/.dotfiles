--
-- https://github.com/akinsho/toggleterm.nvim
-- A neovim lua plugin to help easily manage multiple terminal windows
--
-- You use it for quick access to a floating terminal

return {
  'akinsho/toggleterm.nvim',
  version = '*',
  event = 'VimEnter',
  keys = { { '`', '<cmd>ToggleTerm direction=float<cr>', desc = 'Terminal' } },
  config = function()
    require('toggleterm').setup {}
    vim.keymap.set('t', '`', '<C-\\><C-n><cmd>ToggleTerm direction=float<cr>', { desc = 'Exit Terminal' })
  end,
}
