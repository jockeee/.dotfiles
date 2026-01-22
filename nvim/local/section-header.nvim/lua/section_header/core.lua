local M = {}

-- Extract comment prefix from 'commentstring'
function M.get_comment_prefix()
  local cs = vim.bo.commentstring
  if not cs or cs == '' then
    return nil
  end

  local prefix = cs:match '^(.*)%%s'
  return prefix and vim.trim(prefix) or nil
end

-- Build a Lua pattern-safe character set from marker characters
local function make_marker_char_set(chars)
  local out = {}
  for _, c in ipairs(chars) do
    table.insert(out, vim.pesc(c))
  end
  return table.concat(out)
end

-- Debug helper
local function debug_log(config, msg)
  if config.debug then
    vim.notify('[section-header] ' .. msg, vim.log.levels.DEBUG)
  end
end

function M.fix_line(line, config)
  local width = config.width
  local fill = config.fill_char
  local min_len = config.marker_len or 3
  local marker = fill:rep(3)
  local chars = config.marker_chars or { fill }
  local char_class = make_marker_char_set(chars)

  local prefix = M.get_comment_prefix()
  if not prefix then
    debug_log(config, 'No comment prefix')
    return nil
  end

  -- Step 1: match header prefix
  local header_pat = '^%s*' .. vim.pesc(prefix) .. '%s*[' .. char_class .. ']+%s+'
  local marker_run = line:match(header_pat)

  if not marker_run then
    debug_log(config, 'Line does not look like header: ' .. line)
    return nil
  end

  -- Step 2: verify marker length
  local actual = marker_run:match('[' .. char_class .. ']+')
  if not actual or #actual < min_len then
    debug_log(config, 'Marker too short: ' .. (actual or 'nil'))
    return nil
  end

  -- Step 3: normalize marker
  line = line:gsub('^(%s*' .. vim.pesc(prefix) .. ')%s*[' .. char_class .. ']+%s+', '%1 ' .. marker .. ' ')

  -- Step 4: remove trailing filler
  line = line:gsub('[' .. char_class .. ']+$', '')
  line = line:gsub('%s+$', '')

  -- Step 5: pad to width
  if width > 0 then
    line = line .. ' '
    local len = #line

    if len < width then
      line = line .. string.rep(fill, width - len)
    elseif len > width then
      line = line:sub(1, width)
    end
  end

  debug_log(config, 'Normalized header')

  return line
end

return M
