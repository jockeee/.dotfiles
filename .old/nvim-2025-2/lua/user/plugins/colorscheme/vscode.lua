--
-- https://github.com/Mofiqul/vscode.nvim
-- nvim color scheme inspired by Dark+ and Light+ theme in Visual Studio Code

return {
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
      vim.g.colorscheme = 'vscode' -- lazy.lua and lualine.lua

      vim.cmd.highlight '@comment guifg=#818181'
      vim.cmd.highlight 'MsgArea guifg=#b1b1b1 guibg=#1f1f1f'
      vim.cmd.highlight 'ColorColumn guibg=#1b1b29' -- column limit
      vim.cmd.highlight 'StatusLine guifg=#b1b1b1 guibg=#353535 '
      vim.cmd.highlight 'TabLine guibg=#1f1f1f' -- tab not selected
      vim.cmd.highlight 'TabLineSel guibg=#1f1f1f' -- tab selected
      vim.cmd.highlight 'TabLineFill guibg=#1f1f1f' -- tabline row
      vim.cmd.highlight '@string.special.url term=none cterm=none'

      -- vim.cmd.highlight '@lsp.type.property.lua guifg=#9cdcfe' -- variable color
      -- vim.cmd.highlight '@property.lua guifg=#9cdcfe' -- variable color
      -- vim.cmd.highlight '@property guifg=#7cb0cb' -- darker+ variable color
      -- vim.cmd.highlight '@property guifg=#8cc6e4' -- darker variable color
      -- vim.cmd.highlight '@property guifg=#9cdcfe'-- variable color
      -- vim.cmd.highlight '@property guifg=#a5dffe' -- lighter variable color
      -- vim.cmd.highlight '@property guifg=#afe3fe' -- lighter+ variable color
      -- vim.cmd.highlight '@property guifg=#b9e6fe' -- lighter++ variable color
    end,
  },

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
}
