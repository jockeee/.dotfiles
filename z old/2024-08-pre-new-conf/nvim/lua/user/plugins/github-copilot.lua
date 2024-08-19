--
-- https://github.com/github/copilot.vim
-- Neovim plugin for GitHub Copilot

-- :help copilot
-- :help copilot-maps

return {
  'github/copilot.vim',
  config = function()
    vim.g.copilot_no_tab_map = true

    vim.keymap.set('i', '<C-F>', '<Plug>(copilot-accept-line)') -- accept line
    vim.keymap.set('i', '<C-N>', '<Plug>(copilot-accept-word)') -- accept word
    vim.keymap.set('i', '<C-G>', 'copilot#Accept("\\<CR>")', { -- accept suggestion
      expr = true,
      replace_keycodes = false,
    })
  end,
}
