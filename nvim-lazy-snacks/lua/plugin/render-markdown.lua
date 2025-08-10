--
-- https://github.com/MeanderingProgrammer/render-markdown.nvim
-- Improve viewing Markdown files in nvim

return {
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'echasnovski/mini.nvim', -- if you use the mini.nvim suite
  },
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  opts = {},
}
