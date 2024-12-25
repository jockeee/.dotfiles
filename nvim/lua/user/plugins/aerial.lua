--
-- https://github.com/stevearc/aerial.nvim
-- Code outline
--
-- You will need to have either Treesitter or a working LSP client.
-- You can configure your preferred source(s) with the backends option (see Options).
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
    'nvim-treesitter/nvim-treesitter', -- optional
    'nvim-tree/nvim-web-devicons', -- optional
  },
  config = function()
    local aerial = require 'aerial'
    aerial.setup {
      backends = { 'lsp', 'treesitter', 'markdown', 'asciidoc', 'man' },
      layout = {
        min_width = 20,
        default_direction = 'right',
      },
      -- use on_attach to set keymaps when aerial has attached to a buffer
      on_attach = function(bufnr)
        vim.keymap.set('n', '[[', aerial.prev, { buffer = bufnr, desc = 'Aerial Prev' })
        vim.keymap.set('n', ']]', aerial.next, { buffer = bufnr, desc = 'Aerial Next' })
      end,
    }

    -- vim.keymap.set('n', '<leader>a', '<cmd>Telescope aerial<cr>', { desc = 'Telescope: Aerial' })
    vim.keymap.set('n', '<leader>fa', '<cmd>Telescope aerial<cr>', { desc = 'Telescope: Aerial' })
  end,
}
