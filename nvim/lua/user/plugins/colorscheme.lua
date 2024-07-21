--
-- colorscheme.lua
-- Update global variable `vim.g.user_colorscheme` in `lua/user/globals.lua` with the colorscheme you want to use
--
-- :Telescope colorscheme

return {
  -- catppuccin
  -- https://github.com/catppuccin/nvim
  -- Soothing pastel theme for (Neo)vim
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    lazy = false,
    priority = 1000,
    -- init = function()
    --   vim.cmd.colorscheme 'catppuccin'
    -- end,
  },

  -- https://github.com/Mofiqul/vscode.nvim
  -- Neovim/Vim color scheme inspired by Dark+ and Light+ theme in Visual Studio Code
  {
    'Mofiqul/vscode.nvim',
    name = 'vscode',
    lazy = false,
    priority = 1000,
    init = function()
      vim.cmd.colorscheme 'vscode'
    end,
  },
}
