--
-- https://github.com/sindrets/diffview.nvim
-- Single tabpage interface for easily cycling through diffs for all modified files for any git rev.
--
-- :h diffview-merge-tool
-- :h diffview-config-view.x.layout
-- Calling :DiffviewOpen with no args opens a new Diffview that compares against the current index. You can also provide any valid git rev to view only changes for that rev.
--
-- Examples:
--
--     :DiffviewOpen
--     :DiffviewOpen HEAD~2
--     :DiffviewOpen HEAD~4..HEAD~2
--     :DiffviewOpen d4a7b0d
--     :DiffviewOpen d4a7b0d^!
--     :DiffviewOpen d4a7b0d..519b30e
--     :DiffviewOpen origin/main...HEAD
--
-- You can also provide additional paths to narrow down what files are shown:
--
--     :DiffviewOpen HEAD~2 -- lua/diffview plugin
--     Additional commands for convenience:
--
--     :DiffviewClose: Close the current diffview. You can also use :tabclose.
--     :DiffviewToggleFiles: Toggle the file panel.
--     :DiffviewFocusFiles: Bring focus to the file panel.
--     :DiffviewRefresh: Update stats and entries in the file list of the current Diffview.
--
-- With a Diffview open and the default key bindings, you can cycle through changed files with <tab> and <s-tab> (see configuration to change the key bindings).

return {
  'sindrets/diffview.nvim',
  event = 'VeryLazy',
  opts = {},
  config = function(_, opts)
    local dv = require 'diffview'
    dv.setup(opts)

    vim.keymap.set({ 'n', 'v' }, '<leader>gd', dv.open, { desc = 'Diffview: Open' })
    vim.keymap.set({ 'n', 'v' }, '<leader>gg', dv.close, { desc = 'Diffview: Close' })
    vim.keymap.set({ 'n', 'v' }, '<leader>gr', '<cmd>DiffviewRefresh<cr>', { desc = 'Diffview: Refresh' })
    vim.keymap.set({ 'n', 'v' }, '<leader>gt', '<cmd>DiffviewToggleFiles<cr>', { desc = 'Diffview: Toggle File Panel' })
  end,
}
