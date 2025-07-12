--
-- olimorris/codecompanion.nvim

return {
  'olimorris/codecompanion.nvim',
  keys = {
    { '<leader>qq', mode = { 'n', 'x' }, '<cmd>CodeCompanionChat Toggle<cr>', desc = 'chat: toggle' },
    { '<leader>qn', mode = { 'n', 'x' }, '<cmd>CodeCompanionChat<cr>', desc = 'chat: new' },
    { '<leader>qa', mode = { 'n', 'x' }, '<cmd>CodeCompanionActions<cr>', desc = 'chat: new' },
  },
  dependencies = {
    require 'plugin.render-markdown',
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
    'ravitemer/mcphub.nvim', -- mcp extension
  },
  opts = {
    display = {
      chat = {
        show_settings = true,

        window = {
          opts = {
            signcolumn = 'yes',
          },
        },
      },
    },

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
