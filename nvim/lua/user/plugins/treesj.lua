--
-- https://github.com/Wansmer/treesj
-- split/join blocks of code
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

return {
  'Wansmer/treesj',
  keys = {
    { '<leader>j', '<cmd>TSJToggle<cr>', desc = 'TreeSJ Split/Join' },
    -- { '<leader>m', '<cmd>TSJToggle<cr>', desc = 'TreeSJ: Toggle' },
    -- { '<leader>s', '<cmd>TSJSplit<cr>', desc = 'TreeSJ: Split' },
    -- { '<leader>j', '<cmd>TSJJoin<cr>', desc = 'TreeSJ: Join' },
  },
  opts = {
    ---@type boolean Use default keymaps (<space>m - toggle, <space>j - join, <space>s - split)
    use_default_keymaps = false,
  },
  dependencies = { 'nvim-treesitter/nvim-treesitter' }, -- if you install parsers with `nvim-treesitter`
  config = function(_, opts)
    local treesj = require 'treesj'
    treesj.setup(opts)

    -- Keymaps

    -- Default preset
    -- vim.keymap.set('n', '<leader>m', treesj.toggle)

    -- Extending default preset with `recursive = true`
    vim.keymap.set('n', '<leader>J', function()
      treesj.toggle { split = { recursive = true } }
    end)
  end,
}
