--
-- https://github.com/windwp/nvim-autopairs
-- Auto close surrounding characters like parens, brackets, curly braces, quotes, single quotes and tags

return {
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  -- Optional dependency
  dependencies = { 'hrsh7th/nvim-cmp' },
  config = function()
    require('nvim-autopairs').setup {}
    -- If you want to automatically add `(` after selecting a function or method
    local cmp_autopairs = require 'nvim-autopairs.completion.cmp' -- import nvim-autopairs completion functionality
    local cmp = require 'cmp' -- import nvim-cmp plugin (completions plugin)
    cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done()) -- make autopairs and completion work together
  end,
}
