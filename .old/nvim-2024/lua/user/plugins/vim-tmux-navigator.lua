--
-- https://github.com/christoomey/vim-tmux-navigator
-- Seamless navigation between tmux panes and vim splits
--
-- C-hjkl\ keymaps that works with both tmux and nvim panes

return {
  'christoomey/vim-tmux-navigator',
  keys = { -- Lazy-load on key mapping
    { '<c-h>', '<cmd><C-U>TmuxNavigateLeft<cr>' },
    { '<c-j>', '<cmd><C-U>TmuxNavigateDown<cr>' },
    { '<c-k>', '<cmd><C-U>TmuxNavigateUp<cr>' },
    { '<c-l>', '<cmd><C-U>TmuxNavigateRight<cr>' },
    { '<c-\\>', '<cmd><C-U>TmuxNavigatePrevious<cr>' },
  },
}
