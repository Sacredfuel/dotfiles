# Arch Installation

Writeup of the Arch Linux Installation Process.

### Connecting to Wifi
First thing we need to do is connect to the internet as all packages are on the Arch User Repository(AUR) and we cannot access it without an internet connection, if you are already connected to ethernet, test it with the ping command, otherwise follow these instructions for a WiFi setup.

```bash
iwctl
device list                      #take your wireless adapter e.x. wlan0
station wlan0 get-networks       #list the avalible networks
station wlan0 connect <name>     #connects to the selected wifi

ping -c 3 google.com             #tests the connection
ip -c a                          #make sure UP
```

### Internal Clock
Next we need the system's internal clock to be synced with the real time.

```bash
timedatectl status               #get current time
timedatectl list-timezones       #find your timezone
timedatectl set-timezones <var>  #sets the timezone
```

### Partition Management
Now we need to do the scary part, we'll need to setup 3 partitions. The main ones we'll need is a root partition with our main filesystem, a home partition and a swap partition.

```bash
lsblk                            #take the name of the drive
cfdisk /dev/<name>               #open the partition manager
```

Create root filesystem partition with >10G 
Create swap partition with ~8G
Create home filesystem partition with remaining memory

Write all the changes and quit.

### Formatting Partitions

We need to format the partitions with ext4.

```bash
mkfs.ext4 /dev/<root>
mkfs.ext4 /dev/<home>
mkswap /dev/<swap>
swapon /dev/<swap>
```
Verify with lsblk.


### Mounting Drives

Now that the drives are formatted, we can mount them to our partitions.

```bash
mount /dev/<root> /mnt
mkdir /mnt/home
mount /dev/<home> /mnt/home
```

Verify with lsblk.

### Speeding up installation

While this step is optional, we will be choosing the top 10 sources for pacman to speed up the calls to the AUR.

```bash
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
pacman -Sy
pacman -S pacman-contrib
rankmirrors -n 10 /etc/pacman.d/mirrorlist.bak > /etc/pacman.d/mirrorlist
cat /etc/pacman.d/mirrorlist
```

### Installing Arch to /mnt

Now that we have pacman fully operational, and our partitions are properly formatted we can install the real OS onto our drive.

```bash
pacstrap -u /mnt base base-devel linux linux-lts linux-headers linux-firmware intel-ucode sudo nano vim git github-cli neofetch networkmanager dhcpcd pulseaudio

genfstab -U /mnt >> /mnt/etc/fstab      #generate file system table
cat /mnt/etc/fstab                      #to verify

arch-chroot /mnt                        #change root to mount
passwd                                  #change password of sudo
useradd -m <user>                       #make your account
passwd <user>                           #sets password for your account
usermod -aG wheel,storage,power <user>  #add user to these groups

visudo                                  #uncomment line 85(wheel ALL=(ALL) ALL)
```

### Locale/Config Files

With Arch installed, we need to generate the locale for the language.

```bash
vim /etc/local.gen                      #uncomment en_US.UTF-8 UTF-8
locale-gen                              #generates locale

echo LANG=en_US.UTF-8 > /etc/locale.conf
export LANG=en_US.UTF-8
```

### Host Name

We also need to make a host name for routing inbound and outbound connections.

```bash
echo <name> > /etc/hostname             #Set up the name of the host
vim /etc/hosts                          #add the following

127.0.0.1       localhost
::1             localhost
127.0.1.1       <name>.localdomain      localhost
```

### Timezone/Region

Now to link our Internal Clock to the Hardware clock.

```shell
ln -sf /usr/share/zoneinfo/<tab> /etc/localtime
#use tab to find your zone e.x. America/New_York
hwclock --systohc
```

### Grub Boot Loader

Last major step is setting up the grub boot loader which will allow us to boot into other OS's if necessary, we also need OS Prober for it to detect the other OS and we'll need to swap the current bootloader with out new one.

```shell
cfdisk /dev/<name of drive>             #get the EFI Partition <efi>
mkdir /boot/efi                         #making the directory of our bootloader
mount /dev/<efi> /boot/efi              #changing the bootloader to our one
pacman -S efibootmgr dosfstools mtools grub
vim /etc/default/grub                   #uncomment the last line |GRUB_DISABLE_OS_PROBER=false|
pacman -S os-prober                     #allows grub to detect windows
grub-install --target=x86_64_efi --bootloader-id=grub_uefi --recheck
grub-mkconfig -o /boot/grub/grub.cfg
ls /boot/efi/EFI                        #list all boot options
```

### Finalizing the USB

Last thing we need to do before we can remove the USB is enabling certain services and exiting the USB enviorment.

```shell
systemctl enable dhcpcd.service         #enable IP Ports
systemctl enable NetworkManager.service #enable network manager
exit                                    #exit chroot enviorment
unmount -lR /mnt                        #unmount all partitions
reboot
```

### GUI - KDE Plasma

Now that we have Arch fully installed and mounted, we need to install a graphical user interface to use, in this case we will use KDE Plasma.

```shell
sudo pacman -S xorg xorg-init xterm plasma plasma-desktop plasma-wayland-session kde-applications kdeplasma-addons sddm
sudo vim ~/.xinitrc                     #add the following to this file
exec startkde

sudo systemctl enable sddm.service      #enable the display manager
pacman -S firefox htop gimp bpytop      #final set of packages to install for general use
```
