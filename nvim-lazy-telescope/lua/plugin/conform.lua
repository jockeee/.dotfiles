--
-- https://github.com/stevearc/conform.nvim
-- Lightweight yet powerful formatter plugin for nvim
--
-- :ConformInfo

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
    notify_on_error = false,
    format_on_save = function(bufnr)
      -- Disable "format_on_save lsp_fallback" for languages that don't have a well standardized coding style.
      -- You can add additional languages here or re-enable it for the disabled ones.
      local disable_filetypes = { text = true, c = true, cpp = true }
      if disable_filetypes[vim.bo[bufnr].filetype] then
        return nil
      else
        return {
          timeout_ms = 2000,
          lsp_format = 'fallback',
        }
      end
    end,
    formatters = {
      ['goimports-reviser'] = {
        prepend_args = { '-rm-unused' },
      },
      html5_noselfclose = {
        command = 'sed',
        args = { [[s/ \/>/ >/g]] },
        stdin = true,
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
      hurl = { 'hurlfmt' },
      template = { 'prettier' },
      html = { 'prettier' },
      -- html = { 'prettier', 'html5_noselfclose' },
      javascript = { 'prettier' },
      lua = { 'stylua' },
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
