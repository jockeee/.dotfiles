--
-- folke/which-key.nvim

-- Create key bindings that stick.
-- WhichKey helps you remember your Neovim keymaps,
-- by showing available keybindings in a popup as you type.
--
-- :checkhealth which-key

return {
  'folke/which-key.nvim',
  event = 'VimEnter',
  ---@class wk.Opts
  opts = {
    -- delay between pressing a key and opening which-key (milliseconds)
    -- this setting is independent of vim.opt.timeoutlen
    delay = 300,
  },
  config = function(_, opts)
    local wk = require 'which-key'
    wk.setup(opts)

    -- Document existing key chains
    wk.add {
      { '<leader>c', group = 'Code' },
      { '<leader>d', group = 'Buffer' },
      { '<leader>f', group = 'Find' },
      { '<leader>g', group = 'Diffview', mode = { 'n', 'v' } },
      { '<leader>h', group = 'Git Hunk', mode = { 'n', 'v' } }, -- gitsigns
      { '<leader>m', group = 'Multicursor' },
      -- { '<leader>p', group = 'Copilot Prompt' },
      { '<leader>q', group = 'Copilot Chat' },
      { '<leader>t', group = 'Toggle' },
      { '<leader>v', group = 'Hurl' },
      { '<leader>w', group = 'Workspace' },
      { '<leader>x', group = 'Trouble' },
      { '<leader>z', group = 'nvim' },
    }
  end,
}
