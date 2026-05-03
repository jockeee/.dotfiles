--
-- stevearc/conform.nvim

---@type LazySpec
return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>df', -- format buffer, async
      function()
        -- timeout_ms: No effect if async formatting
        require('conform').format { async = true, lsp_format = 'fallback' }
      end,
      mode = '',
      desc = 'Format buffer',
    },
    {
      '<leader>ds', -- stylelint --fix
      function()
        require('conform').format { async = true, lsp_format = 'none', formatters = { 'stylelint' } }
      end,
      mode = '',
      desc = 'stylelint --fix',
    },
  },
  opts = {
    notify_on_error = true, -- d: true
    format_on_save = {
      lsp_format = 'fallback',
      timeout_ms = 500,
    },
    formatters = {
      stylelint = {
        inherit = false, -- don't merge with builtin args
        command = 'stylelint',
        args = { '--fix', '$FILENAME' },
        -- Send file contents to stdin, read new contents from stdout (default true)
        -- When false, will create a temp file (will appear in "$FILENAME" args).
        -- The temp file is assumed to be modified in-place by the format command.
        stdin = false, -- create a temp file and expect in-place edits
        cwd = function(ctx)
          -- run stylelint from the nearest directory containing a config file
          return vim.fs.dirname(
            vim.fs.find({ '.stylelintrc', '.stylelintrc.json', 'stylelint.config.js', 'package.json' }, { upward = true, path = ctx.dirname })[1]
          )
        end,
      },
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
