--
--  https://github.com/NeogitOrg/neogit
--  An interactive and powerful Git interface for nvim, inspired by Magit

return {
  'NeogitOrg/neogit',
  dependencies = {
    'nvim-lua/plenary.nvim',                               -- required
    'sindrets/diffview.nvim',                              -- optional - diff integration
    { 'nvim-tree/nvim-web-devicons', event = 'VeryLazy' }, -- for pretty icons, requires a nerd font

    -- Only one of these is needed, not both.
    'nvim-telescope/telescope.nvim', -- optional
    -- "ibhagwan/fzf-lua",           -- optional
  },
  keys = { { '<leader>gn', '<cmd>Neogit<cr>', desc = 'Neogit' } },
  config = true,
}