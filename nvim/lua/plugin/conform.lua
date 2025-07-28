--
-- stevearc/conform.nvim

---@type LazySpec
return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>df',
      function()
        require('conform').format { async = true, lsp_format = 'fallback' }
      end,
      mode = '',
      desc = 'Format buffer',
    },
  },
  opts = {
    notify_on_error = true,
    format_on_save = {
      timeout_ms = 500,
      lsp_format = 'fallback',
    },
    formatters_by_ft = {
      css = { 'prettierd', 'prettier', stop_after_first = true },
      html = { 'prettierd', 'prettier', stop_after_first = true },
      javascript = { 'prettierd', 'prettier', stop_after_first = true },
      lua = { 'stylua' },
      typescript = { 'prettierd', 'prettier', stop_after_first = true },

      -- bash = { 'shfmt' }, -- lsp runs formatter
      -- fish = { 'fish_indent' }, -- lsp runs formatter
      -- sh = { 'shfmt' }, -- lsp runs formatter
      -- json = { 'jq' }, -- lsp runs formatter
      -- python = { 'ruff' }, -- lsp runs ruff by default?

      -- Conform can also run multiple formatters sequentially
      -- python = { "isort", "black" },
      --
      -- You can use 'stop_after_first' to run the first available formatter from the list
      -- javascript = { "prettierd", "prettier", stop_after_first = true },
    },
  },
}
