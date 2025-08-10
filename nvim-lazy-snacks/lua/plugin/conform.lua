--
-- https://github.com/stevearc/conform.nvim
-- Lightweight yet powerful formatter plugin for nvim
--
-- :ConformInfo

return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  opts = {
    notify_on_error = true, -- Default: true
    format_on_save = function(bufnr)
      -- Disable "format_on_save lsp_fallback" for languages that don't have a well standardized coding style.
      -- You can add additional languages here or re-enable it for the disabled ones.
      local disable_filetypes = {
        c = true,
        cpp = true,
        text = true,
      }
      if disable_filetypes[vim.bo[bufnr].filetype] then
        return nil
      else
        return {
          timeout_ms = 2000,
          lsp_format = 'fallback',
        }
      end
    end,
    formatters_by_ft = {
      lua = { 'stylua' },
      bash = { 'shfmt' },
    },
  },
  setup = function(_, opts)
    local conform = require 'conform'
    conform.setup(opts)

    vim.keymap.set({ 'n', 'v' }, '<leader>df', function()
      require('conform').format { async = true, lsp_format = 'fallback' }
    end)
  end,
}
