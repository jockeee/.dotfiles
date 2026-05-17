--
-- folke/todo-comments.nvim

vim.pack.add {
  'https://github.com/folke/todo-comments.nvim',
  'https://github.com/nvim-lua/plenary.nvim',
}

-- BUG FIX HACK TODO PERF WARNING
local todo = require 'todo-comments'
todo.setup {
  highlight = {
    multiline = false,
  },
  signs = false, -- d: true, icons in sign column
}

vim.keymap.set('n', '<leader>fS', function()
  require('snacks').picker['todo_comments']()
end, { desc = 'todo' })
