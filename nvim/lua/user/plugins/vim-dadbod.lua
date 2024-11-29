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
    { 'tpope/vim-dadbod' },
    { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' } },
  },
  keys = {
    { '<leader>b', '<cmd>DBUIToggle<cr>', desc = 'SQL: DBUI' },
  },
  cmd = {
    'DBUI',
    'DBUIToggle',
    'DBUIAddConnection',
    'DBUIFindBuffer',
  },
  config = function()
    -- :help vim-dadbod-ui-settings
    vim.g.db_ui_show_help = 0 -- default: 1, show/hide `Press ? for help` from the DBUI
    vim.g.db_ui_winwidth = 40 -- default: 40
    vim.g.db_ui_use_nerd_fonts = 1

    -- https://github.com/kristijanhusak/vim-dadbod-ui#save-location
    vim.g.db_ui_save_location = vim.fn.stdpath 'data' .. '/db_ui' -- Default: ~/.local/share/db_ui
  end,
}
