#!/bin/zsh

function switch_colors {
    # local readonly kittyDir="~/dotfiles/config/kitty"
    # local readonly kittyDir="~/.config/kitty"
    local readonly kittyDir="/Users/G.Dadunashvili/dotfiles/config/kitty"
    is_in_dark_mode=$(osascript -e 'tell app "System Events" to tell appearance preferences to return dark mode')
    if [ "${is_in_dark_mode}" = "true" ]; then
        # kitten themes --reload-in=all Jet Brains Darcula
        cp ${kittyDir}/JetBrains_Darcula.conf  ${kittyDir}/current-theme.conf
    else
        echo "Dark mode is off"
        # kitten themes --reload-in=all CLRS
        cp ${kittyDir}/CLRS.conf ${kittyDir}/current-theme.conf
    fi
    kitty @ set-colors -a ${kittyDir}/current-theme.conf
    # kitten themes --reload-in=all 
    # source ${kittyDir}/kitty.conf
}

# say "Theme switcher is running"
switch_colors

