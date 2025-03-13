local wezterm = require('wezterm')

local config = wezterm.config_builder()

local function is_dark()
  local path = os.getenv("HOME").."/.is_dark"
  local file = io.open(path, "r")
  if file~=nil then file:close()
    return true
  end
    return false
end
config.default_prog = { "zsh" }

-- Appearence
if is_dark() then
  config.color_scheme = 'Batman'
else
  config.color_scheme = 'Spring'
end

config.font = wezterm.font 'JetBrains Mono'
config.font_size = 10
config.text_blink_rate = 0

config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false
config.window_decorations = 'RESIZE'

config.window_padding = { left = 0, right = 0, top = 0, bottom = 0, }


return config




