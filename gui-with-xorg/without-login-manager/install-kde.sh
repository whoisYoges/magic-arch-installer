#If you have an Intel GPU, it's not recommended to use xf86-video-intel cause it can result in various graphical glitches and freezes.

sudo pacman -Sy --needed xorg-server xorg-xinit plasma-desktop alacritty

##uncomment the line below to install kde-applications that contains full set of KDE Applications
#sudo pacman -Sy kde-applications


##uncomment the line below if you have AMD GPU
#sudo pacman -Sy xf86-video-amdgpu


##uncomment the line below if you have Nvidia GPU
#sudo pacman -Sy nvidia nvidia-utils


cd ~
echo "export DESKTOP_SESSION=plasma" > .xinitrc
echo "exec startplasma-x11" >> .xinitrc
startx
