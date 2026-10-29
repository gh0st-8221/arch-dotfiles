mkdir -p ~/git
git clone https://github.com/gh0st-8221/arch-dotfiles.git ~/git/arch-dotfiles
git clone https://github.com/gh0st-8221/ghostwm ~/git/ghostwm
sudo wget -O /usr/bin/xscreencopy https://github.com/gh0st-8221/xscreencopy/raw/refs/heads/main/xscreencopy
sudo chmod +x /usr/bin/xscreencopy
git clone https://aur.archlinux.org/xdg-desktop-portal-termfilechooser-git.git ~/git/xdg-desktop-portal-termfilechooser-git
sudo pacman -Syu --noconfirm 7zip alacritty android-tools android-udev archiso arduino-cli base base-devel bluez bluez-utils bottom cava chromium chrpath cjson cmake cmark cmatrix dpkg dunst efibootmgr extra-cmake-modules fastfetch fd firefox flatbuffers freetds gamemode git github-cli glib2-devel gradle grub gst-plugin-pipewire headsetcontrol helix imagemagick inetutils intel-ucode iwd jdk17-openjdk jdk21-openjdk kdenlive libayatana-appindicator libdisplay-info libfbclient libftdi libinput libpulse libva-nvidia-driver libxkbcommon linux linux-firmware lua51 maim make mariadb-libs meson mkinitcpio mpv network-manager-applet networkmanager ninja nvidia-open obs-studio openresolv os-prober pipewire pipewire-alsa pipewire-jack pipewire-pulse pkgconf pkgfile playerctl postgresql-libs python-pip python-pyserial qbittorrent qrencode qt6-serialport qt6-svg quazip-qt6 rofi rust scanmem sdbus-cpp seatd slop smartmontools sof-firmware steam sudo tomlplusplus tor torbrowser-launcher ttf-nerd-fonts-symbols ueberzugpp unzip usbutils v4l2loopback-dkms v4l2loopback-utils vulkan-headers wgcf wget wireguard-tools wireplumber xclip xdg-utils xorg-server xorg-xinit xorg-xwayland yazi zram-generator zsh  libdisplay-info libinput seatd mesa libxkbcommon
if ! command -v yay &> /dev/null && ! command -v paru &> /dev/null; then
    sudo pacman -S --noconfirm base-devel git
    git clone https://aur.archlinux.org/yay-bin.git ~/git/yay-bin
    cd ~/git/yay-bin && makepkg -si --noconfirm && cd ~
fi
HELPER="yay"
if command -v paru &> /dev/null; then HELPER="paru"; fi
if [ -n "wireguard-dkms xdg-desktop-portal-termfilechooser-git xdg-desktop-portal-termfilechooser-git-debug yay yay-debug " ]; then
    $HELPER -S --noconfirm wireguard-dkms xdg-desktop-portal-termfilechooser-git xdg-desktop-portal-termfilechooser-git-debug yay yay-debug 
fi
cd ~/git/xdg-desktop-portal-termfilechooser-git
makepkg -si --noconfirm
cd ~/git/ghostwm
sudo make install
cd ~
if [ -d ~/git/arch-dotfiles/usr/share/grub/themes/catppuccin-mocha-grub-theme ]; then
    [ -d /usr/share/grub/themes/catppuccin-mocha-grub-theme ] && sudo cp -r /usr/share/grub/themes/catppuccin-mocha-grub-theme /usr/share/grub/themes/catppuccin-mocha-grub-theme.bak
    sudo cp -r ~/git/arch-dotfiles/usr/share/grub/themes/catppuccin-mocha-grub-theme /usr/share/grub/themes/
fi
if [ -f ~/git/arch-dotfiles/etc/default/grub ]; then
    [ -f /etc/default/grub ] && sudo cp /etc/default/grub /etc/default/grub.bak
    sudo cp ~/git/arch-dotfiles/etc/default/grub /etc/default/grub
fi
sudo grub-mkconfig -o /boot/grub/grub.cfg
mkdir -p ~/.config
[ -f ~/.config/xdg-desktop-portal-termfilechooser/config ] && cp ~/.config/xdg-desktop-portal-termfilechooser/config ~/.config/xdg-desktop-portal-termfilechooser/config.bak
[ -f ~/.config/yazi/yazi-wrapper.sh ] && cp ~/.config/yazi/yazi-wrapper.sh ~/.config/yazi/yazi-wrapper.sh.bak
cp -r ~/git/arch-dotfiles/.config/. ~/.config/
chmod +x ~/.config/yazi/yazi-wrapper.sh
[ -f ~/.zshrc ] && cp ~/.zshrc ~/.zshrc.bak
cp ~/git/arch-dotfiles/.zshrc ~/.zshrc
[ -f ~/.zprofile ] && cp ~/.zprofile ~/.zprofile.bak
cp ~/git/arch-dotfiles/.zprofile ~/.zprofile
if [ -f ~/git/arch-dotfiles/.xinitrc ]; then
    [ -f ~/.xinitrc ] && cp ~/.xinitrc ~/.xinitrc.bak
    cp ~/git/arch-dotfiles/.xinitrc ~/.xinitrc
fi
chsh -s $(which zsh) $USER
sudo chsh -s $(which zsh) root
mkdir -p ~/.zsh/plugins
if [ -d ~/.zsh/plugins/zsh-autosuggestions ]; then
    cp -r ~/.zsh/plugins/zsh-autosuggestions ~/.zsh/plugins/zsh-autosuggestions.bak
    rm -rf ~/.zsh/plugins/zsh-autosuggestions
fi
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/plugins/zsh-autosuggestions
if [ -d ~/.zsh/plugins/zsh-syntax-highlighting ]; then
    cp -r ~/.zsh/plugins/zsh-syntax-highlighting ~/.zsh/plugins/zsh-syntax-highlighting.bak
    rm -rf ~/.zsh/plugins/zsh-syntax-highlighting
fi
git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.zsh/plugins/zsh-syntax-highlighting
sudo mkdir -p /root/.zsh/plugins
sudo rm -rf /root/.zsh/plugins/zsh-autosuggestions /root/.zsh/plugins/zsh-syntax-highlighting
sudo cp -r ~/.zsh/plugins/zsh-autosuggestions ~/.zsh/plugins/zsh-syntax-highlighting /root/.zsh/plugins/
[ -f /root/.zshrc ] && sudo cp /root/.zshrc /root/.zshrc.bak
sudo cp ~/git/arch-dotfiles/.zshrc /root/.zshrc
[ -f /root/.zprofile ] && sudo cp /root/.zprofile /root/.zprofile.bak
sudo cp ~/git/arch-dotfiles/.zprofile /root/.zprofile
systemctl --user enable --now pipewire.service
systemctl --user enable --now pipewire-pulse.service
systemctl --user enable --now wireplumber.service
