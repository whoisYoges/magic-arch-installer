# magic-arch-installer gui-with-xorg
Install your favourite desktop environment or window manager in a click.

This is the minimal installation without any extra packages. You can add later according to your requirements.

Those DE/WM which doesn't come with terminal emulator by default, alacritty is used.

 1. With Login manager
 	Those DE/WM which have their own login manager or is recommended in arch-wiki, their default login managers are used, else lightdm is used as login managers.

 2. Without Login manager
 	`startx` command is used to start the gui after logging in to tty.
 	xorg-xinit package is used for this, creating .xinitrc file in your home directory.
