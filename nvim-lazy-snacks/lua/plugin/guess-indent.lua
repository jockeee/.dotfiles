--
-- NMAC427/guess-indent.nvim

-- Automatic indentation style detection for Neovim

return {
  'NMAC427/guess-indent.nvim', -- Detect tabstop and shiftwidth automatically
  event = 'BufReadPre',
  opts = {},
}
