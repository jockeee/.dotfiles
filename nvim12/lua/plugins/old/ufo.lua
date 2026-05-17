--
-- kevinhwang91/nvim-ufo

vim.pack.add {
  'https://github.com/kevinhwang91/nvim-ufo',
  'https://github.com/kevinhwang91/promise-async',
}

local ufo = require 'ufo'

ufo.setup {
  provider_selector = function()
    return { 'lsp', 'indent' }
  end,
  close_fold_kinds_for_ft = { -- Run `UfoInspect` for details if your provider has extended the kinds.
    default = { 'region' }, -- 'comment', 'imports', 'region'
    lua = {},
    -- json = { 'array' },
    -- c = { 'comment', 'region' },
  },
}

vim.keymap.set('n', 'zR', ufo.openAllFolds)
vim.keymap.set('n', 'zM', ufo.closeAllFolds)
vim.keymap.set('n', 'zr', ufo.openFoldsExceptKinds)
vim.keymap.set('n', 'zm', ufo.closeFoldsWith) -- closeAllFolds == closeFoldsWith(0)
vim.keymap.set('n', 'K', function()
  local winid = ufo.peekFoldedLinesUnderCursor()
  if not winid then
    -- If there is no fold under cursor, fallback to default behavior of K, vim.lsp.buf.hover
    vim.lsp.buf.hover { border = 'rounded', max_width = 120, max_height = 25 }
  end
end)
