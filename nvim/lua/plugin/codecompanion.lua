--
-- olimorris/codecompanion.nvim

return {
  'olimorris/codecompanion.nvim',
  keys = {
    { '<leader>qq', mode = { 'n', 'x' }, '<cmd>CodeCompanionChat<cr>', desc = 'AI: chat' },
  },
  dependencies = {
    require 'plugin.render-markdown',
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
    'ravitemer/mcphub.nvim', -- mcp extension
  },
  opts = {
    extensions = {
      mcphub = {
        callback = 'mcphub.extensions.codecompanion',
        opts = {
          make_vars = true,
          make_slash_commands = true,
          show_result_in_chat = true,
        },
      },
    },
  },
}
