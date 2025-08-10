--
-- plugin/gitsigns.lua

-- Git integration for buffers
-- Adds git related signs to the gutter, and utilities for managing changes

return {
  'lewis6991/gitsigns.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  opts = {
    on_attach = function(bufnr)
      local gitsigns = require 'gitsigns'

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      -- Navigation
      --  c = change
      map('n', ']c', function()
        if vim.wo.diff then
          vim.cmd.normal { ']c', bang = true }
        else
          gitsigns.nav_hunk 'next'
        end
      end, { desc = 'git change, next' })

      map('n', '[c', function()
        if vim.wo.diff then
          vim.cmd.normal { '[c', bang = true }
        else
          gitsigns.nav_hunk 'prev'
        end
      end, { desc = 'git change, prev' })

      -- Actions
      -- visual mode
      map('v', '<leader>hs', function()
        gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
      end, { desc = 'git stage hunk' })
      map('v', '<leader>hr', function()
        gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
      end, { desc = 'git reset hunk' })
      -- normal mode
      map('n', '<leader>hs', gitsigns.stage_hunk, { desc = 'stage hunk' })
      map('n', '<leader>hr', gitsigns.reset_hunk, { desc = 'reset hunk' })
      map('n', '<leader>hu', gitsigns.stage_hunk, { desc = 'undo stage hunk' })
      map('n', '<leader>hS', gitsigns.stage_buffer, { desc = 'stage buffer' })
      map('n', '<leader>hR', gitsigns.reset_buffer, { desc = 'reset buffer' })
      map('n', '<leader>hp', gitsigns.preview_hunk, { desc = 'preview hunk' })
      map('n', '<leader>hb', gitsigns.blame_line, { desc = 'git blame line' })
      map('n', '<leader>hd', gitsigns.diffthis, { desc = 'git diff against index' })
      map('n', '<leader>hD', function()
        gitsigns.diffthis '@'
      end, { desc = 'diff against last commit' })
      -- Toggles
      map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = 'git show blame line' })
      map('n', '<leader>td', gitsigns.preview_hunk_inline, { desc = 'git show deleted' })
    end,
  },
}
