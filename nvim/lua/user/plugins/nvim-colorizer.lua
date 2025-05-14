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
      'html',
      'css',
      'javascript',
      php = { mode = 'background' },
    },
    user_default_options = {
      names = false, -- "Name" codes like Blue or red.  Added from `vim.api.nvim_get_color_map()`
      names_opts = { -- options for mutating/filtering names.
        lowercase = true, -- name:lower(), highlight `blue` and `red`
        camelcase = true, -- name, highlight `Blue` and `Red`
        uppercase = false, -- name:upper(), highlight `BLUE` and `RED`
        strip_digits = false, -- ignore names with digits, highlight `blue` and `red`, but not `blue3` and `red4`
      },
      RGB = true, -- #RGB hex codes
      RGBA = true, -- #RGBA hex codes
      RRGGBB = true, -- #RRGGBB hex codes
      RRGGBBAA = false, -- #RRGGBBAA hex codes
      AARRGGBB = false, -- 0xAARRGGBB hex codes
      rgb_fn = true, -- CSS rgb() and rgba() functions
      hsl_fn = true, -- CSS hsl() and hsla() functions
      -- Enable all CSS *features*:
      --  names, RGB, RGBA, RRGGBB, RRGGBBAA, AARRGGBB, rgb_fn, hsl_fn
      css = false,
      css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn
      -- Tailwind colors.  boolean|'normal'|'lsp'|'both'.  True sets to 'normal'
      tailwind = true, -- default: false  Enable tailwind colors
      tailwind_opts = { -- Options for highlighting tailwind names
        update_names = true, -- When using tailwind = 'both', update tailwind names from LSP results. See tailwind section
      },
      mode = 'virtualtext', -- default: 'background', 'background'|'foreground'|'virtualtext'  Set the display mode Highlighting mode
      virtualtext = '■', -- Virtualtext character to use
      virtualtext_inline = false, -- Display virtualtext inline with color.  boolean|'before'|'after'.  True sets to 'after'
    },
  },
}
