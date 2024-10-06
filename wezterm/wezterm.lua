local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.color_scheme = "Sonokai (Gogh)"
config.window_background_opacity = 0.97
config.font_size = 13
config.use_fancy_tab_bar = false
config.audible_bell = "Disabled"

return config
