--
-- folke/todo-comments.nvim

-- Highlight, list and search todo comments in your projects

-- keywords
--   FIX  = alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }
--   TODO
--   HACK
--   WARN = alt = { "WARNING", "XXX" }
--   PERF = alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" }
--   NOTE = alt = { "INFO" }
--   TEST = alt = { "TESTING", "PASSED", "FAILED" }

---@type LazySpec
return {
  'folke/todo-comments.nvim',
  event = { 'UIEnter' },
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {
    highlight = {
      multiline = false,
    },
    signs = false, -- d: true, icons in signs column
  },
  config = function(_, opts)
    local todo_comments = require 'todo-comments'
    todo_comments.setup(opts)

    vim.keymap.set('n', '<leader>ft', require('snacks').picker.todo_comments, { desc = 'Todo' })
    vim.keymap.set('n', ']t', todo_comments.jump_next, { desc = 'Next todo comment' })
    vim.keymap.set('n', '[t', todo_comments.jump_prev, { desc = 'Previous todo comment' })
  end,
}
