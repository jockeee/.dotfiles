--
-- wezterm

local wezterm = require 'wezterm' --[[@as Wezterm]]
local act = wezterm.action
local mux = wezterm.mux

local utils = require 'utils'

local color_bg = '#1f1f1f'
local color_fg_active = '#b1b1b1'
local color_fg_hover = '#909090'
local color_fg_inactive = '#7c7d83'

wezterm.GLOBAL = wezterm.GLOBAL or {}
wezterm.GLOBAL.default_workspaces = wezterm.GLOBAL.default_workspaces
  or {
    q = { name = 'ws1', cwd = wezterm.home_dir },
    w = { name = 'dot', cwd = wezterm.home_dir .. '/.dotfiles' },
    e = { name = 'vim', cwd = wezterm.home_dir .. '/.dotfiles/nvim' },
    r = { name = 'ws4', cwd = wezterm.home_dir },
    f = { name = 'ws5', cwd = wezterm.home_dir },
    t = { name = 'pass', cwd = wezterm.home_dir .. '/.password-store' },
  }

-- Prepend lua/ subfolder to Lua module search path (require behaves like in nvim)
-- local wezterm_config_path = os.getenv 'WEZTERM_CONFIG_DIR' or os.getenv 'XDG_CONFIG_HOME' .. '/wezterm'
-- package.path = wezterm_config_path .. '/lua/?.lua;' .. wezterm_config_path .. '/lua/?/init.lua;' .. package.path

--- Events

-- wezterm.on('gui-startup', function()
--   local existing_workspaces = mux.get_workspace_names()
--
--   for _, ws in pairs(wezterm.GLOBAL.default_workspaces) do
--     if not utils.workspace_exists(existing_workspaces, ws.name) then mux.spawn_window {
--       workspace = ws.name,
--       cwd = ws.cwd,
--     } end
--   end
--
--   mux.set_active_workspace 'home'
-- end)

wezterm.on('format-tab-title', function(tab)
  local title = utils.tab_title(tab)

  local zoomed = ''
  if tab.active_pane.is_zoomed then
    zoomed = ' '
  end

  return ' ' .. zoomed .. title .. ' '
end)

wezterm.on('update-status', function(window, _)
  local formatted = ''
  local text = ' ' .. mux.get_active_workspace() .. ' '

  if window:leader_is_active() then
    formatted = wezterm.format {
      { Foreground = { Color = color_fg_active } },
      { Background = { Color = color_bg } },
      { Text = text },
    }
  else
    formatted = wezterm.format {
      { Foreground = { Color = color_fg_inactive } },
      { Background = { Color = color_bg } },
      { Text = text },
    }
  end

  window:set_left_status(formatted)
end)

wezterm.on('copy-mode-yank', function(window, pane)
  window:perform_action(act.CopyTo 'ClipboardAndPrimarySelection', pane)
  window:perform_action(act.ClearSelection, pane)
end)

--- Config

local config = {}
if wezterm.config_builder then
  -- Improved warning messages for configuration errors
  -- http://wezterm.org/config/lua/wezterm/config_builder.html
  config = wezterm.config_builder() --[[@as Config]]
end

-- config.unix_domains = {
--   {
--     name = 'unix',
--   },
-- }
-- config.default_gui_startup_args = { 'connect', 'unix' }

config = {
  automatically_reload_config = true,
  default_workspace = 'ws1',
  scrollback_lines = 3500,

  -- Visual
  enable_tab_bar = true,
  tab_bar_at_bottom = true,
  use_fancy_tab_bar = false,
  hide_tab_bar_if_only_one_tab = false,
  window_decorations = 'NONE',
  window_padding = {
    left = 0, -- d: 8
    right = 0, -- d: 8
    top = 8, -- d: 8
    bottom = 0, -- d: 8
  },

  -- Font
  warn_about_missing_glyphs = false,
  font_size = 12,
  line_height = 1.05,
  -- harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }, -- disable ligatures

  -- Colors
  color_scheme = 'Catppuccin Mocha',
  background = {
    {
      source = {
        Color = color_bg,
      },
      width = '100%',
      height = '100%',
    },
  },
  -- Dimming of inactive panes
  inactive_pane_hsb = {
    saturation = 1.0, -- 1.0 = keep as-is
    brightness = 1.0, -- 1.0 = keep as-is
  },
  colors = {
    tab_bar = {
      background = color_bg,
      active_tab = {
        bg_color = color_bg,
        fg_color = color_fg_active,
        intensity = 'Bold', -- default: Normal - Half, Normal, Bold
      },
      inactive_tab = {
        bg_color = color_bg,
        fg_color = color_fg_inactive,
      },
      -- inactive_tab_hover = {
      --   bg_color = color_bg,
      --   fg_color = color_fg_hover,
      -- },
      new_tab = {
        bg_color = color_bg,
        fg_color = color_bg, -- "hidden"
      },
      new_tab_hover = {
        bg_color = color_bg,
        fg_color = color_fg_hover,
      },
    },
  },
}

--- Keymaps

-- disable_default_key_bindings = true, -- d: false

-- leader
config.leader = {
  key = 's',
  mods = 'CTRL',
  timeout_milliseconds = 10000, -- default: 1000
}

config.keys = {
  -- Send C-s
  { key = 's', mods = 'LEADER|CTRL', action = act.SendKey { key = 's', mods = 'CTRL' } },

  -- Send C-l
  { key = 'l', mods = 'LEADER|CTRL', action = act.SendKey { key = 'l', mods = 'CTRL' } },

  -- Send M-t, Transpose (swap) current and previous word
  { key = 't', mods = 'LEADER|ALT', action = act.SendKey { key = 't', mods = 'ALT' } },

  {
    key = 'p',
    mods = 'LEADER|CTRL',
    action = act.ShowLauncherArgs {
      flags = 'FUZZY|TABS|LAUNCH_MENU_ITEMS|DOMAINS|KEY_ASSIGNMENTS|WORKSPACES|COMMANDS',
      fuzzy_help_text = ': ',
    },
  },

  {
    key = 'Escape',
    mods = 'LEADER',
    action = wezterm.action.ClearSelection,
  },

  -- Tabs (windows)
  { key = 'c', mods = 'LEADER', action = act.SpawnTab 'CurrentPaneDomain' },
  { key = 'l', mods = 'LEADER', action = act.ActivateLastTab },
  { key = 'n', mods = 'LEADER', action = act.ActivateTabRelative(1) },
  { key = 'p', mods = 'LEADER', action = act.ActivateTabRelative(-1) },

  -- Panes (splits)
  { key = '%', mods = 'LEADER|SHIFT', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } }, -- left to right, split along horizontal line
  { key = '"', mods = 'LEADER|SHIFT', action = act.SplitVertical { domain = 'CurrentPaneDomain' } }, -- top to bottom, split along vertical line
  { key = 'z', mods = 'LEADER', action = act.TogglePaneZoomState },

  -- Pane, kill fg process
  {
    key = 'K',
    mods = 'LEADER',
    action = wezterm.action_callback(function(_, pane)
      local process_info = pane:get_foreground_process_info()

      if process_info then
        local pid = process_info.pid
        os.execute('kill -9 ' .. pid)
      end
    end),
  },

  -- Pane, close
  --  https://wezterm.org/config/lua/config/skip_close_confirmation_for_processes_named.html
  { key = 'X', mods = 'LEADER', action = act.CloseCurrentPane { confirm = true } },

  -- Pane, "dev" split, create
  {
    key = '@',
    mods = 'LEADER|SHIFT',
    action = act.SplitPane {
      direction = 'Down',
      size = { Percent = 10 },
    },
  },

  -- Pane, "dev" split, hide
  {
    key = 'h',
    mods = 'LEADER',
    action = act.Multiple {
      act.ActivatePaneDirection 'Up',
      act.TogglePaneZoomState,
    },
  },

  -- Copy mode
  { key = 'PageUp', mods = 'NONE', action = act.ActivateCopyMode },
  { key = 'k', mods = 'LEADER', action = act.ActivateCopyMode },
  { key = 'C', mods = 'LEADER', action = act.ClearSelection },

  -- Quick select
  { key = 'f', mods = 'LEADER', action = act.QuickSelect },
  { key = 'w', mods = 'LEADER', action = act.QuickSelectArgs { patterns = { '^\\s+(\\S+)' } } }, -- Match: indented words

  -- Search
  --  https://wezterm.org/config/lua/keyassignment/Search.html
  {
    key = '/',
    mods = 'LEADER',
    action = act.Search { CaseInSensitiveString = '' },
  },
}

--- Quick select patterns

-- Extends wezterm's quick select functionality
config.quick_select_patterns = {
  '(\\S+)$', -- Match: non-whitespace characters at the end of a line
  '^\\s+(\\S.*)$', -- Match: lines that begin with indent and have non-whitespace characters after it.
  '^❯\\s+(\\S.*)$', -- Match: lines that start with `❯ `
  [["([^"]+)"]], -- Match: strings inside double quotes
  [['([^']+)']], -- Match: strings inside single quotes
}

--- Hyperlinks

-- config.hyperlink_rules = {} -- disable hyperlinks
-- config.hyperlink_rules = wezterm.default_hyperlink_rules()
--
-- Make `username/project` paths clickable, this implies paths like the following are for github:
--   "nvim-treesitter/nvim-treesitter", wezterm/wezterm, "wezterm/wezterm.git"
-- As long as a full url hyperlink regex exists above this it should not match a full url to
-- github or gitlab / bitbucket (i.e. https://gitlab.com/user/project.git is still a whole clickable url)
-- table.insert(config.hyperlink_rules, {
--   regex = [[["]?([\w\d]{1}[-\w\d]+)(/){1}([-\w\d\.]+)["]?]],
--   format = 'https://github.com/$1/$3',
-- })

--- Plugins

-- local workspace_switcher = wezterm.plugin.require 'https://github.com/MLFlexer/smart_workspace_switcher.wezterm'
local workspace_switcher = require 'lua.smart_workspace_switcher'
-- config.default_workspace = '~'
workspace_switcher.apply_to_config(config)

local smart_splits = wezterm.plugin.require 'https://github.com/mrjones2014/smart-splits.nvim'
smart_splits.apply_to_config(config, {
  -- Use separate direction keys for move vs. resize
  direction_keys = {
    move = { 'h', 'j', 'k', 'l' },
    resize = { 'LeftArrow', 'DownArrow', 'UpArrow', 'RightArrow' },
  },
  -- modifier keys to combine with direction_keys
  modifiers = {
    move = 'CTRL',
    resize = 'META',
  },
  log_level = 'info', -- info, warn, error
})

-- Local environment
local local_config = wezterm.home_dir .. '/.local/wezterm.lua'

local f, load_err = loadfile(local_config)

if f then
  _G.config = config

  local ok, run_err = pcall(f)
  if not ok then
    wezterm.log_error(run_err)
  end
elseif load_err and not load_err:match 'No such file' then
  wezterm.log_error(load_err)
end

-- Workspace keymaps
for key, ws in pairs(wezterm.GLOBAL.default_workspaces) do
  table.insert(config.keys, {
    key = key,
    mods = 'META',
    action = wezterm.action_callback(function()
      utils.switch_to_workspace_or_create(ws.name, ws.cwd)
    end),
  })
end

return config
