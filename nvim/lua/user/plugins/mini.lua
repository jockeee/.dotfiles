--
-- https://github.com/echasnovski/mini.nvim
-- Library of 40+ independent Lua modules improving overall Neovim (version 0.8 and higher) experience with minimal effort

return {
  'echasnovski/mini.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  version = '*', -- * stable, false = main, for the latest features
  config = function()
    -- a/i textobjects
    -- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-ai.md
    -- Better Around/Inside textobjects
    -- Extend and create a/i textobjects
    --
    -- Examples:
    --    va)  - [V]isually select [A]round [)]paren
    --    yinq - [Y]ank [I]nside [N]ext [']quote
    --    ci'  - [C]hange [I]nside [']quote
    require('mini.ai').setup { n_lines = 500 }

    -- Bracketed
    -- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-bracketed.md
    -- Go forward/backward with square brackets
    --
    -- Examples:
    --    [B [b ]b ]B   buffer
    --    [C [c ]c ]C   comment
    --    [D [d ]d ]D   diagnostics
    --    [T [t ]t ]T   treesitter node and parents
    --
    require('mini.bracketed').setup()

    -- Surround
    -- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-surround.md
    --
    -- Examples:
    --    sa    add surrounding
    --    sd    delete surround
    --    sf    find surrounding (to the right)
    --    sF    find surrounding (to the left)
    --    sh    highlight surrounding
    --    sr    replace surrounding
    require('mini.surround').setup()
  end,
}
