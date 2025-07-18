--
-- numToStr/Comment.nvim

-- https://github.com/numToStr/Comment.nvim#configuration-optional

-- Normal mode
--    gcc                 Toggles the current line using linewise comment
--    gbc                 Toggles the current line using blockwise comment
--    [count]gcc          Toggles the number of line given as a prefix-count using linewise
--    [count]gbc          Toggles the number of line given as a prefix-count using blockwise
--    gc[count]{motion}   (Op-pending) Toggles the region using linewise comment
--    gb[count]{motion}   (Op-pending) Toggles the region using blockwise comment-
--    gco                 Insert comment to the next line and enters INSERT mode
--    gcO                 Insert comment to the previous line and enters INSERT mode
--    gcA                 Insert comment to end of the current line and enters INSERT mode
--
-- Visual mode
--    gc      toggle line comment
--    gb      toggle block comment
--
-- Examples, linewise
--    gcw     Toggle from the current cursor position to the next word
--    gc$     Toggle from the current cursor position to the end of line
--    gc}     Toggle until the next blank line
--    gc5j    Toggle 5 lines after the current cursor position
--    gc8k    Toggle 8 lines before the current cursor position
--    gcip    Toggle inside of paragraph
--    gca}    Toggle around curly brackets
--
-- Examples, blockwise
--    gb2}    Toggle until the 2 next blank line
--    gbaf    Toggle comment around a function (w/ LSP/treesitter support)
--    gbac    Toggle comment around a class (w/ LSP/treesitter support)

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
