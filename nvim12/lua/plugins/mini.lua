--
-- nvim-mini/mini.nvim

vim.pack.add({
  'https://github.com/nvim-mini/mini.nvim',
})

---
-- icons
---

local icons = require 'mini.icons'
icons.setup()

---
--- pick
---

local pick = require 'mini.pick'
pick.setup()

vim.keymap.set('n', '<Leader><Space>', pick.builtin.files, { desc = 'Find: files' })


---
--- sessions
---

local sessions = require('mini.sessions')

sessions.setup({
  autoread  = false,
  autowrite = false,
  directory = vim.fn.stdpath('data') .. '/mini-sessions',
  file      = '',
})

local suppressed_dirs = {
  '/',
  '/tmp',
  '/dev/shm',
  vim.fn.expand('~'),
  vim.fn.expand('~/Downloads'),
}

local function is_suppressed()
  local cwd = vim.fn.getcwd()
  for _, dir in ipairs(suppressed_dirs) do
    if cwd == dir then return true end
  end
  return false
end

local function session_name()
  return vim.fn.getcwd():gsub('([^%w])', function(c)
    return string.format('%%%02X', string.byte(c))
  end) .. '.vim'
end

local function decode_session_name(name)
  return name:gsub('%%(%x%x)', function(hex)
    return string.char(tonumber(hex, 16))
  end):gsub('%.vim$', '')
end

local group = vim.api.nvim_create_augroup('MiniSessionsAuto', { clear = true })

vim.api.nvim_create_autocmd('VimEnter', {
  group    = group,
  nested   = true,
  once     = true,
  callback = function()
    if vim.fn.argc() == 0 and not is_suppressed() then
      local name = session_name()
      if sessions.detected[name] then
        sessions.read(name)
      end
    end
  end,
})

vim.api.nvim_create_autocmd('VimLeavePre', {
  group    = group,
  callback = function()
    if not is_suppressed() then
      sessions.write(session_name())
    end
  end,
})

vim.keymap.set('n', '<leader>fs', function()
  local items = vim.tbl_map(function(name)
    return {
      text = name:gsub('%%(%x%x)', function(hex)
        return string.char(tonumber(hex, 16))
      end):gsub('%.vim$', ''),
      name = name,  -- keep original for the read call
    }
  end, vim.tbl_keys(sessions.detected))

  require('mini.pick').start({
    source = {
      items = items,
      name  = 'Sessions',
      choose = function(item) sessions.read(item.name) end
    },
    mappings = {
      delete_session = {
        char     = '<C-d>',
        func     = function()
          local item = require('mini.pick').get_picker_matches().current
          if item then
            sessions.delete(item.name, { force = true })
            -- refresh the picker items
            require('mini.pick').set_picker_items(
              vim.tbl_map(function(name)
                return { text = decode_session_name(name), name = name }
              end, vim.tbl_keys(sessions.detected))
            )
          end
        end,
      },
    },
  })
end, { desc = 'Pick session' })


---
--- clue
---

local clue = require('mini.clue')
clue.setup({
  triggers = {
    -- Leader triggers
    { mode = { 'n', 'x' }, keys = '<Leader>' },

    -- `[` and `]` keys
    { mode = 'n', keys = '[' },
    { mode = 'n', keys = ']' },

    -- Built-in completion
    { mode = 'i', keys = '<C-x>' },

    -- `g` key
    { mode = { 'n', 'x' }, keys = 'g' },

    -- Marks
    { mode = { 'n', 'x' }, keys = "'" },
    -- { mode = { 'n', 'x' }, keys = '`' },

    -- Registers
    { mode = { 'n', 'x' }, keys = '"' },
    { mode = { 'i', 'c' }, keys = '<C-r>' },

    -- Window commands
    { mode = 'n', keys = '<C-w>' },

    -- `z` key
    { mode = { 'n', 'x' }, keys = 'z' },
  },

  clues = {
    -- Enhance this by adding descriptions for <Leader> mapping groups
    clue.gen_clues.square_brackets(),
    clue.gen_clues.builtin_completion(),
    clue.gen_clues.g(),
    clue.gen_clues.marks(),
    clue.gen_clues.registers(),
    clue.gen_clues.windows(),
    clue.gen_clues.z(),
  },
})
