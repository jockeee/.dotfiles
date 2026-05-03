--
-- NMAC427/guess-indent.nvim

-- Automatic indentation style detection for Neovim

---@type LazySpec
return {
  'NMAC427/guess-indent.nvim',
  event = 'BufReadPre',
  opts = {
    override_editorconfig = false, -- d: false
  },
}
