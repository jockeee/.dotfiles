--
-- https://github.com/folke/flash.nvim
-- Navigate your code with search labels, enhanced character motions and Treesitter integration

return {
  'folke/flash.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  opts = {
    highlight = {
      backdrop = false, -- default: true
    },
    modes = {
      -- options used when flash is activated through
      -- a regular search with `/` or `?`
      -- search = {
      --   enabled = false,
      --   highlight = { backdrop = false },
      --   jump = { history = true, register = true, nohlsearch = true },
      --   search = {
      --     -- `forward` will be automatically set to the search direction
      --     -- `mode` is always set to `search`
      --     -- `incremental` is set to `true` when `incsearch` is enabled
      --   },
      -- },
      -- options used when flash is activated through
      -- `f`, `F`, `t`, `T`, `;` and `,` motions
      char = {
        enabled = false, -- default: true
        highlight = { backdrop = false }, -- default: true
      },
    },
  },
  keys = {
    {
      's',
      mode = { 'n', 'x', 'o' },
      function() require('flash').jump() end,
      desc = 'Flash',
    },
    {
      '<leader>S',
      mode = { 'n', 'x', 'o' },
      function() require('flash').treesitter() end,
      desc = 'Flash Treesitter',
    },
    {
      'r',
      mode = 'o',
      function() require('flash').remote() end,
      desc = 'Remote Flash', -- For example, press yr to start yanking and open flash
    },
    {
      'R',
      mode = { 'o', 'x' },
      function() require('flash').treesitter_search() end,
      desc = 'Treesitter Search',
    },
    {
      '<c-s>',
      mode = { 'c' }, -- command mode
      function() require('flash').toggle() end,
      desc = 'Toggle Flash Search',
    },
  },
}
