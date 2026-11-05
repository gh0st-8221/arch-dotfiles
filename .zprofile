if [[ "$(tty)" == "/dev/tty1" ]]; then
    export XDG_CURRENT_DESKTOP=ghostwm
    export XDG_SESSION_TYPE=x11
    exec startx
    dbus-update-activation-environment --systemd DISPLAY XAUTHORITY XDG_CURRENT_DESKTOP
fi
