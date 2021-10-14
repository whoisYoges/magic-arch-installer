##If you have an Intel GPU, make sure you are not using xf86-video-intel with Cinnamon as it may freeze at random times.

sudo pacman -Sy --needed xorg-server xorg-xinit cinnamon alacritty


##uncomment two of the lines below to have printer options in the settings and enable printing service
#sudo pacman -Sy system-config-printer cups
#sudo systemctl enable org.cups.cupsd.service


##Uncomment two of lines below to be able to have bluetooth and enbale it in your system
#sudo pacman -Sy blueberry
#sudo systemctl enable bluetooth


#uncomment the line below if you have AMD GPU
#sudo pacman -Sy xf86-video-amdgpu


#uncomment the line below if you have Nvidia GPU
#sudo pacman -Sy nvidia nvidia-utils

## uncomment the line below if you need to save/store wifi passwords
#sudo pacman -Sy --needed gnome-keyring

cd ~
echo "exex cinnamon-session" > .xinitrc
startx
