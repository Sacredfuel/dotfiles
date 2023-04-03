# Arch Installation

Writeup of the Arch Linux Installation Process.

### Connecting to Wifi

```bash
iwctl
device list                      #take your wireless adapter e.x. wlan0
station wlan0 get-networks       #list the avalible networks
station wlan0 connect <name>     #connects to the selected wifi

ping -c 3 google.com             #tests the connection
ip -c a                          #make sure UP
```

#### Internal Clock

```bash
timedatectl status               #get current time
timedatectl list-timezones       #find your timezone
timedatectl set-timezones <var>  #sets the timezone
```

#### Partition Management

```
lsblk                            #take the name of the drive
cfdisk /dev/<name>               #open the partition manager
```

Create root filesystem partition with >10G 
Create swap partition with ~8G
Create home filesystem partition with remaining memory

Write all the changes and quit.

#### Formatting Partitions

We need to format the partitions with ext4

```bash
mkfs.ext4 /dev/<root>
mkfs.ext4 /dev/<home>
mkswap /dev/<swap>
swapon /dev/<swap>
```
Verify with lsblk


### Mounting Drives

```bash
mount /dev/<root> /mnt
mkdir /mnt/home
mount /dev/<home> /mnt/home
```

Verify with lsblk

### Speeding up installation

```bash
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
pacman -Sy
pacman -S pacman-contrib
rankmirrors -n 10 /etc/pacman.d/mirrorlist.bak > /etc/pacman.d/mirrorlist
cat /etc/pacman.d/mirrorlist
```

### Installing Arch to /mnt

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

```bash
vim /etc/local.gen                      #uncomment en_US.UTF-8 UTF-8
locale-gen                              #generates locale

echo LANG=en_US.UTF-8 > /etc/locale.conf
export LANG=en_US.UTF-8
```

### Host Name

```bash
echo <name> > /etc/hostname             #Set up the name of the host
vim /etc/hosts                          #add the following

127.0.0.1       localhost
::1             localhost
127.0.1.1       <name>.localdomain      localhost
```

### Timezone/Region
```shell
ln -sf /usr/share/zoneinfo/<tab> /etc/localtime
#use tab to find your zone e.x. America/New_York
hwclock --systohc
```
