local core = require 'section_header.core'

local M = {}

M.config = {
  width = 79,
  fill_char = '-',
  marker_chars = { '-', '=' },
  marker_len = 3,
  debug = false,
}

function M.setup(opts)
  opts = opts or {}
  for k, v in pairs(opts) do
    M.config[k] = v
  end
  -- local merged = vim.tbl_deep_extend('force', M.config, opts)
  -- for k, v in pairs(merged) do
  --   M.config[k] = v
  -- end
end

-- format a single line
function M.format_line(line, force)
  local fixed = core.fix_line(line, M.config)
  if not fixed then
    return nil
  end

  if not force and fixed == line then
    return nil
  end

  return fixed
end

-- format whole buffer
function M.format_buffer(force)
  local buf = 0
  local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)

  local changed = 0
  local out = {}

  for i, line in ipairs(lines) do
    local fixed = M.format_line(line, force)
    if fixed then
      out[i] = fixed
      changed = changed + 1
    else
      out[i] = line
    end
  end

  if changed > 0 then
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, out)
  end

  return changed
end

-- user command: current line
function M.fix_current_line(opts)
  opts = opts or {}
  local silent = opts.silent or M.config.silent

  local line = vim.api.nvim_get_current_line()
  local fixed = M.format_line(line, opts.force)

  if not fixed then
    if not silent then
      vim.notify('No change', vim.log.levels.INFO)
    end
    return
  end

  vim.api.nvim_set_current_line(fixed)

  if not silent then
    vim.notify('Section header updated', vim.log.levels.INFO)
  end
end

-- user command: whole buffer
function M.fix_all(opts)
  opts = opts or {}
  local silent = opts.silent or M.config.silent

  local count = M.format_buffer(opts.force)

  if not silent then
    if count == 0 then
      vim.notify('No section headers changed', vim.log.levels.INFO)
    else
      vim.notify('Updated ' .. count .. ' section header(s)', vim.log.levels.INFO)
    end
  end
end

return M
