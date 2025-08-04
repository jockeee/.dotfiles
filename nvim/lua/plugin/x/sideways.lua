--
-- AndrewRadev/sideways.vim

-- Move function arguments (and other delimited-by-something items) left and right.

-- Alternatives:
--  With Treesitter, you can select and move parameters using custom text objects and motions.

---@type LazySpec
return {
  'AndrewRadev/sideways.vim',
  event = { 'BufReadPre', 'BufNewFile' },
  opts = {},
  config = function()
    -- .vim plugin, no lua API

    vim.keymap.set({ 'n', 'v' }, '<leader><left>', '<cmd>SidewaysLeft<cr>', { desc = 'Sideways: Left' })
    vim.keymap.set({ 'n', 'v' }, '<leader><right>', '<cmd>SidewaysRight<cr>', { desc = 'Sideways: Right' })
  end,
}
