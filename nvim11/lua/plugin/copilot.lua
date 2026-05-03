--
-- zbirenbaum/copilot.lua

-- Github Copilot for vim and nvim
-- Lua replacement for copilot.vim

---@type LazySpec
return {
  'zbirenbaum/copilot.lua',
  -- event = { 'BufReadPre', 'BufNewFile' },
  event = { 'InsertEnter' },
  cmd = 'Copilot',
  opts = {
    filetypes = {
      [''] = false, -- disable for buffers with no filetype
      sh = function()
        -- disable copilot for .env files
        if string.match(vim.fs.basename(vim.api.nvim_buf_get_name(0)), '^%.env.*') then
          return false
        end
        return true
      end,
      text = false, -- disable copilot for text files
      yaml = true,
      ['yaml.ansible'] = true,
    },
    server_opts_overrides = {
      settings = {
        telemetry = {
          telemetryLevel = 'off',
        },
      },
    },
    panel = {
      enabled = false,
    },
    suggestion = {
      enabled = true, -- d: true
      auto_trigger = true, -- d: false
      hide_during_completion = false, -- d: true, hide suggestions during nvim completion
      debounce = 75, -- d: 75, debounce time in ms
      keymap = {
        accept = '<C-a>',
        accept_word = '<C-d>',
        accept_line = '<C-f>',
        next = '<C-j>',
        prev = '<C-k>',
        dismiss = '<C-x>',
      },
    },
  },
}
