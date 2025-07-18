--
-- numToStr/Comment.nvim

-- https://github.com/numToStr/Comment.nvim#configuration-optional

--
-- Keymaps
--  Normal, visual mode
--    gcc   line comment
--    gb    block comment
--
--  Operator-pending mode
--    gc    toggle line comment
--    gb    toggle block comment

---@type LazySpec
return {
  'numToStr/Comment.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  opts = {
    toggler = {
      block = 'gb', -- d: gbc
    },
  },
}
