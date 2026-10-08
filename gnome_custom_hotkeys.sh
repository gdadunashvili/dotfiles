set_keybindings() {

    left="h"
    down="j"
    up="k"
    right="l"

    local KEYS_GNOME_WM=/org/gnome/desktop/wm/keybindings
    local KEYS_GNOME_SHELL=/org/gnome/shell/keybindings
    local KEYS_MUTTER=/org/gnome/mutter/keybindings
    local KEYS_MEDIA=/org/gnome/settings-daemon/plugins/media-keys
    local KEYS_MUTTER_WAYLAND_RESTORE=/org/gnome/mutter/wayland/keybindings/restore-shortcuts

    # Disable incompatible shortcuts
    # Restore the keyboard shortcuts: disable <Super>Escape
    dconf write ${KEYS_MUTTER_WAYLAND_RESTORE} "@as []"
    # Hide window: disable <Super>h
    dconf write ${KEYS_GNOME_WM}/minimize "@as ['<Super>comma']"
    # Open the application menu: disable <Super>m
    dconf write ${KEYS_GNOME_SHELL}/open-application-menu "@as []"
    # Toggle message tray: disable <Super>m
    dconf write ${KEYS_GNOME_SHELL}/toggle-message-tray "@as ['<Super>v']"
    # Show the activities overview: disable <Super>s
    dconf write ${KEYS_GNOME_SHELL}/toggle-overview "@as []"
    # Switch to workspace left: disable <Super>Left
    dconf write ${KEYS_GNOME_WM}/switch-to-workspace-left "@as []"
    # Switch to workspace right: disable <Super>Right
    dconf write ${KEYS_GNOME_WM}/switch-to-workspace-right "@as []"
    # Maximize window: disable <Super>Up
    dconf write ${KEYS_GNOME_WM}/maximize "@as []"
    # Restore window: disable <Super>Down
    dconf write ${KEYS_GNOME_WM}/unmaximize "@as []"
    # Move to monitor up: disable <Super><Shift>Up
    dconf write ${KEYS_GNOME_WM}/move-to-monitor-up "@as []"
    # Move to monitor down: disable <Super><Shift>Down
    dconf write ${KEYS_GNOME_WM}/move-to-monitor-down "@as []"

    # Super + direction keys, move window left and right monitors, or up and down workspaces
    # Move window one monitor to the left
    dconf write ${KEYS_GNOME_WM}/move-to-monitor-left "@as []"
    # Move window one workspace down
    dconf write ${KEYS_GNOME_WM}/move-to-workspace-down "@as []"
    # Move window one workspace up
    dconf write ${KEYS_GNOME_WM}/move-to-workspace-up "@as []"
    # Move window one monitor to the right
    dconf write ${KEYS_GNOME_WM}/move-to-monitor-right "@as []"

    # Super + Ctrl + direction keys, change workspaces, move focus between monitors
    # Move to workspace below
    dconf write ${KEYS_GNOME_WM}/switch-to-workspace-down "['<Primary><Super>Down','<Primary><Super>${down}']"
    # Move to workspace above
    dconf write ${KEYS_GNOME_WM}/switch-to-workspace-up "['<Primary><Super>Up','<Primary><Super>${up}']"

    # Disable tiling to left / right of screen
    dconf write ${KEYS_MUTTER}/toggle-tiled-left "@as []"
    dconf write ${KEYS_MUTTER}/toggle-tiled-right "@as []"

    # Toggle maximization state
    dconf write ${KEYS_GNOME_WM}/toggle-maximized "['<Super>m']"
    # Lock screen
    dconf write ${KEYS_MEDIA}/screensaver "['<Super>Escape']"
    # Home folder
    dconf write ${KEYS_MEDIA}/home "['<Super>f']"
    # Launch email client
    dconf write ${KEYS_MEDIA}/email "@as []"
    # Launch web browser
    dconf write ${KEYS_MEDIA}/www "['<Super>b']"
    # Launch terminal
    dconf write ${KEYS_MEDIA}/terminal "['<Super>t']"

    # Rotate Video Lock
    dconf write ${KEYS_MEDIA}/rotate-video-lock-static "@as []"

    # Close Window
    dconf write ${KEYS_GNOME_WM}/close "['<Super>q', '<Alt>F4']"
}


# gnome-extensions disable ubuntu-dock@ubuntu.com
dconf write /org/gnome/mutter/dynamic-workspaces false
dconf write /org/gnome/desktop/wm/preferences/num-workspaces 12
gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "[]"

dconf write /org/gnome/shell/keybindings/focus-active-notification "['<Super>n']"
dconf write /org/gnome/shell/keybindings/open-new-window-application-1 "@as []"
dconf write /org/gnome/shell/keybindings/open-new-window-application-2 "@as []"
dconf write /org/gnome/shell/keybindings/open-new-window-application-3 "@as []"
dconf write /org/gnome/shell/keybindings/open-new-window-application-4 "@as []"
dconf write /org/gnome/shell/keybindings/open-new-window-application-5 "@as []"
dconf write /org/gnome/shell/keybindings/open-new-window-application-6 "@as []"
dconf write /org/gnome/shell/keybindings/open-new-window-application-7 "@as []"
dconf write /org/gnome/shell/keybindings/open-new-window-application-8 "@as []"
dconf write /org/gnome/shell/keybindings/open-new-window-application-9 "@as []"
dconf write /org/gnome/shell/keybindings/screenshot "['<Shift>Print']"
dconf write /org/gnome/shell/keybindings/screenshot-window "['<Alt>Print']"
dconf write /org/gnome/shell/keybindings/shift-overview-down "['<Super><Alt>Down']"
dconf write /org/gnome/shell/keybindings/shift-overview-up "['<Super><Alt>Up']"
dconf write /org/gnome/shell/keybindings/show-screen-recording-ui "['<Ctrl><Shift><Alt>R']"
dconf write /org/gnome/shell/keybindings/show-screenshot-ui "['Print']"
dconf write /org/gnome/shell/keybindings/switch-to-application-1 "@as []"
dconf write /org/gnome/shell/keybindings/switch-to-application-2 "@as []"
dconf write /org/gnome/shell/keybindings/switch-to-application-3 "@as []"
dconf write /org/gnome/shell/keybindings/switch-to-application-4 "@as []"
dconf write /org/gnome/shell/keybindings/switch-to-application-5 "@as []"
dconf write /org/gnome/shell/keybindings/switch-to-application-6 "@as []"
dconf write /org/gnome/shell/keybindings/switch-to-application-7 "@as []"
dconf write /org/gnome/shell/keybindings/switch-to-application-8 "@as []"
dconf write /org/gnome/shell/keybindings/switch-to-application-9 "@as []"
dconf write /org/gnome/shell/keybindings/toggle-application-view "@as []"
dconf write /org/gnome/shell/keybindings/toggle-message-tray "['<Super>c']"
dconf write /org/gnome/shell/keybindings/toggle-overview "@as []"
dconf write /org/gnome/shell/keybindings/toggle-quick-settings "@as []"
dconf write /org/gnome/settings-daemon/plugins/media-keys/battery-status "@as []"
dconf write /org/gnome/settings-daemon/plugins/media-keys/battery-status-static "['XF86Battery']"
dconf write /org/gnome/settings-daemon/plugins/media-keys/calculator "@as []"
dconf write /org/gnome/settings-daemon/plugins/media-keys/calculator-static "['XF86Calculator']"
dconf write /org/gnome/settings-daemon/plugins/media-keys/control-center "@as []"
dconf write /org/gnome/settings-daemon/plugins/media-keys/control-center-static "['XF86Tools']"
dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings "@as []"
dconf write /org/gnome/settings-daemon/plugins/media-keys/decrease-text-size "@as []"
dconf write /org/gnome/settings-daemon/plugins/media-keys/eject "@as []"
dconf write /org/gnome/settings-daemon/plugins/media-keys/eject-static "['XF86Eject']"
dconf write /org/gnome/settings-daemon/plugins/media-keys/email-static "['XF86Mail']"
dconf write /org/gnome/settings-daemon/plugins/media-keys/help "['', '<Super>F1']"
dconf write /org/gnome/settings-daemon/plugins/media-keys/hibernate "@as []"
dconf write /org/gnome/settings-daemon/plugins/media-keys/hibernate-static "['XF86Suspend', 'XF86Hibernate']"
dconf write /org/gnome/settings-daemon/plugins/media-keys/home "@as []"
dconf write /org/gnome/settings-daemon/plugins/media-keys/home-static "['XF86Explorer']"
dconf write /org/gnome/settings-daemon/plugins/media-keys/increase-text-size "@as []"
dconf write /org/gnome/settings-daemon/plugins/media-keys/keyboard-brightness-down "@as []"
dconf write /org/gnome/settings-daemon/plugins/media-keys/keyboard-brightness-down-static "['XF86KbdBrightnessDown']"
dconf write /org/gnome/settings-daemon/plugins/media-keys/keyboard-brightness-toggle "@as []"
dconf write /org/gnome/settings-daemon/plugins/media-keys/keyboard-brightness-toggle-static "['XF86KbdLightOnOff']"
dconf write /org/gnome/settings-daemon/plugins/media-keys/keyboard-brightness-up "@as []"
dconf write /org/gnome/settings-daemon/plugins/media-keys/keyboard-brightness-up-static "['XF86KbdBrightnessUp']"
dconf write /org/gnome/settings-daemon/plugins/media-keys/logout "['<Control><Alt>Delete']"
dconf write /org/gnome/settings-daemon/plugins/media-keys/magnifier "['<Alt><Super>8']"
dconf write /org/gnome/settings-daemon/plugins/media-keys/magnifier-zoom-in "['<Alt><Super>equal']"
dconf write /org/gnome/settings-daemon/plugins/media-keys/magnifier-zoom-out "['<Alt><Super>minus']"
dconf write /org/gnome/settings-daemon/plugins/media-keys/media "['']"
dconf write /org/gnome/settings-daemon/plugins/media-keys/media-static "['XF86AudioMedia']"
dconf write /org/gnome/settings-daemon/plugins/media-keys/mic-mute "['']"
dconf write /org/gnome/settings-daemon/plugins/media-keys/mic-mute-static "['XF86AudioMicMute']"
dconf write /org/gnome/settings-daemon/plugins/media-keys/next "['']"
dconf write /org/gnome/settings-daemon/plugins/media-keys/next-static "['XF86AudioNext', '<Ctrl>XF86AudioNext']"
dconf write /org/gnome/settings-daemon/plugins/media-keys/on-screen-keyboard "['']"
dconf write /org/gnome/settings-daemon/plugins/media-keys/pause "['']"
dconf write /org/gnome/settings-daemon/plugins/media-keys/pause-static "['XF86AudioPause']"
dconf write /org/gnome/settings-daemon/plugins/media-keys/play "['']"
dconf write /org/gnome/settings-daemon/plugins/media-keys/play-static "['XF86AudioPlay', '<Ctrl>XF86AudioPlay']"
dconf write /org/gnome/settings-daemon/plugins/media-keys/playback-forward "['']"
dconf write /org/gnome/settings-daemon/plugins/media-keys/playback-forward-static "['XF86AudioForward']"
dconf write /org/gnome/settings-daemon/plugins/media-keys/playback-random "['']"
dconf write /org/gnome/settings-daemon/plugins/media-keys/playback-random-static "['XF86AudioRandomPlay']"
dconf write /org/gnome/settings-daemon/plugins/media-keys/playback-repeat "['']"
dconf write /org/gnome/settings-daemon/plugins/media-keys/playback-repeat-static "['XF86AudioRepeat']"
dconf write /org/gnome/settings-daemon/plugins/media-keys/playback-rewind "['']"
dconf write /org/gnome/settings-daemon/plugins/media-keys/playback-rewind-static "['XF86AudioRewind']"
dconf write /org/gnome/settings-daemon/plugins/media-keys/power "['']"
dconf write /org/gnome/settings-daemon/plugins/media-keys/power-static "['XF86PowerOff']"
dconf write /org/gnome/settings-daemon/plugins/media-keys/previous "['']"
dconf write /org/gnome/settings-daemon/plugins/media-keys/previous-static "['XF86AudioPrev', '<Ctrl>XF86AudioPrev']"
dconf write /org/gnome/settings-daemon/plugins/media-keys/rfkill "['']"
dconf write /org/gnome/settings-daemon/plugins/media-keys/rfkill-bluetooth "['']"
dconf write /org/gnome/settings-daemon/plugins/media-keys/rfkill-bluetooth-static "['XF86Bluetooth']"
dconf write /org/gnome/settings-daemon/plugins/media-keys/rfkill-static "['XF86WLAN', 'XF86UWB', 'XF86RFKill']"
dconf write /org/gnome/settings-daemon/plugins/media-keys/rotate-video-lock "['']"
dconf write /org/gnome/settings-daemon/plugins/media-keys/rotate-video-lock-static "['']"
dconf write /org/gnome/settings-daemon/plugins/media-keys/screen-brightness-cycle "['']"
dconf write /org/gnome/settings-daemon/plugins/media-keys/screen-brightness-cycle-static "['XF86MonBrightnessCycle']"
dconf write /org/gnome/settings-daemon/plugins/media-keys/screen-brightness-down "['']"
dconf write /org/gnome/settings-daemon/plugins/media-keys/screen-brightness-down-static "['XF86MonBrightnessDown']"
dconf write /org/gnome/settings-daemon/plugins/media-keys/screen-brightness-up "['']"
dconf write /org/gnome/settings-daemon/plugins/media-keys/screen-brightness-up-static "['XF86MonBrightnessUp']"
dconf write /org/gnome/settings-daemon/plugins/media-keys/screenreader "['']"
dconf write /org/gnome/settings-daemon/plugins/media-keys/screensaver "['<Super>Escape']"
dconf write /org/gnome/settings-daemon/plugins/media-keys/screensaver-static "['XF86ScreenSaver']"
dconf write /org/gnome/settings-daemon/plugins/media-keys/search "['']"
dconf write /org/gnome/settings-daemon/plugins/media-keys/search-static "['XF86Search']"
dconf write /org/gnome/settings-daemon/plugins/media-keys/stop "['']"
dconf write /org/gnome/settings-daemon/plugins/media-keys/stop-static "['XF86AudioStop']"
dconf write /org/gnome/settings-daemon/plugins/media-keys/suspend "['']"
dconf write /org/gnome/settings-daemon/plugins/media-keys/suspend-static "['XF86Sleep']"
dconf write /org/gnome/settings-daemon/plugins/media-keys/toggle-contrast "['']"
dconf write /org/gnome/settings-daemon/plugins/media-keys/touchpad-off "['']"
dconf write /org/gnome/settings-daemon/plugins/media-keys/touchpad-off-static "['XF86TouchpadOff']"
dconf write /org/gnome/settings-daemon/plugins/media-keys/touchpad-on "['']"
dconf write /org/gnome/settings-daemon/plugins/media-keys/touchpad-on-static "['XF86TouchpadOn']"
dconf write /org/gnome/settings-daemon/plugins/media-keys/touchpad-toggle "['']"
dconf write /org/gnome/settings-daemon/plugins/media-keys/touchpad-toggle-static "['XF86TouchpadToggle', '<Ctrl><Super>XF86TouchpadToggle']"
dconf write /org/gnome/settings-daemon/plugins/media-keys/volume-down "['']"
dconf write /org/gnome/settings-daemon/plugins/media-keys/volume-down-precise "['']"
dconf write /org/gnome/settings-daemon/plugins/media-keys/volume-down-precise-static "['<Shift>XF86AudioLowerVolume', '<Ctrl><Shift>XF86AudioLowerVolume']"
dconf write /org/gnome/settings-daemon/plugins/media-keys/volume-down-quiet "['']"
dconf write /org/gnome/settings-daemon/plugins/media-keys/volume-down-quiet-static "['<Alt>XF86AudioLowerVolume', '<Alt><Ctrl>XF86AudioLowerVolume']"
dconf write /org/gnome/settings-daemon/plugins/media-keys/volume-down-static "['XF86AudioLowerVolume', '<Ctrl>XF86AudioLowerVolume']"
dconf write /org/gnome/settings-daemon/plugins/media-keys/volume-mute "['']"
dconf write /org/gnome/settings-daemon/plugins/media-keys/volume-mute-quiet "['']"
dconf write /org/gnome/settings-daemon/plugins/media-keys/volume-mute-quiet-static "['<Alt>XF86AudioMute']"
dconf write /org/gnome/settings-daemon/plugins/media-keys/volume-mute-static "['XF86AudioMute']"
dconf write /org/gnome/settings-daemon/plugins/media-keys/volume-step 6
dconf write /org/gnome/settings-daemon/plugins/media-keys/volume-up "['']"
dconf write /org/gnome/settings-daemon/plugins/media-keys/volume-up-precise "['']"
dconf write /org/gnome/settings-daemon/plugins/media-keys/volume-up-precise-static "['<Shift>XF86AudioRaiseVolume', '<Ctrl><Shift>XF86AudioRaiseVolume']"
dconf write /org/gnome/settings-daemon/plugins/media-keys/volume-up-quiet "['']"
dconf write /org/gnome/settings-daemon/plugins/media-keys/volume-up-quiet-static "['<Alt>XF86AudioRaiseVolume', '<Alt><Ctrl>XF86AudioRaiseVolume']"
dconf write /org/gnome/settings-daemon/plugins/media-keys/volume-up-static "['XF86AudioRaiseVolume', '<Ctrl>XF86AudioRaiseVolume']"
dconf write /org/gnome/settings-daemon/plugins/media-keys/www-static "['XF86WWW']"

set_keybindings

declare -A desktop_map
desktop_map=( ["1"]=1 ["2"]=2 ["3"]=3 ["4"]=4 ["5"]=5 ["6"]=6 ["7"]=7 ["8"]=8 ["9"]=9 ["10"]=0 ["11"]=minus ["12"]=equal )

for key in ${!desktop_map[@]}; do
  val=${desktop_map[${key}]}
  # echo $key $val
  workspace_keyb_path="/org/gnome/desktop/wm/keybindings"
  # echo write "$workspace_keyb_path/switch-to-workspace-${key}" "['<Super>${val}']"

  dconf write "$workspace_keyb_path/switch-to-workspace-${key}" "['<Super>${val}']"
  dconf write "$workspace_keyb_path/move-to-workspace-${key}" "['<Super><Shift>${val}']"
done


dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-down "@as [ ]"
dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-up "@as [ ]"

# set composer key
dconf write /org/gnome/desktop/input-sources/xkb-options "['compose:ralt']"

# set input sources and languages

# set defaults
xdg-settings set default-web-browser brave-browser.desktop
sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator $(which kitty) 50
