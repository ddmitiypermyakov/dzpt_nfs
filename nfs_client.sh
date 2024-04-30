#!/bin/bash


###########################
## nfsc NFS client
###########################
sudo sed -i -e "s|mirrorlist=|#mirrorlist=|g" /etc/yum.repos.d/CentOS-*
sudo sed -i -e "s|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g" /etc/yum.repos.d/CentOS-*
#install nfs-utils
yum install nfs-utils 

systemctl enable firewalld --now 
systemctl status firewalld 
#Add fstab nfs 
echo "192.168.56.10:/srv/share/ /mnt nfs vers=3,proto=udp,noauto,x-systemd.automount 0 0" >> /etc/fstab

systemctl daemon-reload 

mount 192.168.50.10:/srv/share/ /mnt

### Проверка работоспособности 
#- заходим на сервер 
#- заходим в каталог `/srv/share/upload` 
#- создаём тестовый файл `touch check_file` 
#- заходим на клиент 
#- заходим в каталог `/mnt/upload` 
#- проверяем наличие ранее созданного файла 
#- создаём тестовый файл `touch client_file` 
#- проверяем, что файл успешно создан 
