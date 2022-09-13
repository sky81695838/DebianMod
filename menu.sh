#!/bin/bash

input=

echo "----------------------------------"

echo "Thanks for redorescue,the desktop confing file copyed from it."

echo "please enter your choise:(1-3)"

echo "(1) Make the squashfs "

echo "(2) Make boot file"

echo "(3) Make FinalISO "

echo "(4) Make boot ISO "

echo "----------------------------------"

read -n1 input                                            

case $input in 
1) echo 'Make squashfs'
# Check: Must be root
ROOT=rootdir
if [ "$EUID" -ne 0 ]
	then echo -e "\e[033m ERROR: Must be run as root.\e[0m\n"
	exit
fi
# Make base dir
	rm -rf $ROOT
	rm -f filesystem.squashfs
	if [ -f "debootstrap-bullseye-amd64.tar.gz" ]; then
		echo -e " debootstrap-bullseye-amd64.tar.gz exists, extracting existing archive...$off"
		sleep 2
		tar zxf debootstrap-bullseye-amd64.tar.gz
	elif [ -d rootdir ]; then
		rm -rf rootdir
else 
	debootstrap --variant=minbase --include=nano,bash-completion bullseye rootdir https://mirrors.tuna.tsinghua.edu.cn/debian/
	tar czpf debootstrap-bullseye-amd64.tar.gz $ROOT
	fi
cat > rootdir/etc/apt/sources.list <<EOF
deb https://mirrors.tuna.tsinghua.edu.cn/debian/ bullseye main contrib non-free
deb-src https://mirrors.tuna.tsinghua.edu.cn/debian/ bullseye main contrib non-free
deb https://mirrors.tuna.tsinghua.edu.cn/debian/ bullseye-updates main contrib non-free
deb-src https://mirrors.tuna.tsinghua.edu.cn/debian/ bullseye-updates main contrib non-free
deb https://mirrors.tuna.tsinghua.edu.cn/debian/ bullseye-backports main contrib non-free
deb-src https://mirrors.tuna.tsinghua.edu.cn/debian/ bullseye-backports main contrib non-free
deb https://mirrors.tuna.tsinghua.edu.cn/debian-security bullseye-security main contrib non-free
deb-src https://mirrors.tuna.tsinghua.edu.cn/debian-security bullseye-security main contrib non-free
deb https://mirrors.aliyun.com/debian/ bullseye main non-free contrib
deb-src https://mirrors.aliyun.com/debian/ bullseye main non-free contrib
deb https://mirrors.aliyun.com/debian-security/ bullseye-security main
deb-src https://mirrors.aliyun.com/debian-security/ bullseye-security main
deb https://mirrors.aliyun.com/debian/ bullseye-updates main non-free contrib
deb-src https://mirrors.aliyun.com/debian/ bullseye-updates main non-free contrib
deb https://mirrors.aliyun.com/debian/ bullseye-backports main non-free contrib
deb-src https://mirrors.aliyun.com/debian/ bullseye-backports main non-free contrib
EOF

cat > rootdir/etc/hosts <<END
127.0.0.1	localhost
127.0.1.1	doubt
::1		localhost ip6-localhost ip6-loopback
ff02::1		ip6-allnodes
ff02::2		ip6-allrouters
END

#Install package
cat > rootdir/package <<EOL
#!/bin/bash

# System mounts
mount none -t proc /proc;
mount none -t sysfs /sys;
mount none -t devpts /dev/pts

# Set default locale
cat >> /etc/bash.bashrc <<END
export LANG="C"
export LC_ALL="C"
END

export DEBIAN_FRONTEND=noninteractive
apt update && apt upgrade -y
apt install --no-install-recommends -y linux-image-amd64 live-boot \
systemd-sysv firmware-linux-free sudo vim-tiny pm-utils iptables-persistent \
iputils-ping net-tools wget openssh-client openssh-server rsync less \
xserver-xorg x11-xserver-utils xinit openbox obconf slim compton dbus-x11 \
libnotify-bin xfce4-notifyd gir1.2-notify-0.7 tint2 nitrogen xfce4-appfinder \
xfce4-power-manager gsettings-desktop-schemas lxrandr lxmenu-data \
lxterminal lxappearance network-manager-gnome gtk2-engines numix-gtk-theme \
gtk-theme-switch fonts-lato pcmanfm libfm-modules gpicview mousepad  pwgen \
xvkbd beep laptop-detect os-prober discover lshw-gtk hdparm smartmontools \
nmap time lvm2 gparted gnome-disk-utility baobab gddrescue testdisk \
dosfstools ntfs-3g reiserfsprogs reiser4progs hfsutils jfsutils smbclient \
cifs-utils nfs-common curlftpfs sshfs partclone pigz yad f2fs-tools \
exfat-fuse exfat-utils btrfs-progs locales fonts-wqy-zenhei chromium \
locales-all 
sleep 5
if [ "$?" -ne 0 ]; then
apt install --no-install-recommends -y linux-image-amd64 live-boot \
systemd-sysv firmware-linux-free sudo vim-tiny pm-utils iptables-persistent \
iputils-ping net-tools wget openssh-client openssh-server rsync less \
xserver-xorg x11-xserver-utils xinit openbox obconf slim compton dbus-x11 \
libnotify-bin xfce4-notifyd gir1.2-notify-0.7 tint2 nitrogen xfce4-appfinder \
xfce4-power-manager gsettings-desktop-schemas lxrandr lxmenu-data \
lxterminal lxappearance network-manager-gnome gtk2-engines numix-gtk-theme \
gtk-theme-switch fonts-lato pcmanfm libfm-modules gpicview mousepad  pwgen \
xvkbd beep laptop-detect os-prober discover lshw-gtk hdparm smartmontools \
nmap time lvm2 gparted gnome-disk-utility baobab gddrescue testdisk \
dosfstools ntfs-3g reiserfsprogs reiser4progs hfsutils jfsutils smbclient \
cifs-utils nfs-common curlftpfs sshfs partclone pigz yad f2fs-tools \
exfat-fuse exfat-utils btrfs-progs locales fonts-wqy-zenhei chromium \
locales-all && apt install --no-install-recommends -y linux-image-amd64 live-boot \
systemd-sysv firmware-linux-free sudo vim-tiny pm-utils iptables-persistent \
iputils-ping net-tools wget openssh-client openssh-server rsync less \
xserver-xorg x11-xserver-utils xinit openbox obconf slim compton dbus-x11 \
libnotify-bin xfce4-notifyd gir1.2-notify-0.7 tint2 nitrogen xfce4-appfinder \
xfce4-power-manager gsettings-desktop-schemas lxrandr lxmenu-data \
lxterminal lxappearance network-manager-gnome gtk2-engines numix-gtk-theme \
gtk-theme-switch fonts-lato pcmanfm libfm-modules gpicview mousepad  pwgen \
xvkbd beep laptop-detect os-prober discover lshw-gtk hdparm smartmontools \
nmap time lvm2 gparted gnome-disk-utility baobab gddrescue testdisk \
dosfstools ntfs-3g reiserfsprogs reiser4progs hfsutils jfsutils smbclient \
cifs-utils nfs-common curlftpfs sshfs partclone pigz yad f2fs-tools \
exfat-fuse exfat-utils btrfs-progs locales fonts-wqy-zenhei chromium \
locales-all 
fi
	
# Delete keys
rm -f /etc/ssh/ssh_host_*

# Add regular user
useradd --create-home sky --shell /bin/bash
adduser sky sudo
echo 'sky:password' | chpasswd

# Prepare single-user system
touch pw
echo 'root:password'> pw
chpasswd <pw
echo 'default_user root' >> /etc/slim.conf
echo 'auto_login yes' >> /etc/slim.conf
ln -s /usr/bin/pcmanfm /usr/bin/nautilus
exit
EOL

#clean
cat > $ROOT/clean <<EOL
# Save space
rm -f /usr/share/icons/*/icon-theme.cache
apt-get autoremove && apt-get clean
rm -f /package
rm -f /pw
rm -f /clean
rm -rf /var/lib/dbus/machine-id
rm -rf /tmp/*
rm -f /etc/resolv.conf
rm -rf /var/lib/apt/lists/????????*
# System umounts
umount /proc;
umount /sys;
umount/dev/pts
EOL

#Chinese language
cat >> rootdir/etc/etc/default/locale <<END
LANG="zh_CN.UTF-8"
LANGUAGE="zh_CN:zh"
END

#Install package&exit
chmod +x $ROOT/package
chmod +x $ROOT/clean
chroot $ROOT/ /bin/bash -c /package
chroot $ROOT/ /bin/bash -c /clean

#Copy config file
cp -ar overlay/rootdir/. $ROOT/

#Make squashfs file
mksquashfs $ROOT filesystem.squashfs -e boot/
;;

2) echo 'make boot'
#clean boot file
	rm -rf image/
	rm -rf bootdir/
# Prepare boot image
	cp -ar overlay/image/. image
	mkdir -p image/EFI/boot
	touch image/Doubt
	mkdir bootdir	
	cp /usr/share/grub/ascii.pf2 image/boot/grub/fonts/
	cp /usr/lib/shim/shimx64.efi.signed image/EFI/boot/bootx64.efi
	cp /usr/lib/grub/x86_64-efi-signed/grubx64.efi.signed image/EFI/boot/grubx64.efi
	cp -r /usr/lib/grub/x86_64-efi image/boot/grub/
#legacy boot file Create image for BIOS and CD-ROM
	grub-mkstandalone \
		--format=i386-pc \
		--output=bootdir/core.img \
		--install-modules="linux normal iso9660 biosdisk memdisk search help tar ls all_video font gfxmenu png" \
		--modules="linux normal iso9660 biosdisk search help all_video font gfxmenu png" \
		--locales="" \
		--fonts="" \
		"boot/grub/grub.cfg=image/boot/grub/grub.cfg"
cat /usr/lib/grub/i386-pc/cdboot.img bootdir/core.img > bootdir/bios.img

#uefi boot file
if [ -f /etc/issue ]; then
name=$(cat /etc/issue |awk '{print $1}' |tr A-Z a-z)
mkdir image/EFI/$name
cat > image/EFI/$name/grub.cfg <<EOF
# Set prefix
search --file /Doubt --set root
set prefix=(\$root)/boot/grub

# Use primary GRUB configuration
configfile \$prefix/grub.cfg
EOF
else
    echo -e "\e[031m 未检测到系统版本，请手动制作efi文件！\e[0m \n"
fi


UFAT="bootdir/efiboot.img"
	dd if=/dev/zero of=$UFAT bs=1M count=4
	mkfs.vfat $UFAT
	mcopy -s -i $UFAT image/EFI ::
;;

3) echo 'make OS file'
#Copy system file
	#mkdir image/live
	#cp rootdir/boot/vmlinuz* image/vmlinuz
	#cp rootdir/boot/initrd* image/initrd
	#cp filesystem.squashfs image/live/
# Create final ISO image
	xorriso \
		-as mkisofs \
		-iso-level 3 \
		-full-iso9660-filenames \
		-joliet-long \
		-volid "DoubtOS" \
		-eltorito-boot \
			boot/grub/bios.img \
			-no-emul-boot \
			-boot-load-size 4 \
			-boot-info-table \
			--eltorito-catalog boot/grub/boot.cat \
		--grub2-boot-info \
		--grub2-mbr /usr/lib/grub/i386-pc/boot_hybrid.img \
		-eltorito-alt-boot \
			-e EFI/efiboot.img \
			-no-emul-boot \
		-append_partition 2 0xef bootdir/efiboot.img \
		-output DoubtOS.iso \
		-graft-points \
			image \
			/boot/grub/bios.img=bootdir/bios.img \
			/EFI/efiboot.img=bootdir/efiboot.img
	# Report final ISO size
	echo -e "\e[33m \nISO image saved:"
	du -sh DoubtOS.iso
	echo -e "\e[0m"
	echo
	echo "Done."  
	echo
;;

4) echo 'Make bootISO'
#clean boot file
	rm -rf image/
	rm -rf bootdir/
# Prepare boot image
	cp -ar overlay/image/. image
	mkdir -p image/EFI/boot
	touch image/Doubt
	mkdir bootdir	
	cp /usr/share/grub/ascii.pf2 image/boot/grub/fonts/
	cp /usr/lib/shim/shimx64.efi.signed image/EFI/boot/bootx64.efi
	cp /usr/lib/grub/x86_64-efi-signed/grubx64.efi.signed image/EFI/boot/grubx64.efi
	cp -r /usr/lib/grub/x86_64-efi image/boot/grub/
#legacy boot file Create image for BIOS and CD-ROM
	grub-mkstandalone \
		--format=i386-pc \
		--output=bootdir/core.img \
		--install-modules="linux normal iso9660 biosdisk memdisk search help tar ls all_video font gfxmenu png" \
		--modules="linux normal iso9660 biosdisk search help all_video font gfxmenu png" \
		--locales="" \
		--fonts="" \
		"boot/grub/grub.cfg=image/boot/grub/grub.cfg"
cat /usr/lib/grub/i386-pc/cdboot.img bootdir/core.img > bootdir/bios.img

#uefi boot file
if [ -f /etc/issue ]; then
name=$(cat /etc/issue |awk '{print $1}' |tr A-Z a-z)
mkdir image/EFI/$name
cat > image/EFI/$name/grub.cfg <<EOF
# Set prefix
search --file /Doubt --set root
set prefix=(\$root)/boot/grub

# Use primary GRUB configuration
configfile \$prefix/grub.cfg
EOF
else
    echo -e "\e[031m 未检测到系统版本，请手动制作efi文件！\e[0m \n"
fi


UFAT="bootdir/efiboot.img"
	dd if=/dev/zero of=$UFAT bs=1M count=4
	mkfs.vfat $UFAT
	mcopy -s -i $UFAT image/EFI ::
# Create boot ISO image
	xorriso \
		-as mkisofs \
		-iso-level 3 \
		-full-iso9660-filenames \
		-joliet-long \
		-volid "Dualboot" \
		-eltorito-boot \
			boot/grub/bios.img \
			-no-emul-boot \
			-boot-load-size 4 \
			-boot-info-table \
			--eltorito-catalog boot/grub/boot.cat \
		--grub2-boot-info \
		--grub2-mbr /usr/lib/grub/i386-pc/boot_hybrid.img \
		-eltorito-alt-boot \
			-e EFI/efiboot.img \
			-no-emul-boot \
		-append_partition 2 0xef bootdir/efiboot.img \
		-output Dualboot.iso \
		-graft-points \
			image \
			/boot/grub/bios.img=bootdir/bios.img \
			/EFI/efiboot.img=bootdir/efiboot.img
esac
