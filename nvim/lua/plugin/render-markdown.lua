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
    render_modes = { 'n', 'c', 't', 'i', 'v', 'V', '\22' }, -- d: n, c, t
    completions = { lsp = { enabled = true } },
    file_types = { 'markdown', 'codecompanion' },

    -- anti_conceal = {
    --   enabled = true, -- d: true
    --   -- disabled_modes = { 'n' },
    -- },

    heading = {
      icons = { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' },
      width = 'block',
      min_width = 30,
    },

    code = {
      -- position = 'right', -- language position
      language_pad = 0,
      language_border = ' ',

      width = 'block',
      min_width = 76,
      -- left_pad = 2,
      right_pad = 4,

      border = 'none', -- d: hide, none | thick | thin | hide
      -- highlight = 'RenderMarkdownCode', -- Highlight for code blocks.
      -- highlight_info = 'RenderMarkdownCodeInfo', -- Highlight for code info section, after the language.
      -- highlight_language = nil, Highlight for language, overrides icon provider value.
      -- highlight_border = false, -- d: RenderMarkdownCodeBorder, border, use false to add no highlight.
      -- highlight_fallback = 'RenderMarkdownCodeFallback', -- Highlight for language, used if icon provider does not have a value.
      -- highlight_inline = 'RenderMarkdownCodeInline', -- Highlight for inline code.
    },

    html = {
      tag = {
        -- codecompanion, context group
        buf = {
          icon = '󰈙 ',
          highlight = 'Comment',
        },
        group = {
          icon = ' ',
          highlight = 'Comment',
        },
      },
    },
  },
}
