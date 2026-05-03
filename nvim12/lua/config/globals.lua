--
-- config/globals.lua

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

function ConfigTabline()
  local tabline = ''
  for tabnr = 1, vim.fn.tabpagenr '$' do
    local current = (tabnr == vim.fn.tabpagenr()) and '%#TabLineSel#' or '%#TabLine#'
    tabline = tabline .. current .. ' Tab ' .. tabnr .. ' '
  end
  tabline = tabline .. '%#TabLineFill#'
  return tabline
end
