--
-- kylechui/nvim-surround

-- Add/change/delete surrounding delimiter pairs with ease.
--
--  Visual mode
--    S{char}        Surround selection with {char}
--
--  :h nvim-surround.more-mappings
--
-- The three "core" operations of add/delete/change can be done with the keymaps
--
--    add       ys{motion}{char}
--    delete    ds{char}
--    change    cs{target}{replacement}
--
--    * = cursor position (in examples)
--
--
--    Old text                    Command         New text
--    ------------------------------------------------------------------------------
--    surr*ound_words             ysiw)           (surround_words)
--    *make strings               ys$"            "make strings"
--    [delete ar*ound me!]        ds]             delete around me!
--    remove <b>HTML t*ags</b>    dst             remove HTML tags
--    'change quot*es'            cs'"            "change quotes"
--    <b>or tag* types</b>        csth1<CR>       <h1>or tag types</h1>
--    delete(functi*on calls)     dsf             function calls
--
-- Usage
--  https://github.com/kylechui/nvim-surround/blob/main/doc/nvim-surround.txt
--
-- Default configuration
--  https://github.com/kylechui/nvim-surround/blob/main/lua/nvim-surround/config.lua

return {
  'kylechui/nvim-surround',
  -- tag = '*', -- Use '*' for stability; omit to use `main` branch for the latest features
  event = { 'BufReadPre', 'BufNewFile' },
  opts = {},
}
