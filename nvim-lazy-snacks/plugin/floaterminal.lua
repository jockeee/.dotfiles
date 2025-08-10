--
-- Floaterminal
-- Floating toggle-able terminal | TJ
-- https://www.youtube.com/watch?v=5PIiKDES_wc

local width_ratio = 0.88
local height_ratio = 0.74

local state = {
  floating = {
    buf = -1,
    win = -1,
    mode = nil,
  },
  mode = nil,
}

local function create_floating_window(opts)
  opts = opts or {}
  local width = opts.width or math.floor(vim.o.columns * width_ratio)
  local height = opts.height or math.floor(vim.o.lines * height_ratio)

  -- Calculate the position to center the window
  local col = math.floor((vim.o.columns - width) / 2)
  local row = math.floor((vim.o.lines - height) / 2)

  -- Create a buffer
  local buf = nil
  if vim.api.nvim_buf_is_valid(opts.buf) then
    buf = opts.buf
  else
    buf = vim.api.nvim_create_buf(false, true) -- No file, scratch buffer
  end

  -- Define window configuration
  local win_config = {
    relative = 'editor',
    width = width,
    height = height,
    col = col,
    row = row,
    style = 'minimal', -- No borders or extra UI elements
    border = 'rounded',
  }

  -- Create the floating window
  local win = vim.api.nvim_open_win(buf, true, win_config)

  return { buf = buf, win = win }
end

local toggle_terminal = function()
  if not vim.api.nvim_win_is_valid(state.floating.win) then
    -- New floating window
    state.floating = create_floating_window { buf = state.floating.buf }
    if vim.bo[state.floating.buf].buftype ~= 'terminal' then
      -- New terminal
      vim.cmd.terminal()
      vim.cmd 'startinsert'
    else
      -- Restore mode
      if state.mode == 't' then
        vim.cmd 'startinsert'
      elseif state.mode == 'v' or state.mode == 'V' or state.mode == '^V' then
        vim.cmd 'normal! gv'
      end
    end
  else
    -- Hide window
    state.mode = vim.api.nvim_get_mode().mode
    vim.api.nvim_win_hide(state.floating.win)
  end
end

-- Create a floating window with default dimensions
vim.api.nvim_create_user_command('Floaterminal', toggle_terminal, {})
