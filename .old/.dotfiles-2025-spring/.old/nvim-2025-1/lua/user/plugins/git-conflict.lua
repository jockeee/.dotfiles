--
-- https://github.com/akinsho/git-conflict.nvim
-- Visualise and resolve merge conflicts
--
-- Default keymaps
--  co — choose ours
--  ct — choose theirs
--  cb — choose both
--  c0 — choose none
--  ]x — move to previous conflict
--  [x — move to next conflict

return {
  'akinsho/git-conflict.nvim',
  version = '*',
  event = 'VimEnter',
  opt = {},
}
