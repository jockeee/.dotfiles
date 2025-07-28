--
-- https://github.com/jake-stewart/multicursor.nvim
-- Multiple cursors

return {
  'jake-stewart/multicursor.nvim',
  branch = '1.0',
  event = { 'BufReadPre', 'BufNewFile' },
  opts = {},
  config = function(_, opts)
    local mc = require 'multicursor-nvim'
    mc.setup(opts)

    -- Customize how cursors look
    local hl = vim.api.nvim_set_hl
    hl(0, 'MultiCursorCursor', { link = 'Cursor' })
    hl(0, 'MultiCursorVisual', { link = 'Visual' })
    -- hl(0, 'MultiCursorSign', { link = 'SignColumn' })
    hl(0, 'MultiCursorDisabledCursor', { link = 'Visual' })
    hl(0, 'MultiCursorDisabledVisual', { link = 'Visual' })
    -- hl(0, 'MultiCursorDisabledSign', { link = 'SignColumn' })

    -- You can add cursors with any motion you prefer:
    -- vim.keymap.set("n", "<right>", function()
    --     mc.addCursor("w")
    -- end)
    -- vim.keymap.set("n", "<leader><right>", function()
    --     mc.skipCursor("w")
    -- end)

    vim.keymap.set('n', '<C-leftmouse>', mc.handleMouse) -- Add and remove cursors with control + left click.

    -- Rotate the main cursor
    vim.keymap.set({ 'n', 'v' }, '<C-left>', mc.nextCursor)
    vim.keymap.set({ 'n', 'v' }, '<C-right>', mc.prevCursor)

    -- Add cursor above/below the main cursor
    vim.keymap.set({ 'n', 'v' }, '<C-up>', function()
      mc.lineAddCursor(-1)
    end, { desc = 'Multicursor: Add cursor, up' })
    vim.keymap.set({ 'n', 'v' }, '<C-down>', function()
      mc.lineAddCursor(1)
    end, { desc = 'Multicursor: Add cursor, down' })

    -- Skip cursor above/below the main cursor
    vim.keymap.set({ 'n', 'v' }, '<leader><C-up>', function()
      mc.lineSkipCursor(-1)
    end, { desc = 'Multicursor: Skip cursor, up' })
    vim.keymap.set({ 'n', 'v' }, '<leader><C-down>', function()
      mc.lineSkipCursor(1)
    end, { desc = 'Multicursor: Skip cursor, down' })

    vim.keymap.set({ 'n', 'v' }, '<C-n>', function()
      mc.matchAddCursor(1)
    end, { desc = 'Multicursor: Add matching word/selection, next' })

    -- Add a new cursor by matching word/selection
    vim.keymap.set({ 'n', 'v' }, '<leader>n', function()
      mc.matchAddCursor(1)
    end, { desc = 'Multicursor: Add matching word/selection, next' })
    vim.keymap.set({ 'n', 'v' }, '<leader>N', function()
      mc.matchAddCursor(-1)
    end, { desc = 'Multicursor: Add matching word/selection, prev' })

    -- Skip adding a new cursor by matching word/selection
    vim.keymap.set({ 'n', 'v' }, '<leader>s', function()
      mc.matchSkipCursor(1)
    end, { desc = 'Multicursor: Skip matching word/selection, next' })
    vim.keymap.set({ 'n', 'v' }, '<leader>S', function()
      mc.matchSkipCursor(-1)
    end, { desc = 'Multicursor: Skip matching word/selection, prev' })

    vim.keymap.set('n', '<leader>mgv', mc.restoreCursors, { desc = 'Multicursor: Restore cursors' })
    vim.keymap.set('n', '<leader>ma', mc.alignCursors, { desc = 'Align cursor columns' })
    vim.keymap.set({ 'n', 'v' }, '<leader>mA', mc.matchAllAddCursors, { desc = 'MultiCursor: Add all matches' })
    vim.keymap.set({ 'n', 'v' }, '<leader>mx', mc.deleteCursor, { desc = 'Delete the main cursor' })
    -- vim.keymap.set({ 'n', 'v' }, '<C-q>', mc.toggleCursor) -- Easy way to add and remove cursors using the main cursor.
    -- vim.keymap.set({ 'n', 'v' }, '<leader>m<C-q>', mc.duplicateCursors, { desc = 'Clone every cursor and disable the originals' })

    -- Jumplist support
    vim.keymap.set({ 'v', 'n' }, '<C-i>', mc.jumpForward)
    vim.keymap.set({ 'v', 'n' }, '<C-o>', mc.jumpBackward)

    vim.keymap.set('v', '<leader>ms', mc.splitCursors, { desc = 'Split visual selections by regex' })

    vim.keymap.set('v', 'I', mc.insertVisual, { desc = 'Insert for each line of visual selections' })
    vim.keymap.set('v', 'A', mc.appendVisual, { desc = 'Append for each line of visual selections' })
    vim.keymap.set('v', 'M', mc.matchCursors, { desc = 'Match new cursors within visual selections by regex' })

    -- Rotate visual selection contents
    vim.keymap.set('v', '<leader>mt', function()
      mc.transposeCursors(1)
    end, { desc = 'Rotate visual selection contents' })
    vim.keymap.set('v', '<leader>mT', function()
      mc.transposeCursors(-1)
    end, { desc = 'Rotate visual selection contents' })
  end,
}
