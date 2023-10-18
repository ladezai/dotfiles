
local wezterm = require 'wezterm'

-- This function syncs the theme with the OS choice
function scheme_for_appearance(appearance)
    if appearance:find "Dark" then
        return "Catppuccin Mocha"
    else
        return "Catppuccin Latte"
    end
end

local config = {
    -- font 
    font = wezterm.font "Menlo",
    --font_antialias = "None",
    --dpi = 72,
    font_size = 13.5,
    -- bells off
    audible_bell = "Disabled",
    -- padding 
    window_padding = { left = 0, right = 0, top = 0, bottom = 0 }, 
    -- tabs
    hide_tab_bar_if_only_one_tab = false,
    enable_tab_bar = false,
    use_fancy_tab_bar = false,
    -- color scheme
    color_scheme = scheme_for_appearance(wezterm.gui.get_appearance()),
}


return config
