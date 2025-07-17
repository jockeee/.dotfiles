--
-- catgoose/nvim-colorizer.lua

-- :h colorizer
-- https://github.com/catgoose/nvim-colorizer.lua#setup-examples
-- https://catgoose.github.io/nvim-colorizer.lua/modules/colorizer.html

---@type LazySpec
return {
  'catgoose/nvim-colorizer.lua',
  event = { 'BufReadPre', 'BufNewFile' },
  keys = {
    { '<leader>sc', '<cmd>ColorizerToggle<cr>', desc = 'Colorizer' },
  },
  opts = {
    filetypes = { 'html', 'css', 'javascript' }, -- d: '*'
    user_default_options = {
      names = false, -- d: true
      css = true, -- d: false
      tailwind = false, -- d: false, true = normal, normal | lsp | both

      mode = 'virtualtext', -- d: background, background | foreground | virtualtext
      virtualtext_inline = true, -- d: false, true = after, before | after
    },
  },
}
