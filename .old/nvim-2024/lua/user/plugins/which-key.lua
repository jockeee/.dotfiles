--
-- https://github.com/folke/which-key.nvim
-- WhichKey displays a popup with possible keybindings of the command you started typing.

return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  opts = {},
  config = function()
    require('which-key').setup()

    -- Add groups to which-key
    require('which-key').add {
      { '<leader>c', group = 'Code' },
      { '<leader>d', group = 'Buffer' },
      { '<leader>f', group = 'Find' },
      { '<leader>g', group = 'Diffview', mode = { 'n', 'v' } },
      { '<leader>h', group = 'Git Hunk', mode = { 'n', 'v' } },
      { '<leader>m', group = 'Multicursor' },
      { '<leader>q', group = 'Neovim' },
      { '<leader>t', group = 'Toggle' },
      { '<leader>w', group = 'Workspace' },
      { '<leader>x', group = 'Trouble' },
    }
  end,
}
