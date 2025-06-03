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
    enabled = function()
      -- Disable Copilot if filetype is empty
      if vim.bo.filetype == '' then return false end
      -- Disable Copilot for certain file patterns
      local disabled_patterns = { '^%.env.*', '%.key$', '%.fullchain$' }
      local filename = vim.fs.basename(vim.api.nvim_buf_get_name(0))
      for _, pattern in ipairs(disabled_patterns) do
        if string.match(filename, pattern) then return false end
      end
      return true
    end,
    filetypes = {
      sh = function()
        -- Disable Copilot for .env files
        if string.match(vim.fs.basename(vim.api.nvim_buf_get_name(0)), '^%.env.*') then return false end
        return true
      end,
      text = false, -- Disable Copilot for text files
    },
    server_opts_overrides = {
      settings = {
        telemetry = {
          telemetryLevel = 'off',
        },
      },
    },
    suggestion = {
      enabled = true,
      auto_trigger = true,
      hide_during_completion = false, -- hide suggestions during nvim completion
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
