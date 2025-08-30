--
-- lua/user/filetypes.lua

-- lua
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'lua',
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.tabstop = 2
  end,
})

-- markdown
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'markdown',
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.tabstop = 2

    -- Insert blockquote prefix on Enter in insert mode
    vim.keymap.set('i', '<CR>', function()
      local line = vim.api.nvim_get_current_line()
      local prefix = line:match '^%s*>%s*'
      if prefix then
        return '\n' .. prefix
      else
        return '\n'
      end
    end, { buffer = true, expr = true })

    -- Insert blockquote prefix on o/O in normal mode
    vim.keymap.set('n', 'o', function()
      local line = vim.api.nvim_get_current_line()
      local prefix = line:match '^%s*>%s*'
      if prefix then
        return 'o' .. prefix
      else
        return 'o'
      end
    end, { buffer = true, expr = true })

    vim.keymap.set('n', 'O', function()
      local line = vim.api.nvim_get_current_line()
      local prefix = line:match '^%s*>%s*'
      if prefix then
        return 'O' .. prefix
      else
        return 'O'
      end
    end, { buffer = true, expr = true })
  end,
})

-- yaml.ansible
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  group = vim.api.nvim_create_augroup('DetectAnsibleYaml', { clear = true }),
  pattern = { '*.yml', '*.yaml' },
  callback = function()
    local path = vim.api.nvim_buf_get_name(0)

    -- Heuristic #1: Directory path hint
    if path:match '/roles/' or path:match '/tasks/' or path:match '/playbooks/' then
      vim.bo.filetype = 'yaml.ansible'
      return
    end

    -- Heuristic #2: Content-based hint (first 20 lines)
    local lines = vim.api.nvim_buf_get_lines(0, 0, 20, false)
    for _, line in ipairs(lines) do
      if
        line:match '^%s*hosts:'
        or line:match '^%s*tasks:'
        or line:match '^%s*roles:'
        or line:match '^%s*vars:'
        or line:match '^%s*- name:'
        or line:match '^%s*become:'
      then
        vim.bo.filetype = 'yaml.ansible'
        return
      end
    end

    -- No Ansible markers found: leave filetype as plain "yaml"
  end,
})

-- web
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'css', 'html', 'javascript', 'typescript' },
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.tabstop = 2

    -- /usr/share/nvim/runtime/ftplugin/css.vim sets iskeyword to include '-'
    vim.opt_local.iskeyword:remove '-'
  end,
})
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'php',
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.tabstop = 4
  end,
})
