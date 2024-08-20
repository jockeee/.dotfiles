--
-- https://github.com/stevearc/aerial.nvim
-- Code outline
--
-- https://github.com/stevearc/aerial.nvim#options

return {
  'stevearc/aerial.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  keys = {
    {
      '<leader>a',
      function()
        require('aerial').toggle()
      end,
      mode = 'n',
      desc = 'Aerial',
    },
  },
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    require('aerial').setup {
      layout = {
        min_width = 20,
      },
      -- optionally use on_attach to set keymaps when aerial has attached to a buffer
      on_attach = function(bufnr)
        -- Jump forwards/backwards with '{' and '}'
        vim.keymap.set('n', '<leader>{', '<cmd>AerialPrev<CR>', { buffer = bufnr })
        vim.keymap.set('n', '<leader>}', '<cmd>AerialNext<CR>', { buffer = bufnr })
      end,
    }
  end,
}
