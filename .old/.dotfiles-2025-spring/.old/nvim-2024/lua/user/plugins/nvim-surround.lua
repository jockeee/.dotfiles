--
-- https://github.com/kylechui/nvim-surround
-- Add/change/delete surrounding delimiter pairs with ease.
--
-- :h nvim-surround.usage
-- :h nvim-surround.configuration
--
-- add surround:    ys{motion}{char}
-- del surround:    ds{char}
-- change surround: cs{target}{replacement}
--
-- Examples:
--   ysiw) - [y]ank [s]urround [i]nner [w]ord [)]paren
--   cs'"  - [c]hange [s]urround ['] to ["]
--   ds]   - [d]elete [s]urround []
--
-- old text                    command         new text
-- -----------------------------------------------------------------------------
-- surr*ound_words             ysiw)           (surround_words)
-- *make strings               ys$"            "make strings"
-- [delete ar*ound me!]        ds]             delete around me!
-- remove <b>HTML t*ags</b>    dst             remove HTML tags
-- 'change quot*es'            cs'"            "change quotes"
-- <b>or tag* types</b>        csth1<CR>       <h1>or tag types</h1>
-- delete(functi*on calls)     dsf             function calls

return {
  'kylechui/nvim-surround',
  version = '*', -- * stable; `main` branch for the latest features
  event = { 'BufReadPre', 'BufNewFile' },
  config = true,
}
