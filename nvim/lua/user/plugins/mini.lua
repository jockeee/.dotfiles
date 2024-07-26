--
-- https://github.com/echasnovski/mini.nvim
-- Library of 40+ independent Lua modules improving overall Neovim (version 0.8 and higher) experience with minimal effort

return {
  'echasnovski/mini.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    -- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-ai.md
    -- Better Around/Inside textobjects
    -- Extend and create a/i textobjects
    --
    -- Examples:
    --  - va)  - [V]isually select [A]round [)]paren
    --  - yinq - [Y]ank [I]nside [N]ext [']quote
    --  - ci'  - [C]hange [I]nside [']quote
    require('mini.ai').setup { n_lines = 500 }

    -- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-bracketed.md
    -- Go forward/backward with square brackets
    --
    -- Examples:
    --  - [B [b ]b ]B   buffer
    --  - [C [c ]c ]C   comment
    --  - [D [d ]d ]D   diagnostics
    --  - [T [t ]t ]T   treesitter node and parents
    --
    require('mini.bracketed').setup()
  end,
}
