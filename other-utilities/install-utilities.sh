sudo pacman -Syu --needed pulseaudo pulseaudio-alsa pavucontrol celluloid gimp viewnior libreoffice-still okular firefox tar zip unzip unrar xarchiver pcmanfm alacritty discord telegram-desktop gparted gnome-disk-utility vim mousepad

#install yay aur helper
cd ~
sudo pacman -Sy --needed git
mkdir Gitclones
cd Gitclones/
git clone https://aur.archlinux.org/yay.git
cd yay/
makepkg -si
cd ~

### Below this is only for window managers ( i3 and dwm )
## Uncomment the line below to install dmenu application launcher
#sudo pacman -Sy --needed dmenu

## Uncomment the line below to install rofi application launcher
#sudo pacman -Sy --needed rofi

exit
