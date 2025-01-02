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
    filetypes = {
      sh = function()
        if string.match(vim.fs.basename(vim.api.nvim_buf_get_name(0)), '^%.env.*') then
          -- Disable Copilot for .env files
          return false
        end
        return true
      end,
      text = false, -- Disable Copilot for text files
    },
    suggestion = {
      enabled = true,
      auto_trigger = true,
      hide_during_completion = false, -- Hide during nvim-cmp completion
      debounce = 75,
      keymap = {
        accept = '<C-a>',
        accept_word = '<C-d>',
        accept_line = '<C-f>',
        prev = '[[',
        next = ']]',
        dismiss = '<C-x>',
      },
    },
  },
}
