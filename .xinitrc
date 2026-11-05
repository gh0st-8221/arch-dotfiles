#!/bin/sh
export GTK_USE_PORTAL=1
dbus-update-activation-environment --systemd DISPLAY XDG_CURRENT_DESKTOP
systemctl --user import-environment DISPLAY XDG_CURRENT_DESKTOP
systemctl --user restart xdg-desktop-portal-termfilechooser.service xdg-desktop-portal.service
exec ghostwm
