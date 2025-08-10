--
-- colorscheme.lua
--
-- :Telescope colorscheme

return {
  -- https://github.com/catppuccin/nvim
  -- Soothing pastel theme for (Neo)vim
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    lazy = false,
    priority = 1000,
    opts = {
      styles = {
        comments = {}, -- Default: "italics"
      },
      -- color_overrides = {
      --   mocha = {
      --     base = '#1f1f1f', -- background color
      --   },
      -- },
      custom_highlights = function()
        return {
          MsgArea = { fg = '#b1b1b1', bg = '#1f1f1f' },
          Comment = { fg = '#818181' },
          ['@string.special.url'] = { style = {} },
        }
      end,
    },
    init = function()
      vim.cmd.colorscheme 'catppuccin'
      -- vim.cmd.highlight 'MsgArea guifg=#b1b1b1 guibg=#1f1f1f'
      -- vim.cmd.highlight '@comment guifg=#787878'
    end,
  },

  -- https://github.com/Mofiqul/vscode.nvim
  -- nvim/Vim color scheme inspired by Dark+ and Light+ theme in Visual Studio Code
  -- {
  --   'Mofiqul/vscode.nvim',
  --   name = 'vscode',
  --   lazy = false,
  --   priority = 1000,
  --   init = function()
  --     require('vscode').setup {
  --       italic_comments = false,
  --
  --       -- Override colors (see ./lua/vscode/colors.lua)
  --       color_overrides = {
  --         vscGreen = '#787878',
  --         vscPopupHighlightGray = '#434343',
  --       },
  --     }
  --     vim.cmd.colorscheme 'vscode'
  --     vim.cmd.highlight 'StatusLine guifg=#b1b1b1 guibg=#353535 '
  --     vim.cmd.highlight 'MsgArea guifg=#b1b1b1'
  --     -- vim.cmd.highlight '@lsp.type.property.lua guifg=#9cdcfe' -- variable color
  --     -- vim.cmd.highlight '@property.lua guifg=#9cdcfe' -- variable color
  --     -- vim.cmd.highlight '@property guifg=#7cb0cb' -- darker+ variable color
  --     -- vim.cmd.highlight '@property guifg=#8cc6e4' -- darker variable color
  --     -- vim.cmd.highlight '@property guifg=#9cdcfe'-- variable color
  --     -- vim.cmd.highlight '@property guifg=#a5dffe' -- lighter variable color
  --     vim.cmd.highlight '@property guifg=#afe3fe' -- lighter+ variable color
  --     -- vim.cmd.highlight '@property guifg=#b9e6fe' -- lighter++ variable color
  --     vim.cmd.highlight '@string.special.url.html term=none cterm=none'
  --   end,
  -- },

  -- vscNone = 'NONE',
  -- vscFront = '#D4D4D4',
  -- vscBack = '#1F1F1F',
  --
  -- vscTabCurrent = '#1F1F1F',
  -- vscTabOther = '#2D2D2D',
  -- vscTabOutside = '#252526',
  --
  -- vscLeftDark = '#252526',
  -- vscLeftMid = '#373737',
  -- vscLeftLight = '#636369',
  --
  -- vscPopupFront = '#BBBBBB',
  -- vscPopupBack = '#272727',
  -- vscPopupHighlightBlue = '#004b72',
  -- vscPopupHighlightGray = '#343B41',
  --
  -- vscSplitLight = '#898989',
  -- vscSplitDark = '#444444',
  -- vscSplitThumb = '#424242',
  --
  -- vscCursorDarkDark = '#222222',
  -- vscCursorDark = '#51504F',
  -- vscCursorLight = '#AEAFAD',
  -- vscSelection = '#264F78',
  -- vscLineNumber = '#5A5A5A',
  --
  -- vscDiffRedDark = '#4B1818',
  -- vscDiffRedLight = '#6F1313',
  -- vscDiffRedLightLight = '#FB0101',
  -- vscDiffGreenDark = '#373D29',
  -- vscDiffGreenLight = '#4B5632',
  -- vscSearchCurrent = '#515c6a',
  -- vscSearch = '#613315',
  --
  -- vscGitAdded = '#81b88b',
  -- vscGitModified = '#e2c08d',
  -- vscGitDeleted = '#c74e39',
  -- vscGitRenamed = '#73c991',
  -- vscGitUntracked = '#73c991',
  -- vscGitIgnored = '#8c8c8c',
  -- vscGitStageModified = '#e2c08d',
  -- vscGitStageDeleted = '#c74e39',
  -- vscGitConflicting = '#e4676b',
  -- vscGitSubmodule = '#8db9e2',
  --
  -- vscContext = '#404040',
  -- vscContextCurrent = '#707070',
  --
  -- vscFoldBackground = '#202d39',
  --
  -- -- Syntax colors
  -- vscGray = '#808080',
  -- vscViolet = '#646695',
  -- vscBlue = '#569CD6',
  -- vscAccentBlue = '#4FC1FF',
  -- vscDarkBlue = '#223E55',
  -- vscMediumBlue = '#18a2fe',
  -- vscDisabledBlue = '#729DB3',
  -- vscLightBlue = '#9CDCFE', -- default for: variable
  -- vscGreen = '#6A9955',
  -- vscBlueGreen = '#4EC9B0',
  -- vscLightGreen = '#B5CEA8',
  -- vscRed = '#F44747',
  -- vscOrange = '#CE9178',
  -- vscLightRed = '#D16969',
  -- vscYellowOrange = '#D7BA7D',
  -- vscYellow = '#DCDCAA',
  -- vscDarkYellow = '#FFD602',
  -- vscPink = '#C586C0',
  --
  -- -- Low contrast with default background
  -- vscDimHighlight = '#51504F',

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