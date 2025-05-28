--
-- globals.lua

-- Set <space> as the leader key
-- Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Disable Netrw (nvim-tree)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.g.colorscheme = 'nordic'

-- MyTabline
function MyTabline()
  local tabline = ''
  for tabnr = 1, vim.fn.tabpagenr '$' do
    local current = (tabnr == vim.fn.tabpagenr()) and '%#TabLineSel#' or '%#TabLine#'
    tabline = tabline .. current .. ' Tab ' .. tabnr .. ' '
  end
  tabline = tabline .. '%#TabLineFill#'
  return tabline
end
