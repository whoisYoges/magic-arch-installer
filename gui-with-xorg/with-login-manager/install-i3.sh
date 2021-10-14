sudo pacman -Sy --needed xorg-server alacritty i3-wm lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings

#uncomment the line below if you have AMD GPU
#sudo pacman -Sy xf86-video-amdgpu


#uncomment the line below if you have Nvidia GPU
#sudo pacman -Sy nvidia nvidia-utils


##uncomment the line below if you have Intel GPU
#sudo pacman -Sy xf86-video-intel

##Uncomment the line below to install dmenu  application launcher
#sudo pacman -Sy --needed dmenu

##Uncomment the line below to install rofi  application launcher
#sudo pacman -Sy --needed rofi

sudo systemctl enable lightdm
sudo systemctl start lightdm
