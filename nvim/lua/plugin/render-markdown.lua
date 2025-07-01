--
-- MeanderingProgrammer/render-markdown.nvim

-- Improve viewing Markdown files in nvim

-- Alternatives:
-- markview.nvim
--    https://github.com/OXY2DEV/markview.nvim

return {
  'MeanderingProgrammer/render-markdown.nvim',
  ft = { 'markdown', 'codecompanion' },
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'echasnovski/mini.nvim', -- if you use the mini.nvim suite
  },
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  opts = {},
}
