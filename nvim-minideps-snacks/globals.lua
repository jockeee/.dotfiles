--
-- globals.lua

local fn, g, opt = vim.fn, vim.g, vim.opt

-- disable providers
-- :healthcheck providers
g.loaded_node_provider = 0
g.loaded_perl_provider = 0
g.loaded_python3_provider = 0
g.loaded_ruby_provider = 0

g.mapleader = ' '
g.maplocalleader = ' '

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

