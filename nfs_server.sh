#!/bin/bash

sudo sed -i -e "s|mirrorlist=|#mirrorlist=|g" /etc/yum.repos.d/CentOS-*
sudo sed -i -e "s|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g" /etc/yum.repos.d/CentOS-*
# доустановим утилиту
yum install nfs-utils


#включаем firewall и проверяем, что он работает

systemctl enable firewalld --now 

#разрешаем в firewall доступ к сервисам NFS

firewall-cmd --add-service="nfs3" \
--add-service="rpc-bind" \
--add-service="mountd" \
--permanent 
#restart firewall
firewall-cmd --reload

systemctl start nfs-server
systemctl enable nfs-server.service
systemctl status nfs-server.service
#Проверка доступности портов   2049/udp, 2049/tcp, 20048/udp,  20048/tcp, 111/udp, 111/tcp
ss -tnplu 

#создаём и настраиваем директорию
mkdir -p /srv/share/upload
chmod 0777 /srv/share/upload 
chown nobody:nobody /srv/share

# создаём в файле __/etc/exports__ структуру, которая позволит экспортировать ранее созданную директорию

cat << EOF > /etc/exports 
/srv/share 192.168.50.11/32(rw,sync,root_squash)
EOF


#экспортируем ранее созданную директорию 
exportfs -r 

exportfs -s


#/srv/share  192.168.50.11/32(sync,wdelay,hide,no_subtree_check,sec=sys,rw,secure,root_squash,no_all_squash)
