--
-- https://github.com/mfussenegger/nvim-lint
-- An asynchronous linter plugin for Neovim complementary to the built-in Language Server Protocol support.
--
-- https://github.com/mfussenegger/nvim-lint#available-linters

return {
  'mfussenegger/nvim-lint',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local lint = require 'lint'

    lint.linters_by_ft = {
      -- If shellcheck is installed, bash-language-server will automatically call
      html = { 'htmlhint' },
      -- css = { 'stylelint' },
    }

    vim.api.nvim_create_autocmd({ 'BufWritePost', 'BufReadPost', 'InsertLeave' }, {
      callback = function()
        lint.try_lint()
      end,
    })
  end,
}
