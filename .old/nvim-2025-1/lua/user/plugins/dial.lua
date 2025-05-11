--
-- https://github.com/monaqa/dial.nvim
-- Enhanced increment/decrement plugin for nvim
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
    local map = require 'dial.map'
    local augend = require 'dial.augend'

    require('dial.config').augends:register_group {
      default = {
        augend.integer.alias.decimal,                       -- 123 inc becomes 124
        augend.integer.alias.hex,                           -- 0x1f inc becomes 0x20
        augend.date.alias['%Y-%m-%d'],                      -- 2020-01-01 inc becomes 2020-01-02
        augend.constant.alias.bool,                         -- cycle true/false
        augend.constant.new { elements = { 'on', 'off' } }, -- custom constant cycle list
      },
      visual = {
        augend.integer.alias.decimal,                                     -- 123 inc becomes 124
        augend.integer.alias.hex,                                         -- 0x1f inc becomes 0x20
        augend.date.alias['%Y-%m-%d'],                                    -- 2020-01-01 inc becomes 2020-01-02
        augend.constant.alias.bool,                                       -- cycle true/false
        augend.constant.alias.alpha,                                      -- a inc becomes b
        augend.constant.alias.Alpha,                                      -- A inc becomes B
        augend.semver.alias.semver,                                       -- 1.2.3 inc becomes 1.2.4 depending on cursor position, 1.2.3 inc becomes 1.3.0
        augend.constant.new { elements = { 'on', 'off' }, word = false }, -- custom constant cycle list
      },
    }

    -- change augends in VISUAL mode
    vim.keymap.set('v', '<C-a>', map.inc_visual 'visual', { noremap = true })
    vim.keymap.set('v', '<C-x>', map.dec_visual 'visual', { noremap = true })

    -- stylua: ignore start
    vim.keymap.set('n', '<C-a>', function() map.manipulate('increment', 'normal') end)
    vim.keymap.set('n', '<C-x>', function() map.manipulate('decrement', 'normal') end)
    vim.keymap.set('n', 'g<C-a>', function() map.manipulate('increment', 'gnormal') end)
    vim.keymap.set('n', 'g<C-x>', function() map.manipulate('decrement', 'gnormal') end)
    vim.keymap.set('v', '<C-a>', function() map.manipulate('increment', 'visual') end)
    vim.keymap.set('v', '<C-x>', function() map.manipulate('decrement', 'visual') end)
    vim.keymap.set('v', 'g<C-a>', function() map.manipulate('increment', 'gvisual') end)
    vim.keymap.set('v', 'g<C-x>', function() map.manipulate('decrement', 'gvisual') end)
    -- stylua: ignore end
  end,
}