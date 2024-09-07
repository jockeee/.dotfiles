--
-- https://github.com/tpope/vim-dadbod
-- Modern database interface for Vim
--
-- https://github.com/kristijanhusak/vim-dadbod-ui
-- Simple UI for vim-dadbod
--
-- https://github.com/kristijanhusak/vim-dadbod-completion
-- Database autocompletion powered by vim-dadbod

return {
  'kristijanhusak/vim-dadbod-ui',
  dependencies = {
    { 'tpope/vim-dadbod', lazy = true },
    { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true },
  },
  keys = {
    { '<leader>s', '<cmd>DBUI<cr>', desc = 'SQL: DBUI' },
  },
  cmd = {
    'DBUI',
    'DBUIToggle',
    'DBUIAddConnection',
    'DBUIFindBuffer',
  },
  init = function()
    vim.g.db_ui_use_nerd_fonts = 1
    vim.g.db_ui_winwidth = 50 -- default: 40
  end,
}
