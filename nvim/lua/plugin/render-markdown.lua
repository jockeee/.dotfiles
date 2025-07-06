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
  opts = {
    completions = { lsp = { enabled = true } },
    code = {
      border = 'thin', -- d: hide, none | thick | thin | hide
      -- highlight = 'RenderMarkdownCode', -- Highlight for code blocks.
      -- highlight_info = 'RenderMarkdownCodeInfo', -- Highlight for code info section, after the language.
      -- highlight_language = nil, Highlight for language, overrides icon provider value.
      highlight_border = false, -- d: RenderMarkdownCodeBorder, border, use false to add no highlight.
      -- highlight_fallback = 'RenderMarkdownCodeFallback', -- Highlight for language, used if icon provider does not have a value.
      -- highlight_inline = 'RenderMarkdownCodeInline', -- Highlight for inline code.
    },
  },
}
