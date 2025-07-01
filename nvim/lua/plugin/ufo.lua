--
-- kevinhwang91/nvim-ufo

-- https://www.linux.com/learn/tutorials/442438-vim-tips-folding-fun
--   zf#j        creates a fold from the cursor down # lines.
--   zf/string   creates a fold from the cursor to string .
--   zj          moves the cursor to the next fold.
--   zk          moves the cursor to the previous fold.
--   zo          opens a fold at the cursor.
--   zO          opens all folds at the cursor.
--   zm          increases the foldlevel by one.
--   zM          closes all open folds.
--   zr          decreases the foldlevel by one.
--   zR          decreases the foldlevel to zero -- all folds will be open.
--   zd          deletes the fold at the cursor.
--   zE          deletes all folds.
--   [z          move to start of open fold.
--   ]z          move to end of open fold.

---@type LazySpec
return {
  'kevinhwang91/nvim-ufo',
  event = { 'VimEnter' },
  dependencies = {
    'kevinhwang91/promise-async',
  },
  opts = {
    provider_selector = function()
      return { 'lsp', 'indent' }
    end,
    close_fold_kinds_for_ft = { -- Run `UfoInspect` for details if your provider has extended the kinds.
      default = { 'region' }, -- 'comment', 'imports', 'region'
      lua = {},
      -- json = { 'array' },
      -- c = { 'comment', 'region' },
    },
  },
  config = function(_, opts)
    local ufo = require 'ufo'
    ufo.setup(opts)

    vim.keymap.set('n', 'zR', ufo.openAllFolds)
    vim.keymap.set('n', 'zM', ufo.closeAllFolds)
    vim.keymap.set('n', 'zr', ufo.openFoldsExceptKinds)
    vim.keymap.set('n', 'zm', ufo.closeFoldsWith) -- closeAllFolds == closeFoldsWith(0)
    vim.keymap.set('n', 'K', function()
      local winid = ufo.peekFoldedLinesUnderCursor()
      if not winid then
        -- If there is no fold under cursor, fallback to default behavior of K
        -- vim.lsp.buf.hover()
        vim.lsp.buf.hover { border = 'rounded', max_width = 120, max_height = 25 }
      end
    end)
  end,
}
