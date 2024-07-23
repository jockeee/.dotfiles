--
-- https://github.com/nvim-tree/nvim-tree.lua
-- A file explorer tree for neovim written in lua
--
-- https://github.com/nvim-tree/nvim-tree.lua/blob/master/doc/nvim-tree-lua.txt
--
-- lualine integration
-- https://github.com/nvim-lualine/lualine.nvim#extensions
--    extensions = { 'nvim-tree' }

return {
  'kyazdani42/nvim-tree.lua',
  dependencies = {
    'nvim-tree/nvim-web-devicons', -- for pretty icons, requires a nerd font
  },
  keys = { { '\\', '<cmd>NvimTreeToggle<cr>' } },
  config = function()
    require('nvim-tree').setup {
      renderer = {
        group_empty = true,
      },
      update_focused_file = {
        enable = true,
      },
    }
  end,
}
