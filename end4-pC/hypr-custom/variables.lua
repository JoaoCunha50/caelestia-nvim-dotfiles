hl.env("qsConfig", "end4-pC")

terminal =
"~/.config/hypr/hyprland/scripts/launch_first_available.sh 'foot' 'kitty -1' 'alacritty' 'wezterm' 'konsole' 'kgx' 'uxterm' 'xterm'"
fileManager =
"~/.config/hypr/hyprland/scripts/launch_first_available.sh 'nautilus' 'nemo' 'thunar' 'kitty -1 fish -c yazi'"
browser =
"~/.config/hypr/hyprland/scripts/launch_first_available.sh 'zen-browser' 'firefox' 'brave' 'chromium' 'microsoft-edge-stable' 'opera' 'librewolf'"
codeEditor =
"~/.config/hypr/hyprland/scripts/launch_first_available.sh  'zeditor' 'code' 'codium' 'cursor' 'zedit' 'kate' 'gnome-text-editor' 'emacs' 'command -v nvim && kitty -1 nvim' 'command -v micro && kitty -1 micro'"
officeSoftware =
"~/.config/hypr/hyprland/scripts/launch_first_available.sh 'wps' 'onlyoffice-desktopeditors' 'libreoffice'"
textEditor =
"~/.config/hypr/hyprland/scripts/launch_first_available.sh 'kitty -1 fish -c nvim' 'kate' 'gnome-text-editor' 'emacs'"
volumeMixer = "~/.config/hypr/hyprland/scripts/launch_first_available.sh 'pavucontrol-qt' 'pavucontrol'"
settingsApp =
"XDG_CURRENT_DESKTOP=gnome ~/.config/hypr/hyprland/scripts/launch_first_available.sh 'qs -p ~/.config/quickshell/$qsConfig/settings.qml' 'systemsettings' 'gnome-control-center' 'better-control'"
taskManager =
"~/.config/hypr/hyprland/scripts/launch_first_available.sh 'gnome-system-monitor' 'plasma-systemmonitor --page-name Processes' 'command -v btop && kitty -1 fish -c btop'"
