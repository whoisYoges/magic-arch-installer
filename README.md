# magic-arch-installer
Install arch linux just in few clicks. Even a 5 years kid can install arch now.

### What is magic-arch-installer?
magic-arch-installer is a bash script with the commands required to install arch linux listed in order that makes a person install arch in much easier, faster and more convenient way.

## ⚠️ Warning: Currently it supports uefi installation only. Legacy installation type will be added later if required.

### Usage
1. boot your arch installation media in your machine and connect to the internet.

For ethernet just plug your ethernet cable.

For [Wifi connection check here](https://wiki.archlinux.org/title/Iwd#iwctl).

For [mobile broadband connection check here](https://wiki.archlinux.org/title/Mobile_broadband_modem#ModemManager).

2. get base-install.sh in your installation media.
```
curl https://raw.githubusercontent.com/whoisYoges/magic-arch-installer/master/base-install.sh > base-install.sh
```
3. open the script with text editor vim or nano and make necessary changes if required (such as timezone, kernel and kernel-headers, filesystem type, etc) and save it.

4. make it executable.
```
chmod +x base-install.sh
```
5. run it.
```
./base-install.sh
```
