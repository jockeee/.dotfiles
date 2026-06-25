--
-- zbirenbaum/copilot.lua

vim.pack.add {
  'https://github.com/zbirenbaum/copilot.lua',
  -- 'https://github.com/copilotlsp-nvim/copilot-lsp', -- (optional) for NES (next edit suggestions)
}

require('copilot').setup {
  filetypes = {
    [''] = false, -- false = disabled for buffers with no filetype
    sh = function()
      -- disabled for .env files
      if string.match(vim.fs.basename(vim.api.nvim_buf_get_name(0)), '^%.env.*') then
        return false
      end
      return true
    end,
    text = false, -- false = disabled for text files
    yaml = true,
  },
  server_opts_overrides = {
    settings = {
      telemetry = {
        telemetryLevel = 'off',
      },
    },
  },
  panel = {
    enabled = false,
  },
  suggestion = {
    enabled = true, -- d: true
    auto_trigger = true, -- d: false
    hide_during_completion = false, -- d: true, hide suggestions during nvim completion
    -- debounce = 15, -- d: 15, debounce time in ms
    keymap = {
      accept = '<C-a>',
      accept_word = '<C-d>',
      accept_line = '<C-f>',
      next = '<C-j>',
      prev = '<C-k>',
      dismiss = '<C-x>',
      toggle_auto_trigger = '<C-c>',
    },
  },

  -- This function is called to determine if copilot should attach to the buffer or not.
  -- It is useful if you would like to go beyond the filetypes and have more control over when copilot should attach.
  -- You can also use it to attach to buflisted buffers by simply omitting that portion from the function.
  -- Since this happens before attaching to the buffer, it is good to prevent Copilot from reading sensitive files.
  --
  -- An example of this would be:
  --
  -- require('copilot').setup {
  --   should_attach = function(_, bufname)
  --     if string.match(bufname, 'env') then return false end
  --
  --     return true
  --   end,
  -- },
  should_attach = function(buf_id, bufname)
    if not vim.b[buf_id].copilot_enabled then
      return false
    end
    if not vim.bo[buf_id].buflisted then
      return false
    end
    if vim.bo[buf_id].buftype ~= '' then
      return false
    end

    local tmp_dirs = { '/tmp/', '/var/tmp/', '/dev/shm/', vim.fn.expand '~/.cache/' }
    local whitelist_dirs = { '/tmp/nvim.' .. vim.fn.expand '$USER' .. '/' }

    local sensitive_exts = {
      gpg = true,
      asc = true,
      key = true,
      pem = true,
      crt = true,
      csr = true,
      p12 = true,
      pfx = true,
      ca = true,
      fullchain = true,
      ovpn = true,
      env = true,
      bak = true,
      tmp = true,
      log = true,
    }

    local function starts_with_any(s, prefixes)
      for _, p in ipairs(prefixes) do
        if s:sub(1, #p) == p then
          return true
        end
      end
      return false
    end

    local ext = bufname:lower():match '%.([^.]+)$'
    if ext ~= nil and sensitive_exts[ext] ~= nil then
      return false
    end

    if starts_with_any(bufname, tmp_dirs) and not starts_with_any(bufname, whitelist_dirs) then
      return false
    end

    return true
  end,
}

vim.keymap.set('n', '<leader>c', function()
  vim.b.copilot_enabled = true -- only this buffer
  vim.cmd 'Copilot attach'
  vim.notify('Copilot enabled', vim.log.levels.INFO)
end, { desc = 'copilot' })
