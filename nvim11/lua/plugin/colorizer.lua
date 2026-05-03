--
-- catgoose/nvim-colorizer.lua

-- :h colorizer
-- https://github.com/catgoose/nvim-colorizer.lua#setup-examples
-- https://catgoose.github.io/nvim-colorizer.lua/modules/colorizer.html

-- TODO: colorizer: A new structured 'options' format is available (parsers, display, hooks).
-- TODO: Your 'user_default_options' will continue to work. See :help colorizer.config. Set suppress_deprecation = true to hide this message.

---@type LazySpec
return {
  'catgoose/nvim-colorizer.lua',
  event = { 'BufReadPre', 'BufNewFile' },
  keys = {
    { '<leader>cs', '<cmd>ColorizerToggle<cr>', desc = 'Colorizer' },
  },
  opts = {
    filetypes = { 'css', 'html', 'javascript' }, -- d: '*'
    user_default_options = {
      suppress_deprecation = true,
      names = false, -- d: true
      css = true, -- d: false
      tailwind = false, -- d: false, true = normal, normal | lsp | both

      mode = 'virtualtext', -- d: background, background | foreground | virtualtext
      virtualtext_inline = true, -- d: false, false | true | 'before' | 'after'
    },
  },
}
