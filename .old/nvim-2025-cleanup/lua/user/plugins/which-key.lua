--
-- https://github.com/folke/which-key.nvim
-- WhichKey displays a popup with possible keybindings of the command you started typing.

return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  opts = {},
  config = function()
    local wk = require('which-key')
    wk.setup()

    -- Add groups to which-key
    wk.add {
      { '<leader>c', group = 'Code' },
      { '<leader>d', group = 'Buffer' },
      { '<leader>f', group = 'Find' },
      { '<leader>g', group = 'Diffview',   mode = { 'n', 'v' } },
      { '<leader>h', group = 'Git Hunk',   mode = { 'n', 'v' } },
      { '<leader>m', group = 'Multicursor' },
      { '<leader>q', group = 'Play Around' },
      { '<leader>t', group = 'Toggle' },
      { '<leader>w', group = 'Workspace' },
      { '<leader>x', group = 'Trouble' },
      { '<leader>z', group = 'nvim' },
    }
  end,
}
