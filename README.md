# magic-arch-installer
Install arch linux just in few clicks. Even a 5 years kid can install arch now.

### What is magic-arch-installer?
magic-arch-installer is a bash script with the commands required to install arch linux listed in order that makes a person install arch in much easier, faster and more convenient way.

### Usage
1. boot your arch installation media in your machine and connect to the internet.

For ethernet just plug your ethernet cable.

For [Wifi connection check here](https://wiki.archlinux.org/title/Iwd#iwctl).

For [mobile broadband connection check here](https://wiki.archlinux.org/title/Mobile_broadband_modem#ModemManager).


### *Note: filenames must be same as original. Changing the filename when downloading script breaks the script.*

2. Install git in your live media and clone [this](https://github.com/whoisYoges/magic-arch-installer) repository in your installation media.
```
pacman -Sy --needed --noconfirm git && \
git clone https://github.com/whoisYoges/magic-arch-installer
```

3. Go to magic-arch-installer directory and execute the installer script.
```
cd magic-arch-installer
```
- 3a. For UEFI installatios:
 ```
 chmod +x uefi-base-install.sh && \
 ./uefi-base-install.sh
 ```
 
- 3b. For Legacy installatios:
 ```
 chmod +x legacy-base-install.sh && \
 ./legacy-base-install.sh
 ```

### This does the base installation of arch (without GUI) in your machine.
To install GUI check [gui-with-xorg](gui-with-xorg).
