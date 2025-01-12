return {
  {
    'nvim-lua/plenary.nvim', -- lua functions that many plugins use
    lazy = 'VimEnter',
  },

  {
    "folke/lazydev.nvim",
    lazy = 'VimEnter',
    -- ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
}
