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
      desc = 'Format buffer',
    },
  },
  opts = {
    notify_on_error = true,
    format_on_save = function(bufnr)
      -- Disable "format_on_save lsp_fallback" for languages that don't have a well standardized coding style.
      -- You can add additional languages here or re-enable it for the disabled ones.
      local disable_filetypes = { c = true, cpp = true }
      return {
        timeout_ms = 2000,
        lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
      }
    end,
    formatters_by_ft = { -- Specify formatters by filetype
      -- Run multiple formatters sequentially
      -- python = { 'isort', 'black' },
      -- Run *until* a formatter is found
      -- html = { 'prettierd', 'prettier', stop_after_first = true },
      bash = { 'shfmt' },
      fish = { 'fish_indent' },
      lua = { 'stylua' },
      html = { 'prettierd', 'prettier', stop_after_first = true },
      javascript = { 'prettierd', 'prettier', stop_after_first = true },
      php = { 'inteliphense' },
      python = { 'isort', 'black' },
      go = { 'gofumpt', 'goimports-reviser' },
    },
    formatters_by_ext = { -- Specify formatters by file extension
      ['tmpl'] = { 'prettierd', 'prettier', stop_after_first = true },
      -- ["py"] = { "isort", "black" },
      -- ["js"] = { 'prettierd', 'prettier', stop_after_first = true },
      -- ["ts"] = { 'prettierd', 'prettier', stop_after_first = true },
    },
  },
}
