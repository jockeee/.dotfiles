--
-- echasnovski/mini.nvim

-- Library of 40+ independent Lua modules improving overall Neovim (version 0.8 and higher) experience with minimal effort

return {
  'echasnovski/mini.nvim',
  lazy = false,
  version = false,
  config = function()
    require('mini.ai').setup {
      n_lines = 500, -- number of lines within which textobject is searched
    }

    require('mini.icons').setup()

    -- require('mini.statusline').setup()
  end,
}
