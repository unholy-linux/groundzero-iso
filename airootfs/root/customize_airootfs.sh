#!/bin/bash

set -e -u

sed -i 's/#\(en_US\.UTF-8\)/\1/' /etc/locale.gen
locale-gen

ln -sf /usr/share/zoneinfo/UTC /etc/localtime

# root and live user
usermod -s /bin/bash root
cp -aT /etc/skel/ /root/
useradd -m -p "" -g users -G "adm,audio,floppy,log,network,rfkill,scanner,storage,optical,power,wheel" -s /bin/bash liveuser
#chmod 750 /etc/sudoers.d
chmod 440 /etc/sudoers.d/g_wheel
chown -R liveuser:users /home/liveuser

sed -i 's/#\(PermitRootLogin \).\+/\1yes/' /etc/ssh/sshd_config
sed -i "s/#Server/Server/g" /etc/pacman.d/mirrorlist
sed -i 's/#\(Storage=\)auto/\1volatile/' /etc/systemd/journald.conf

sed -i 's/#\(HandleSuspendKey=\)suspend/\1ignore/' /etc/systemd/logind.conf
sed -i 's/#\(HandleHibernateKey=\)hibernate/\1ignore/' /etc/systemd/logind.conf
sed -i 's/#\(HandleLidSwitch=\)suspend/\1ignore/' /etc/systemd/logind.conf

#useradd -m -p "groundzero" -g users -u 1100 -G "adm,audio,floppy,log,network,rfkill,scanner,storage,optical,power,wheel" -s /bin/bash liveuser
#chown -R liveuser:users /home/liveuser

#Enable Calamares Autostart
# desktop file in config/autostart
ln -fs /usr/share/applications/calamares.desktop /home/liveuser/.config/autostart/calamares.desktop

#enable autologin
#groupadd -r autologin
#gpasswd -a liveuser autologin
#enabling interactive passwordless login
#groupadd -r nopasswdlogin
#gpasswd -a liveuser nopasswdlogin

systemctl enable lightdm.service
systemctl set-default graphical.target
systemctl enable pacman-init.service choose-mirror.service NetworkManager.service org.cups.cupsd.service bluetooth.service
systemctl enable ntpd.service

export _EDITOR=nano
echo "EDITOR=${_EDITOR}" >> /etc/environment
echo "EDITOR=${_EDITOR}" >> /etc/skel/.bashrc
echo "EDITOR=${_EDITOR}" >> /etc/profile

pacman -Syy
gpg --receive-keys C1A60EACE707FDA5
