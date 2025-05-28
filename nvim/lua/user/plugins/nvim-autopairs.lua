--
-- https://github.com/windwp/nvim-autopairs
-- autopairs for neovim written in lua

return {
  'windwp/nvim-autopairs',
  event = { 'BufReadPre', 'BufNewFile' },
  config = true,
}
