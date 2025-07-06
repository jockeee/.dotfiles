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
    -- persist_mode = true, -- if set to true (default) the previous terminal mode will be remembered
    float_opts = {
      winblend = 10,
    },
  },
  config = function(_, opts)
    local tt = require 'toggleterm'
    tt.setup(opts)

    vim.keymap.set({ 'v', 't' }, '`', '<cmd>ToggleTerm direction=float<cr>', { desc = 'Exit Terminal' })
  end,
}
