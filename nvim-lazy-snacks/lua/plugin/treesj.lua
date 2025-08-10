--
-- https://github.com/Wansmer/treesj
-- split/join code blocks
--
-- turn this
--    keys = { '<leader>m', '<leader>j', '<leader>s' },
-- into this
--    keys = {
--      '<leader>m',
--      '<leader>j',
--      '<leader>s',
--    },
-- and reverse.

-- Alternative:
--  mini.nvim
--    https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-splitjoin.md

return {
  'Wansmer/treesj',
  dependencies = { 'nvim-treesitter/nvim-treesitter' }, -- if you install parsers with `nvim-treesitter`
  keys = {
    { '<leader>j', '<cmd>TSJToggle<cr>', desc = 'TreeSJ: Split/Join' },
    {
      '<leader>J',
      function()
        require('treesj').toggle {
          split = {
            recursive = true,
          },
        }
      end,
      desc = 'treesj: split/join (recursive)',
    },
    -- { '<leader>m', '<cmd>TSJToggle<cr>', desc = 'TreeSJ: Toggle' },
    -- { '<leader>s', '<cmd>TSJSplit<cr>', desc = 'TreeSJ: Split' },
    -- { '<leader>j', '<cmd>TSJJoin<cr>', desc = 'TreeSJ: Join' },
  },
  opts = {
    ---@type boolean Use default keymaps (<space>m - toggle, <space>j - join, <space>s - split)
    use_default_keymaps = false,
  },
  config = function(_, opts)
    local sj = require 'treesj'
    sj.setup(opts)

    -- vim.keymap.set('n', '<leader>j', sj.toggle, { desc = 'TreeSJ: Split/Join' })
    -- vim.keymap.set('n', '<leader>J', function()
    --   sj.toggle { split = { recursive = true } }
    -- end, { desc = 'TreeSJ: Split/Join (recursive)' })
  end,
}
