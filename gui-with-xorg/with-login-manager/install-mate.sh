sudo pacman -Sy --needed xorg-server lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings mate 

##uncomment the line below to install mate-extra package for additional utilities and applications that integrate well with the MATE desktop.
#sudo pacman -Sy --needed mate-extra


##uncomment the line below if you have AMD GPU
#sudo pacman -Sy xf86-video-amdgpu


##uncomment the line below if you have Nvidia GPU
#sudo pacman -Sy nvidia nvidia-utils


##uncomment the line below if you have Intel GPU
#sudo pacman -Sy xf86-video-intel


sudo systemctl enable lightdm
sudo systemctl start lightdm
