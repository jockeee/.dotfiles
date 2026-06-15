--
-- lewis6991/gitsigns.nvim

vim.pack.add {
  'https://github.com/lewis6991/gitsigns.nvim',
}

require('gitsigns').setup {
  on_attach = function()
    local gitsigns = require 'gitsigns'

    -- Navigation
    --  c = change
    vim.keymap.set('n', ']c', function()
      if vim.wo.diff then
        vim.cmd.normal { ']c', bang = true }
      else
        gitsigns.nav_hunk 'next'
      end
    end, { desc = 'git change, next' })

    vim.keymap.set('n', '[c', function()
      if vim.wo.diff then
        vim.cmd.normal { '[c', bang = true }
      else
        gitsigns.nav_hunk 'prev'
      end
    end, { desc = 'git change, prev' })

    -- Actions
    -- visual mode
    vim.keymap.set('v', '<leader>hs', function()
      gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
    end, { desc = 'git stage hunk' })
    vim.keymap.set('v', '<leader>hr', function()
      gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
    end, { desc = 'git reset hunk' })
    -- normal mode
    vim.keymap.set('n', '<leader>hs', gitsigns.stage_hunk, { desc = 'stage hunk' })
    vim.keymap.set('n', '<leader>hr', gitsigns.reset_hunk, { desc = 'reset hunk' })
    vim.keymap.set('n', '<leader>hu', gitsigns.stage_hunk, { desc = 'undo stage hunk' })
    vim.keymap.set('n', '<leader>hS', gitsigns.stage_buffer, { desc = 'stage buffer' })
    vim.keymap.set('n', '<leader>hR', gitsigns.reset_buffer, { desc = 'reset buffer' })
    vim.keymap.set('n', '<leader>hp', gitsigns.preview_hunk, { desc = 'preview hunk' })
    vim.keymap.set('n', '<leader>hb', gitsigns.blame_line, { desc = 'git blame line' })
    vim.keymap.set('n', '<leader>hd', gitsigns.diffthis, { desc = 'git diff against index' })
    vim.keymap.set('n', '<leader>hD', function()
      gitsigns.diffthis '@'
    end, { desc = 'diff against last commit' })
    -- Toggles
    vim.keymap.set('n', '<leader>hb', gitsigns.toggle_current_line_blame, { desc = 'blame line' })
    vim.keymap.set('n', '<leader>hx', gitsigns.preview_hunk_inline, { desc = 'deleted lines' })
  end,
}
