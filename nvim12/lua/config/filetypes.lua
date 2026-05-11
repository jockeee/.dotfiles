--
-- config/filetypes.lua

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

-- json
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'json',
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
