--
-- colorscheme.lua
--
-- :Telescope colorscheme

return {
  -- https://github.com/Mofiqul/vscode.nvim
  -- Neovim/Vim color scheme inspired by Dark+ and Light+ theme in Visual Studio Code
  {
    'Mofiqul/vscode.nvim',
    name = 'vscode',
    lazy = false,
    priority = 1000,
    init = function()
      require('vscode').setup {
        italic_comments = false,

        -- Override colors (see ./lua/vscode/colors.lua)
        color_overrides = {
          vscGreen = '#787878',
          vscPopupHighlightGray = '#434343',
        },
      }
      vim.cmd.colorscheme 'vscode'
      vim.cmd.highlight 'StatusLine guifg=#b1b1b1 guibg=#353535 '
      vim.cmd.highlight 'MsgArea guifg=#b1b1b1'
      vim.cmd.highlight '@variable guifg=#e5e5e5'
      vim.cmd.highlight '@string.special.url.html term=none cterm=none'
    end,
  },

  -- https://github.com/catppuccin/nvim
  -- Soothing pastel theme for (Neo)vim
  -- {
  --   'catppuccin/nvim',
  --   name = 'catppuccin',
  --   lazy = false,
  --   priority = 1000,
  --   opts = {
  --     styles = {
  --       comments = {}, -- Default: "italics"
  --     },
  --     -- color_overrides = {
  --     --   mocha = {
  --     --     base = '#1f1f1f', -- background color
  --     --   },
  --     -- },
  --   },
  --   init = function()
  --     vim.cmd.colorscheme 'catppuccin'
  --   end,
  -- },

  -- https://github.com/rebelot/kanagawa.nvim
  -- {
  --   'rebelot/kanagawa.nvim',
  --   name = 'kanagawa',
  --   lazy = false,
  --   priority = 1000,
  --   init = function()
  --     require('kanagawa').setup({
  --       colors = {
  --         theme = {
  --           all = {
  --             ui = {
  --               bg_gutter = 'none'
  --             },
  --           },
  --         },
  --       },
  --       theme = 'dragon',
  --
  --       overrides = function(colors)
  --         local theme = colors.theme
  --         return {
  --           -- Boolean, a boolean constant: TRUE, false
  --           Boolean = { bold = false },
  --
  --           -- Borderless Telescope
  --           -- Block-like modern Telescope UI
  --           TelescopeTitle = { fg = theme.ui.special, bold = true },
  --           TelescopePromptNormal = { bg = theme.ui.bg_p1 },
  --           TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
  --           TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
  --           TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
  --           TelescopePreviewNormal = { bg = theme.ui.bg_dim },
  --           TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },
  --
  --           -- Dark completion (popup) menu
  --           -- More uniform colors for the popup menu.
  --           Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },
  --           PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
  --           PmenuSbar = { bg = theme.ui.bg_m1 },
  --           PmenuThumb = { bg = theme.ui.bg_p2 },
  --         }
  --       end,
  --     })
  --     vim.cmd.colorscheme 'kanagawa'
  --   end,
  -- },

  -- https://github.com/navarasu/onedark.nvim
  -- Based on Atom's One Dark and Light theme. Additionally, it comes with 5 color variant styles
  -- {
  --   'navarasu/onedark.nvim',
  --   name = 'onedark',
  --   lazy = false,
  --   priority = 1000,
  --   opts = {
  --       style = 'warmer',
  --       code_style = {
  --           comments = 'italic', -- default: italic
  --       },
  --   },
  --   init = function()
  --     vim.cmd.colorscheme 'onedark'
  --   end,
  -- },
}
