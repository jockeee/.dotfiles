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
  opts = {
    -- start_in_insert = true,
    -- insert_mappings = true, -- whether or not the open mapping applies in insert mode
    -- terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
  },
  config = function(_, opts)
    local tt = require 'toggleterm'
    tt.setup(opts)

    -- vim.keymap.set('t', '`', '<C-\\><C-n><cmd>ToggleTerm direction=float<cr>', { desc = 'Exit Terminal' })
    vim.keymap.set('t', '`', '<cmd>ToggleTerm direction=float<cr>', { desc = 'Exit Terminal' })
  end,
}
