sudo pacman -Sy --needed xorg-server lxqt sddm

##uncomment the line below if you have AMD GPU
#sudo pacman -Sy xf86-video-amdgpu


##uncomment the line below if you have Nvidia GPU
#sudo pacman -Sy nvidia nvidia-utils


##uncomment the line below if you have Intel GPU
#sudo pacman -Sy xf86-video-intel


sudo systemctl enable sddm
sudo systemctl start sddm
