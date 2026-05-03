-- Lualine colors
--
-- Default colors
--    https://github.com/Mofiqul/vscode.nvim/blob/main/lua/vscode/colors.lua
--
-- vscode theme colors
--    theme = 'vscode_colors', -- default: auto

local colors = {
  bg = '#2c2c2c',
  fg_light = '#b1b1b1',
  fg_dark = '#353535',

  black = '#b1b1b1', -- fg
  white = '#b1b1b1', -- fg
  gray = '#b1b1b1', -- fg / 'location' bg
  red = '#353535', -- bg
  green = '#353535', -- bg
  blue = '#353535', -- bg
  yellow = '#353535', -- bg
  darkgray = '#353535', -- bg
  lightgray = '#353535', -- bg
  inactivegray = '#353535', -- bg
}

return {
  normal = {
    a = { bg = colors.bg, fg = colors.fg_light },
    b = { bg = colors.bg, fg = colors.fg_light },
    c = { bg = colors.bg, fg = colors.fg_light },
  },
  insert = {
    a = { bg = colors.bg, fg = colors.fg_light },
    b = { bg = colors.bg, fg = colors.fg_light },
    c = { bg = colors.bg, fg = colors.fg_light },
  },
  visual = {
    a = { bg = colors.bg, fg = colors.fg_light },
    b = { bg = colors.bg, fg = colors.fg_light },
    c = { bg = colors.bg, fg = colors.fg_light },
  },
  replace = {
    a = { bg = colors.bg, fg = colors.fg_light },
    b = { bg = colors.bg, fg = colors.fg_light },
    c = { bg = colors.bg, fg = colors.fg_light },
  },
  command = {
    a = { bg = colors.bg, fg = colors.fg_light },
    b = { bg = colors.bg, fg = colors.fg_light },
    c = { bg = colors.bg, fg = colors.fg_light },
  },
  inactive = {
    a = { bg = colors.bg, fg = colors.fg_light },
    b = { bg = colors.bg, fg = colors.fg_light },
    c = { bg = colors.bg, fg = colors.fg_light },
  },
}
