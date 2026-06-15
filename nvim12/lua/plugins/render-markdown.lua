--
-- MeanderingProgrammer/render-markdown.nvim

vim.pack.add {
  'https://github.com/MeanderingProgrammer/render-markdown.nvim',
}

-- vim.api.nvim_create_autocmd('ModeChanged', {
--   callback = function() vim.notify(vim.fn.mode(1), vim.log.levels.INFO) end,
-- })

require('render-markdown').setup {
  render_modes = { 'n', 'c', 't', 'i', 'v', 'V', '\22', 'no' }, -- d: n, c, t
  completions = { lsp = { enabled = true } },
  file_types = { 'markdown' },
  debounce = 10,

  -- Layer 1: natively-concealed source (###, link URLs, `code`) stays hidden
  -- in every mode except insert.
  win_options = {
    concealcursor = { rendered = 'nvc' }, -- n + visual + command; NOT i
  },

  -- Layer 2: the plugin's own glyphs stay rendered in every mode except insert.
  anti_conceal = {
    ignore = (function()
      local keep = { 'n', 'c', 't', 'v', 'V', '\22' } -- everything but 'i'
      return {
        head_icon = keep,
        head_background = keep,
        head_border = keep,
        code_language = keep,
        code_border = keep,
        code_background = keep,
        bullet = keep,
        check_icon = keep,
        check_scope = keep,
        dash = keep,
        quote = keep,
        callout = keep,
        link = keep,
        table_border = keep,
      }
    end)(),
  },

  heading = {
    -- backgrounds = { 'Normal', 'Normal', 'Normal', 'Normal', 'Normal', 'Normal' },
    -- border = true,
    icons = { '', '', '', '', '', '', '', '' },
    position = 'inline',
    width = 'block',
    -- min_width = 40,
    left_pad = 1,
    right_pad = 1,
  },

  code = {
    position = 'right',
    language_pad = 1,
    width = 'block',
    min_width = 80,
    border = 'thick', -- d: hide, none | thick | thin | hide
    highlight_language = 'RenderMarkdownLanguageFG', -- Highlight for language, overrides icon provider value.
    language_icon = false, -- d: true
    left_pad = 2,
    right_pad = 2,
  },
}

local function code_block_at_cursor(pos)
  local node = vim.treesitter.get_node(pos and { pos = { pos.line - 1, pos.column - 1 } } or nil)
  while node and node:type() ~= 'fenced_code_block' do
    node = node:parent()
  end
  return node
end

local function copy_code_block(pos)
  local block = code_block_at_cursor(pos)
  if not block then
    return vim.notify('Not in a code block', vim.log.levels.WARN)
  end
  local content
  for child in block:iter_children() do
    if child:type() == 'code_fence_content' then
      content = child
      break
    end
  end
  if not content then
    return vim.notify('Empty code block', vim.log.levels.WARN)
  end
  local text = vim.treesitter.get_node_text(content, 0):gsub('\n$', '')
  vim.fn.setreg('+', text)
  vim.notify 'Code block copied'
end

vim.keymap.set('n', 'yC', copy_code_block, { desc = 'yank: code block' })

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'markdown',
  callback = function(args)
    vim.keymap.set('n', '<2-LeftMouse>', function()
      local pos = vim.fn.getmousepos()
      if pos.line <= 0 then
        return
      end
      copy_code_block(pos)
    end, { buffer = args.buf, desc = 'yank: code block' })
  end,
})
