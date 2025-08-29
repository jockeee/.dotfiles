--
-- andymass/vim-matchup

---@type LazySpec
return {
  'andymass/vim-matchup',
  ---@type matchup.Config
  opts = {
    treesitter = {
      stopline = 500,
    },
  },
}
