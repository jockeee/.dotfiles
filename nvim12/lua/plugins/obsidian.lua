--
-- obsidian-nvim/obsidian.nvim

vim.pack.add {
  'https://github.com/obsidian-nvim/obsidian.nvim',
}

require('obsidian').setup {
  legacy_commands = false,
  picker = {
    name = 'snacks.picker',
  },
  workspaces = {
    {
      name = 'no',
      path = '~/no',
    },
  },
}
