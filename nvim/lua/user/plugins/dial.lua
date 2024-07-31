--
-- https://github.com/monaqa/dial.nvim
-- Enhanced increment/decrement plugin for Neovim
--
-- Increment/decrement based on various type of rules
--    n-ary (2 <= n <= 36) integers
--    date and time
--    constants (an ordered set of specific strings, such as a keyword or operator)
--        true \u21c4 false
--        && \u21c4 ||
--        a \u21c4 b \u21c4 ... \u21c4 z
--    hex colors
--    semantic version
--
-- Support <C-a> / <C-x> / g<C-a> / g<C-x> in VISUAL mode
--
-- Flexible configuration of increment/decrement targets
--    Rules that are valid only in specific FileType
--    Rules that are valid only in VISUAL mode
--
-- Support counter
--
-- Support dot repeat (without overriding the behavior of .)

return {
  'monaqa/dial.nvim',
  keys = { '<C-a>', '<C-x>' }, -- mode is `n` by default
  config = function()
    vim.keymap.set('n', '<C-a>', function()
      require('dial.map').manipulate('increment', 'normal')
    end)
    vim.keymap.set('n', '<C-x>', function()
      require('dial.map').manipulate('decrement', 'normal')
    end)
    vim.keymap.set('n', 'g<C-a>', function()
      require('dial.map').manipulate('increment', 'gnormal')
    end)
    vim.keymap.set('n', 'g<C-x>', function()
      require('dial.map').manipulate('decrement', 'gnormal')
    end)
    vim.keymap.set('v', '<C-a>', function()
      require('dial.map').manipulate('increment', 'visual')
    end)
    vim.keymap.set('v', '<C-x>', function()
      require('dial.map').manipulate('decrement', 'visual')
    end)
    vim.keymap.set('v', 'g<C-a>', function()
      require('dial.map').manipulate('increment', 'gvisual')
    end)
    vim.keymap.set('v', 'g<C-x>', function()
      require('dial.map').manipulate('decrement', 'gvisual')
    end)
  end,
}
