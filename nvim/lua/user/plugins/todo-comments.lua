--
-- https://github.com/folke/todo-comments.nvim
-- Highlight, list and search todo comments in your projects
--
-- keywords
--   FIX = alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
--   TODO
--   HACK
--   WARN = alt = { "WARNING", "XXX" }
--   PERF = alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" }
--   NOTE = alt = { "INFO" }
--   TEST = alt = { "TESTING", "PASSED", "FAILED" }

return {
  'folke/todo-comments.nvim',
  event = 'VimEnter',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {
    signs = true, -- show icons in the signs column
  },
  -- config = function(opts)
  --   local todo_comments = require("todo-comments")
  --
  --   vim.keymap.set("n", "]t", function() todo_comments.jump_next() end, { desc = "Next todo comment" })
  --   vim.keymap.set("n", "[t", function() todo_comments.jump_prev() end, { desc = "Previous todo comment" })
  --
  --   todo_comments.setup(opts)
  -- end,
}
