--
-- https://github.com/stevearc/conform.nvim
-- Lightweight yet powerful formatter plugin for Neovim
--
-- :ConformInfo

return {
  'stevearc/conform.nvim',
  lazy = false,
  keys = {
    {
      '<leader>df',
      function()
        require('conform').format { async = true, lsp_fallback = true }
      end,
      mode = '',
      desc = 'Conform: Format buffer',
    },
  },
  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
      -- Disable "format_on_save lsp_fallback" for languages that don't have a well standardized coding style.
      -- You can add additional languages here or re-enable it for the disabled ones.
      local disable_filetypes = { text = true, c = true, cpp = true, sql = true }
      return {
        timeout_ms = 2000,
        lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
      }
    end,
    formatters = {
      ['goimports-reviser'] = {
        prepend_args = { '-rm-unused' },
      },
    },
    formatters_by_ft = { -- Specify formatters by filetype
      -- Run multiple formatters sequentially
      --  python = { 'isort', 'black' },
      -- Run *until* a formatter is found
      --  html = { 'prettierd', 'prettier', stop_after_first = true },
      bash = { 'shfmt' },
      css = { 'prettier' },
      fish = { 'fish_indent' },
      go = { 'goimports-reviser', 'injected' }, -- gopls runs gofumpt
      tmpl = { 'prettier' },
      gotmpl = { 'prettier' },
      html = { 'prettier' },
      javascript = { 'prettier' },
      lua = { 'stylua' },
      php = { 'inteliphense' },
      python = { 'isort', 'black' },
      json = { 'jq' },
      sql = { 'sqlfluff' },
      mysql = { 'sqlfluff' },
      pgsql = { 'sqlfluff' },
      -- ['*'] = { 'injected' },
    },
    formatters_by_ext = { -- Specify formatters by file extension
      -- ["py"] = { "isort", "black" },
      -- ["js"] = { 'prettierd', 'prettier', stop_after_first = true },
    },
  },
}
