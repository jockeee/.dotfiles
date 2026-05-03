--
-- echasnovski/mini.nvim

-- Library of 40+ independent Lua modules improving overall Neovim (version 0.8 and higher) experience with minimal effort

---@type LazySpec
return {
  'echasnovski/mini.nvim',
  lazy = false,
  version = false,
  config = function()
    local ai = require 'mini.ai'
    ai.setup {
      n_lines = 500, -- number of lines within which textobject is searched
    }

    local icons = require 'mini.icons'
    icons.setup()
  end,
}
