--
-- https://github.com/zbirenbaum/copilot.lua
-- Lua replacement for copilot.vim, Github Copilot for vim and nvim
--
-- https://github.com/zbirenbaum/copilot.lua#setup-and-configuration

return {
  'zbirenbaum/copilot.lua',
  event = 'VimEnter',
  -- event = { 'BufReadPre', 'BufNewFile' },
  cmd = 'Copilot',
  opts = {
    filetypes = {
      sh = function()
        -- Disable Copilot for .env files
        if string.match(vim.fs.basename(vim.api.nvim_buf_get_name(0)), '^%.env.*') then return false end
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
        next = ']]',
        prev = '[[',
        dismiss = '<C-x>',
      },
    },
  },
}
