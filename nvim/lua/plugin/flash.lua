--
-- folke/flash.nvim

return {
  'folke/flash.nvim',
  event = 'VeryLazy',
  ---@type Flash.Config
  opts = {
    highlight = {
      backdrop = false, -- default: true
    },
    modes = {
      -- options used when flash is activated through a regular search with
      -- `/` or `?`
      -- search = {
      --   enabled = false,
      --   highlight = { backdrop = false },
      --   jump = { history = true, register = true, nohlsearch = true },
      --   search = {
      --     -- `forward` will be automatically set to the search direction
      --     -- `mode` is always set to `search`
      --     -- `incremental` is set to `true` when `incsearch` is enabled
      --   },
      -- },

      -- options used when flash is activated through motions
      -- `f`, `F`, `t`, `T`, `;` `,`
      char = {
        enabled = false, -- d: true
        highlight = { backdrop = false }, -- d: true
      },
    },
  },
  -- stylua: ignore
  keys = {
    { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    -- { "<leader>ss", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
    -- { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    -- { "<C-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
  },
}
