--
-- lua/user/globals.lua

-- disable providers
-- :healthcheck providers
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

User = {}
User.colorscheme = 'nordic'
function User.Tabline()
  local tabline = ''
  for tabnr = 1, vim.fn.tabpagenr '$' do
    local current = (tabnr == vim.fn.tabpagenr()) and '%#TabLineSel#' or '%#TabLine#'
    tabline = tabline .. current .. ' Tab ' .. tabnr .. ' '
  end
  tabline = tabline .. '%#TabLineFill#'
  return tabline
end
