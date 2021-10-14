sudo pacman -Sy --needed xorg-server xfce4 lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings

##Uncomment the line below to install xfce4-goodies package which includes extra plugins and a number of useful utilities such as the mousepad editor.
#sudo pacman -Sy --needed xfce4-goodies


##uncomment the line below if you have AMD GPU
#sudo pacman -Sy xf86-video-amdgpu


##uncomment the line below if you have Nvidia GPU
#sudo pacman -Sy nvidia nvidia-utils


##uncomment the line below if you have Intel GPU
#sudo pacman -Sy xf86-video-intel

sudo systemctl enable lightdm
sudo systemctl start lightdm
