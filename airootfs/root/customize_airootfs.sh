#!/bin/bash

set -e -u

sed -i 's/#\(en_US\.UTF-8\)/\1/' /etc/locale.gen
locale-gen

ln -sf /usr/share/zoneinfo/UTC /etc/localtime

usermod -s /usr/bin/zsh root
cp -aT /etc/skel/ /root/

sed -i 's/#\(PermitRootLogin \).\+/\1yes/' /etc/ssh/sshd_config
sed -i "s/#Server/Server/g" /etc/pacman.d/mirrorlist
sed -i 's/#\(Storage=\)auto/\1volatile/' /etc/systemd/journald.conf

sed -i 's/#\(HandleSuspendKey=\)suspend/\1ignore/' /etc/systemd/logind.conf
sed -i 's/#\(HandleHibernateKey=\)hibernate/\1ignore/' /etc/systemd/logind.conf
sed -i 's/#\(HandleLidSwitch=\)suspend/\1ignore/' /etc/systemd/logind.conf

useradd -m -p "" -g users -G "adm,audio,floppy,log,network,rfkill,scanner,storage,optical,power,wheel" -s /bin/zsh liveuser
#chmod 700 /root
chown -R liveuser:users /home/liveuser

systemctl enable pacman-init.service choose-mirror.service NetworkManager.service bluetooth.service
systemctl enable org.cups.cupsd.service
systemctl enable ntpd.service acpid.service
systemctl enable sshd
systemctl enable lightdm-plymouth.service

export _EDITOR=nano
echo "EDITOR=${_EDITOR}" >> /etc/environment
echo "EDITOR=${_EDITOR}" >> /etc/skel/.bashrc
echo "EDITOR=${_EDITOR}" >> /etc/profile

pacman -Syy
gpg --receive-keys C1A60EACE707FDA5

#Enable Plymouth Theme
sed -i 's/base udev/base udev plymouth/g' /etc/mkinitcpio.conf
plymouth-set-default-theme -R arch-logo
mkinitcpio -p linux
