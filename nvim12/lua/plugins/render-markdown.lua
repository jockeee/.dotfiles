--
-- MeanderingProgrammer/render-markdown.nvim

vim.pack.add {
  'https://github.com/MeanderingProgrammer/render-markdown.nvim',
}

require('render-markdown').setup {
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
    min_width = 40,
  },

  code = {
    -- position = 'right', -- language position
    -- language_pad = 0,
    -- language_border = ' ',

    -- Width of the code block background.
    -- | block | width of the code block  |
    -- | full  | full width of the window |
    width = 'block',
    min_width = 80, -- Minimum width to use for code blocks when width is 'block'.
    -- left_pad = 2,
    -- right_pad = 4,

    border = 'thick', -- d: hide, none | thick | thin | hide
    -- highlight = 'RenderMarkdownCode', -- Highlight for code blocks.
    -- highlight_info = 'RenderMarkdownCodeInfo', -- Highlight for code info section, after the language.
    highlight_language = 'RenderMarkdownLanguageFG', -- Highlight for language, overrides icon provider value.
    -- highlight_border = false, -- d: RenderMarkdownCodeBorder, border, use false to add no highlight.
    -- highlight_fallback = 'RenderMarkdownCodeFallback', -- Highlight for language, used if icon provider does not have a value.
    -- highlight_inline = 'RenderMarkdownCodeInline', -- Highlight for inline code.

    language_icon = false, -- d: true
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
}
