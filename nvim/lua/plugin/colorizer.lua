--
-- catgoose/nvim-colorizer.lua

---@type LazySpec
return {
  'catgoose/nvim-colorizer.lua',
  event = 'BufReadPre',
  keys = {
    { '<leader>sc', '<cmd>ColorizerToggle<cr>', desc = 'Color: show' },
  },
  opts = { -- set to setup table
    filetypes = { 'css', 'html' }, -- d: '*'
    user_default_options = {
      css = true,
      tailwind = false, -- d: false, true = normal, normal | lsp | both

      mode = 'virtualtext', -- d: background, background | foreground | virtualtext
      virtualtext_inline = true, -- d: false, true = after, before | after
    },
  },
}
