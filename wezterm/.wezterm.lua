-- These are the basic's for using wezterm.
-- Mux is the mutliplexes for windows etc inside of the terminal
-- Action is to perform actions on the terminal
local wezterm = require 'wezterm'
local mux = wezterm.mux
local act = wezterm.action

-- These are vars to put things in later (i dont use em all yet)
local config = {}
local keys = {}
local mouse_bindings = {}
local launch_menu = {}

-- This is for newer wezterm vertions to use the config builder
if wezterm.config_builder then
    config = wezterm.config_builder()
end

-- Default config settings
-- These are the default config settins needed to use Wezterm
-- Just add this and return config and that's all the basics you need

-- Color scheme, Wezterm has 100s of them you can see here:
-- https://wezfurlong.org/wezterm/colorschemes/index.html
config.color_scheme = 'Hardcore (Gogh)'
-- This is my chosen font, we will get into installing fonts on windows later
config.font = wezterm.font('Hack Nerd Font')
config.font_size = 11
config.launch_menu = launch_menu
-- makes my cursor blink
config.default_cursor_style = 'SteadyBlock'
config.cursor_thickness = "4px"
config.disable_default_key_bindings = true
-- tabs
config.use_fancy_tab_bar = false
-- this adds the ability to use ctrl+v to paste the system clipboard
config.keys = { { key = 'v', mods = 'CTRL', action = act.PasteFrom 'Clipboard' }, }
config.mouse_bindings = mouse_bindings

-- There are mouse binding to mimc Windows Terminal and let you copy
-- To copy just highlight something and right click. Simple
mouse_bindings = {
    {
        event = { Down = { streak = 3, button = 'Left' } },
        action = wezterm.action.SelectTextAtMouseCursor 'SemanticZone',
        mods = 'NONE',
    },
    {
        event = { Down = { streak = 1, button = "Right" } },
        mods = "NONE",
        action = wezterm.action_callback(function(window, pane)
            local has_selection = window:get_selection_text_for_pane(pane) ~= ""
            if has_selection then
                window:perform_action(act.CopyTo("ClipboardAndPrimarySelection"), pane)
                window:perform_action(act.ClearSelection, pane)
            else
                window:perform_action(act({ PasteFrom = "Clipboard" }), pane)
            end
        end),
    },
}

-- This is used to make my foreground (text, etc) brighter than my background
config.foreground_text_hsb = {
    hue = 1.0,
    saturation = 1.2,
    brightness = 1.5,
}

-- This is used to set an image as my background
config.background = {
    {
        source = { File = { path = 'C:/Users/STATION OF GAMERS/Pictures/Wallpapers/terminal.png', speed = 0.2 } },
        opacity = 1,
        width = "100%",
        hsb = { brightness = 0.1 },
    }
}

config.window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
}

-- IMPORTANT: Sets WSL2 UBUNTU-22.04 as the defualt when opening Wezterm
config.default_domain = 'WSL:Ubuntu-22.04'

return config
