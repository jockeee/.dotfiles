--
-- https://github.com/MeanderingProgrammer/render-markdown.nvim
-- Improve viewing Markdown files in nvim

return {
  'MeanderingProgrammer/render-markdown.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons',
  },
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  opts = {},
}
