--
-- https://github.com/zbirenbaum/copilot.lua
-- Lua replacement for copilot.vim
--
-- https://github.com/zbirenbaum/copilot.lua#setup-and-configuration

return {
  'zbirenbaum/copilot.lua',
  cmd = 'Copilot',
  event = 'InsertEnter',
  opts = {
    suggestion = {
      auto_trigger = true,
      keymap = {
        accept = '<C-a>',
        accept_word = '<C-d>',
        accept_line = '<C-f>',
        prev = '[[',
        next = ']]',
        dismiss = '<C-q>',
      },
    },
  },
}
