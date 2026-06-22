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

-- jinja
vim.filetype.add {
  extension = {
    j2 = 'jinja',
  },
}

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
    vim.opt_local.textwidth = 80 -- gq

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

-- Detect yaml.ansible / yaml.cloudinit from *.yml / *.yaml files.

-- Play-level keys + the inventory-var prefix that mark a file as Ansible.
local ansible_patterns = {
  '^%s*hosts:',
  '^%s*tasks:',
  '^%s*roles:',
  '^%s*handlers:',
  '^%s*pre_tasks:',
  '^%s*post_tasks:',
  '^%s*become:',
  '^%s*gather_facts:',
  '^%s*import_playbook:',
  '^%s*ansible_', -- host_vars / group_vars connection vars
}

local function detect_yaml_variant(path, bufnr)
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, 40, false)
  local first = lines[1] or ''

  -- cloud-init: identified by its first-line directive.
  -- Checked first so a cloud-config never falls through to ansible.
  if
    first:match '^#cloud%-config%s*$'
    or first:match '^#cloud%-boothook%s*$'
    or first:match '^#cloud%-config%-archive%s*$'
    or first:match '^#include%-once%s*$'
    or first:match '^#include%s*$'
    or first:match '^#part%-handler%s*$'
  then
    return 'yaml.cloudinit'
  end

  -- Ansible heuristic 1: standard project layout.
  if
    path:match '/roles/'
    or path:match '/tasks/'
    or path:match '/handlers/'
    or path:match '/playbooks/'
    or path:match '/group_vars/'
    or path:match '/host_vars/'
  then
    return 'yaml.ansible'
  end

  -- Ansible heuristic 2: content inspection (first 40 lines).
  for _, line in ipairs(lines) do
    for _, pat in ipairs(ansible_patterns) do
      if line:match(pat) then
        return 'yaml.ansible'
      end
    end
  end

  return nil -- fall through to builtin yaml detection
end

vim.filetype.add {
  pattern = {
    ['.*%.ya?ml'] = detect_yaml_variant,
  },
}
