--
-- nvim-mini/mini.nvim

vim.pack.add {
  'https://github.com/nvim-mini/mini.nvim',
}

---
-- icons

require('mini.icons').setup()

--
-- extra

-- require('mini.extra').setup()

--
-- completion

local completion = require 'mini.completion'
completion.setup()

---
--- sessions

require('mini.sessions').setup {
  autoread = false,
  autowrite = false,
  directory = vim.fn.stdpath 'data' .. '/mini-sessions',
  file = '',
}

local suppressed_dirs = {
  '/',
  '/tmp',
  '/dev/shm',
  vim.fn.expand '~',
  vim.fn.expand '~/Downloads',
}

local function is_suppressed()
  local cwd = vim.fn.getcwd()
  for _, dir in ipairs(suppressed_dirs) do
    if cwd == dir then
      return true
    end
  end
  return false
end

local function session_name()
  return vim.fn.getcwd():gsub('([^%w])', function(c)
    return string.format('%%%02X', string.byte(c))
  end) .. '.vim'
end

local function decode_session_name(name)
  return name
    :gsub('%%(%x%x)', function(hex)
      return string.char(tonumber(hex, 16))
    end)
    :gsub('%.vim$', '')
end

local group = vim.api.nvim_create_augroup('MiniSessionsAuto', { clear = true })

vim.api.nvim_create_autocmd('VimEnter', {
  group = group,
  nested = true,
  once = true,
  callback = function()
    if vim.fn.argc() == 0 and not is_suppressed() then
      local name = session_name()
      if MiniSessions.detected[name] then
        MiniSessions.read(name)
      end
    end
  end,
})

vim.api.nvim_create_autocmd('VimLeavePre', {
  group = group,
  callback = function()
    if not is_suppressed() then
      MiniSessions.write(session_name())
    end
  end,
})

vim.keymap.set('n', '<leader>fs', function()
  local items = vim.tbl_map(function(name)
    return {
      text = name
        :gsub('%%(%x%x)', function(hex)
          return string.char(tonumber(hex, 16))
        end)
        :gsub('%.vim$', ''),
      name = name, -- keep original for the read call
    }
  end, vim.tbl_keys(MiniSessions.detected))

  require('mini.pick').start {
    source = {
      items = items,
      name = 'Sessions',
      choose = function(item)
        MiniSessions.read(item.name)
      end,
    },
    mappings = {
      delete_session = {
        char = '<C-d>',
        func = function()
          local item = require('mini.pick').get_picker_matches().current
          if item then
            MiniSessions.delete(item.name, { force = true })
            -- refresh the picker items
            require('mini.pick').set_picker_items(vim.tbl_map(function(name)
              return { text = decode_session_name(name), name = name }
            end, vim.tbl_keys(MiniSessions.detected)))
          end
        end,
      },
    },
  }
end, { desc = 'Pick session' })

---
--- clue

local clue = require 'mini.clue'
clue.setup {
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
}

---
--- pick

require('mini.pick').setup()

-- pick files, with hidden files
MiniPick.registry.files = function(local_opts)
  local tool = (local_opts or {}).tool or 'rg'
  local commands = {
    fd = { 'fd', '--hidden', '--type', 'f', '--color', 'never' },
    rg = { 'rg', '--hidden', '--files', '--color', 'never' },
  }
  return MiniPick.builtin.cli({ command = commands[tool] }, { source = { name = string.format('Files (%s)', tool) } })
end

local function fetch_file(url, path)
  vim.notify('Fetching ' .. vim.fn.fnamemodify(path, ':t') .. '...')
  vim.fn.system { 'curl', '-s', '-L', url, '-o', path }
  if vim.v.shell_error ~= 0 then
    vim.notify('Failed to fetch ' .. url, vim.log.levels.ERROR)
    return false
  end
  return true
end

local function icons_data_dir()
  local dir = vim.fn.stdpath 'data' .. '/mini-pick-icons'
  vim.fn.mkdir(dir, 'p')
  return dir
end

local unicode_url = 'https://unicode.org/Public/UCD/latest/ucd/UnicodeData.txt'
local nerdfonts_url = 'https://github.com/ryanoasis/nerd-fonts/raw/refs/heads/master/glyphnames.json'

MiniPick.registry.icons_update = function()
  local dir = icons_data_dir()
  fetch_file(nerdfonts_url, dir .. '/nerdfonts.json')
  fetch_file(unicode_url, dir .. '/unicode.txt')
  vim.notify 'Icons data updated'
end

-- snacks.picker.icons variant, adds unicode chars
MiniPick.registry.icons = function()
  local dir = icons_data_dir()
  local nerdfonts_cache = dir .. '/nerdfonts.json'
  local unicode_cache = dir .. '/unicode.txt'

  if vim.fn.filereadable(nerdfonts_cache) == 0 then
    if not fetch_file(nerdfonts_url, nerdfonts_cache) then
      return
    end
  end
  if vim.fn.filereadable(unicode_cache) == 0 then
    if not fetch_file(unicode_url, unicode_cache) then
      return
    end
  end

  local items = {}

  -- Nerd fonts
  local fd = io.open(nerdfonts_cache, 'r')
  if fd then
    local data = vim.json.decode(fd:read '*a')
    fd:close()
    for name, info in pairs(data) do
      if name ~= 'METADATA' then
        table.insert(items, {
          text = string.format('  %s  %s  nerd', info.char, name),
          char = info.char,
        })
      end
    end
  end

  -- MiniIcons
  for _, category in ipairs { 'default', 'directory', 'extension', 'file', 'filetype', 'lsp', 'os' } do
    for _, name in ipairs(MiniIcons.list(category)) do
      local icon = MiniIcons.get(category, name)
      table.insert(items, {
        text = string.format('  %s  %s  %s  mini', icon, category, name),
        char = icon,
      })
    end
  end

  -- Unicode
  for line in io.lines(unicode_cache) do
    local cp, name = line:match '^([^;]+);([^;]+)'
    if cp and name then
      local char = vim.fn.nr2char(tonumber(cp, 16))
      table.insert(items, {
        text = string.format('  %s  %s  unicode', char, name),
        char = char,
      })
    end
  end

  MiniPick.start {
    source = {
      name = 'Icons',
      items = items,
      choose = function(item)
        vim.schedule(function()
          vim.api.nvim_put({ item.char }, 'c', true, true)
        end)
      end,
    },
  }
end

vim.keymap.set('n', '<Leader><Space>', MiniPick.registry.files, { desc = 'Find: files' })
-- vim.keymap.set('n', '<Leader><Space>', MiniPick.builtin.files, { desc = 'Find: files' })
vim.keymap.set('n', '<leader>fa', MiniPick.builtin.resume, { desc = 'resume' })
-- vim.keymap.set('n', '<leader>fd', MiniExtra.pickers.diagnostic, { desc = 'diagnostic' })
-- vim.keymap.set('n', '<leader>fe', MiniExtra.pickers.explorer, { desc = 'explorer' })
vim.keymap.set('n', '<leader>ff', MiniPick.builtin.grep_live, { desc = 'grep' })
-- vim.keymap.set('n', '<leader>fg', MiniExtra.pickers.git_hunks, { desc = 'git hunks' })
-- vim.keymap.set('n', '<leader>fh', MiniExtra.pickers.hipatterns, { desc = 'hipatterns' }) -- i.e. todos
vim.keymap.set('n', '<leader>fh', MiniPick.builtin.help, { desc = 'help' })
-- vim.keymap.set('n', '<leader>fk', MiniExtra.pickers.keymaps, { desc = 'keymaps' })
-- vim.keymap.set('n', '<leader>fl', MiniExtra.pickers.buf_lines, { desc = 'lines' })
vim.keymap.set('n', '<leader>fu', MiniPick.registry.icons, { desc = 'icons: unicode, nerdfonts, miniicons' })

--
-- hipatterns

-- require('mini.hipatterns').setup {
--   highlighters = {
--     hack = { pattern = '%f[%w]()HACK:()', group = 'MiniHipatternsHack' },
--     fixme = { pattern = '%f[%w]()FIXME:()', group = 'MiniHipatternsFixme' },
--     note = { pattern = '%f[%w]()NOTE:()', group = 'MiniHipatternsNote' },
--     todo = { pattern = '%f[%w]()TODO:()', group = 'MiniHipatternsTodo' },
--   },
-- }

-- vim.keymap.set('n', '<leader>fh', MiniExtra.pickers.hipatterns, { desc = 'hipatterns' })

--
-- hipatterns, miniextra

-- local hi_words = require('mini.extra').gen_highlighter.words
--
-- require('mini.hipatterns').setup {
--   highlighters = {
--     hack = hi_words({ 'HACK', 'Hack', 'hack' }, 'MiniHipatternsHack'),
--     fixme = hi_words({ 'FIXME', 'Fixme', 'fixme' }, 'MiniHipatternsFixme'),
--     note = hi_words({ 'NOTE', 'Note', 'note' }, 'MiniHipatternsNote'),
--     todo = hi_words({ 'TODO', 'Todo', 'todo' }, 'MiniHipatternsTodo'),
--   },
-- }

-- vim.keymap.set('n', '<leader>fh', MiniExtra.pickers.hipatterns, { desc = 'hipatterns' })
