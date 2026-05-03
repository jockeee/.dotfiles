--
-- andymass/vim-matchup

---@type LazySpec
return {
  'andymass/vim-matchup',
  lazy = false,
  ---@type matchup.Config
  opts = {
    treesitter = {
      stopline = 500,
    },
  },
}
