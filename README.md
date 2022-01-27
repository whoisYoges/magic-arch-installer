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
### For UEFI Installation Type
2 a. get uefi-base-install.sh in your installation media.
```
curl https://raw.githubusercontent.com/whoisYoges/magic-arch-installer/master/uefi-base-install.sh > uefi-base-install.sh
```
3 a. open the script with text editor vim or nano and make necessary changes if required (such as timezone, kernel and kernel-headers, filesystem type, etc) and save it.

4 a. make it executable.
```
chmod +x uefi-base-install.sh
```
5 a. run it.
```
./uefi-base-install.sh
```
## For Legacy Installation Type
2 b. get base-install.sh in your installation media.
```
curl https://raw.githubusercontent.com/whoisYoges/magic-arch-installer/master/legacy-base-install.sh > legacy-base-install.sh
```
3 b. open the script with text editor vim or nano and make necessary changes if required (such as timezone, kernel and kernel-headers, filesystem type, etc) and save it.

4 b. make it executable.
```
chmod +x legacy-base-install.sh
```
5 b. run it.
```
./legacy-base-install.sh
```

### This does the base installation of arch in your machine.
To install GUI check [gui-with-xorg].
