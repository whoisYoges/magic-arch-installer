sudo pacman -Sy --needed xorg-server xorg-xinit base-devel libx11 libxinerama libxft webkit2gtk

#install dwm
cd ~
wget https://dl.suckless.org/dwm/dwm-6.2.tar.gz
tar -xvzf dwm-6.2.tar.gz
cd dwm-6.2/
sudo make clean install

#install st (simple terminal)
cd ~
wget https://dl.suckless.org/st/st-0.8.4.tar.gz
tar -xvzf st-0.8.4.tar.gz
cd st-0.8.4/
sudo make clean install
cd ~


##uncomment the line below if you have AMD GPU
#sudo pacman -Sy xf86-video-amdgpu


##uncomment the line below if you have Nvidia GPU
#sudo pacman -Sy nvidia nvidia-utils


##uncomment the line below if you have Intel GPU
#sudo pacman -Sy xf86-video-intel

cd ~
echo "exex dwm" > .xinitrc
startx
