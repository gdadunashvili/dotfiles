#!/bin/zsh

function switch_colors {
    # local readonly kittyDir="~/dotfiles/config/kitty"
    # local readonly kittyDir="~/.config/kitty"
    local readonly kittyDir="/Users/G.Dadunashvili/dotfiles/config/kitty"
    is_in_dark_mode=$(osascript -e 'tell app "System Events" to tell appearance preferences to return dark mode')
    if [ "${is_in_dark_mode}" = "true" ]; then
        kitten themes --reload-in=all Jet Brains Darcula
    else
        echo "Dark mode is off"
        kitten themes --reload-in=all CLRS
    fi
}

switch_colors

