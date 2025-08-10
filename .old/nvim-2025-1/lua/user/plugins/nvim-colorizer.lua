--
-- https://github.com/norcalli/nvim-colorizer.lua
-- Color highlighter

return {
  'norcalli/nvim-colorizer.lua',
  keys = {
    { '<leader>tv', '<cmd>ColorizerToggle<cr>', desc = 'Colorizer' },
  },
  cmd = {
    'ColorizerAttachToBuffer',
    'ColorizerDetachFromBuffer',
    'ColorizerReloadAllBuffers',
    'ColorizerToggle',
  },
  opts = {},
}
