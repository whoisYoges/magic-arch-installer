# magic-arch-installer gui-with-xorg without-login-manager

### install your required desktop environment or the window manager in few clicks

## ⚠️ Warning: run any of these scripts with regular user. It's not recommended to execute them as root user.

### Usage
 1. boot and login into your arch or arch based system with regular user.
 2. Decide which DE or WM to install and get the script in your machine.
 3. Get the installation script in your machine.

	 a. Cinnamon
	 ```
	 curl https://raw.githubusercontent.com/YogeshLamichhane/magic-arch-installer/master/gui-with-xorg/without-login-manager/install-cinnamon.sh > install-cinnamon.sh
	 ```
	 b. DWM
	 ```
	 curl https://raw.githubusercontent.com/YogeshLamichhane/magic-arch-installer/master/gui-with-xorg/without-login-manager/install-dwm.sh > install-dwm.sh
	 ```
	 c. Gnome
	 ```
	 curl https://raw.githubusercontent.com/YogeshLamichhane/magic-arch-installer/master/gui-with-xorg/without-login-manager/install-gnome.sh > install-gnome.sh
	 ```
	 d. I3
	 ```
	 curl https://raw.githubusercontent.com/YogeshLamichhane/magic-arch-installer/master/gui-with-xorg/without-login-manager/install-cinnamon.sh > install-i3.sh
	 ```
	 e. KDE
	 ```
	 curl https://raw.githubusercontent.com/YogeshLamichhane/magic-arch-installer/master/gui-with-xorg/without-login-manager/install-cinnamon.sh > install-kde.sh
	 ```
	 f. LXQt
	 ```
	 curl https://raw.githubusercontent.com/YogeshLamichhane/magic-arch-installer/master/gui-with-xorg/without-login-manager/install-cinnamon.sh > install-lxqt.sh
	 ```
	 g. Mate
	 ```
	 curl https://raw.githubusercontent.com/YogeshLamichhane/magic-arch-installer/master/gui-with-xorg/without-login-manager/install-cinnamon.sh > install-mate.sh
	 ```
	 h. Xfce
	 ```
	 curl https://raw.githubusercontent.com/YogeshLamichhane/magic-arch-installer/master/gui-with-xorg/without-login-manager/install-cinnamon.sh > install-xfce.sh
	 ```
 4. Make necessary changes in the script opening it in your favourite text editor ( nano or vim) if required. 

 5. Make the script executable.
	 ```
	 chmod +x install-<your DE/WM>.sh
	 ```
 6. Execute the script
	 ```
	 ./install-<your DE/WM>.sh
	 ```

FOR EXAMPLE:

	To install xfce:
	
	curl https://raw.githubusercontent.com/YogeshLamichhane/magic-arch-installer/master/gui-with-xorg/without-login-manager/install-xfce.sh > install-xfce.sh
	 
	chmod +x install-xfce.sh
	 
	./install-xfce.sh
