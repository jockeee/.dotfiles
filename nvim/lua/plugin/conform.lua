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
        -- timeout_ms: No effect if async formatting
        require('conform').format { async = true, lsp_format = 'fallback' }
      end,
      mode = '',
      desc = 'Format buffer',
    },
  },
  opts = {
    notify_on_error = true, -- d: true
    format_on_save = {
      lsp_format = 'fallback',
      timeout_ms = 500,
    },
    formatters_by_ft = {
      lua = { 'stylua' },

      css = { 'prettierd', 'prettier', stop_after_first = true },
      html = { 'prettierd', 'prettier', stop_after_first = true },
      javascript = { 'prettierd', 'prettier', stop_after_first = true },
      typescript = { 'prettierd', 'prettier', stop_after_first = true },
      sql = { 'sqlfluff' },
      mysql = { 'sqlfluff' },
      pgsql = { 'sqlfluff' },

      -- bash = { 'shfmt' }, -- lsp runs formatter
      -- fish = { 'fish_indent' }, -- lsp runs formatter
      -- sh = { 'shfmt' }, -- lsp runs formatter
      -- json = { 'jq' }, -- lsp runs formatter
      -- python = { 'ruff' }, -- lsp runs formatter
    },
  },
}
