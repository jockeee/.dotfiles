--
-- https://github.com/catgoose/nvim-colorizer.lua
-- The fastest Neovim colorizer
--
-- Alternative:
--  https://github.com/echasnovski/mini.hipatterns

return {
  'catgoose/nvim-colorizer.lua',
  event = 'BufReadPre',
  opts = {
    filetypes = {
      -- html = { mode = 'foreground' },
      -- css = {
      --   mode = 'virtualtext',
      --   virtualtext_inline = 'before',
      -- },
      -- css = { mode = 'background' },
      'css',
      'javascript',
    },
    user_default_options = {
      -- Enable all CSS *features*:
      --  names, RGB, RGBA, RRGGBB, RRGGBBAA, AARRGGBB, rgb_fn, hsl_fn
      css = true,
      -- Tailwind colors.  boolean|'normal'|'lsp'|'both'.  True sets to 'normal'
      -- tailwind = false, -- default: false  Enable tailwind colors
      -- tailwind_opts = { -- Options for highlighting tailwind names
      --   update_names = false, -- When using tailwind = 'both', update tailwind names from LSP results. See tailwind section
      -- },
      mode = 'virtualtext', -- default: 'background', 'background'|'foreground'|'virtualtext'  Set the display mode Highlighting mode
      virtualtext = '■', -- Virtualtext character to use
      virtualtext_inline = false, -- Display virtualtext inline with color.  boolean|'before'|'after'.  True sets to 'after'
    },
  },
}
