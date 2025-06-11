--
-- https://github.com/echasnovski/mini.nvim
-- Library of 40+ independent Lua modules improving overall Neovim (version 0.8 and higher) experience with minimal effort

return {
  'echasnovski/mini.nvim',
  version = false,
  event = 'VimEnter',
  opts = {},
  config = function(_, opts)
    require('mini.icons').setup()
    require('mini.statusline').setup()
end
}
