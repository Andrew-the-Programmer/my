[Source YouTube video](https://www.youtube.com/watch?v=WaWB3F-ffcI&list=PL0JlUCdsWbE7MrEAs46EB3WHF8saxXjY_&index=2)
# Connect to internet 

```bash
> iwctl
> device list
> station <your stationw|wlan0> get-networks
> station <your stationw|wlan0> connect <your network>
```

# Install packages

```bash
pacman -Sy "archlinux-keyring" "archinstall"
```

# Configure drives for dual boot

> you can run `lsblk` to see all your disks and partitions

```bash 
> lsblk
example output:
nvme0n1      259:0    0 476.9G  0 disk 
├─nvme0n1p1  259:1    0   200M  0 part 
├─nvme0n1p2  259:2    0    16M  0 part 
├─nvme0n1p3  259:3    0  85.2G  0 part 
├─nvme0n1p4  259:4    0   512M  0 part 
├─nvme0n1p5  259:5    0    14G  0 part 
├─nvme0n1p6  259:6    0     1G  0 part 
├─nvme0n1p9  259:7    0   7.5G  0 part [SWAP]
├─nvme0n1p10 259:8    0     1G  0 part /boot
└─nvme0n1p11 259:9    0 278.6G  0 part /
```

1. Run `cfdisk /dev/sda`
2. Create 2 partitions from "Free space": 1G (for efi sda5) and >20G (for system storage sda6)
3. Select partition of 1G and set it's "Type" to "EFI System"
4. "Write" changes
5. "Quit"

6. format partitions

```bash
> mkfs.fat -F32 /dev/sda5
> mkfs.btrfs /dev/sda6
```

# Mount partitions

```bash
> mount /dev/sda6 /mnt
> mkdir /mnt/boot
> mount /dev/sda5 /mnt/boot
```

# `archinstall` script

> [Instructions for manual Omarchy install](https://learn.omacom.io/2/the-omarchy-manual/96/manual-installation)

Run `archinstall`.

1. `Archinstall language`: `English`
2. `Locales`
	1. kb_layout: us
	2. sys_enc: UTF-8
	3. sys_lang: en_US
3. Mirrors and repositories
4. Disk configuration
	1. Partitioning
		1. best-effort
		2.  Manual
		3. Pre-mounted
		   Input "Root mount directory": "/mnt"
	2. Disk encryption
	    This is kind of impossible with mounted partitioning...
		1. Type: LUKS
		2. Encryption password: `dencpass1223`
		3. Partitions
5. Swap
6. Bootloader: Grub
7. Hostname
8. Authentication
	1. Root password: `root1223`
	2. User account -> Add a user
		1. Password: `1223`
		2. Superuser: `Yes`
	3. U2F login setup
9. Profile
   For omarchy select "Minimal"
10. Applications
	1. Bluetooth: enabled
	2. Audio: pipewire
11. Kernels
12. Network configuration
    For Omarchy select "Copy ISO"
	For desktop env "Use NetworkManager"
13. Additional packages
14. Timezone
15. Automatic time sync (NTP)

Install.

# Post archinstall

1. Select option chroot.
2. Exit chroot.
3. Unmount /mnt: 
   ```bash
	> umount -lR /mnt
	```
4. `reboot now`
5. remove boot usb
6. Install omarchy with
   ```bash
   > curl -fsSL https://omarchy.org/install | bash
   ```

# Limine config for omarchy

1. Add windows boot manager
	1. `sudo limine-scan`
	2. add windows boot manager
2. `sudo mv /boot/EFI/Linux/omarchy_linux.efi /boot/EFI/limine/omarchy_linux.efi`
3. `sudo edit /boot/limine.conf`
4. `#timeout: 3` -> `timeout: 30`
5. `image_path: boot():/EFI/Linux/omarchy_linux.efi` ->`image_path: boot():/EFI/limine/omarchy_linux.efi`
