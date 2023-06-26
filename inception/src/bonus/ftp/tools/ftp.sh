#! /bin/bash

sed -i 's/#write_enable=YES/write_enable=YES/g' /etc/vsftpd.conf
sed -i 's/#local_umask=022/local_umask=022/g' /etc/vsftpd.conf
# sed -i 's/#chroot_local_user=YES/chroot_local_user=YES/g' /etc/vsftpd.conf
# sed -i 's/#allow_writeable_chroot=YES/allow_writeable_chroot=YES/g' /etc/vsftpd.conf
sed -i 's/#ascii_upload_enable=YES/ascii_upload_enable=YES/g' /etc/vsftpd.conf
sed -i 's/#ascii_download_enable=YES/ascii_download_enable=YES/g' /etc/vsftpd.conf
sed -i 's/#pasv_enable=YES/pasv_enable=YES/g' /etc/vsftpd.conf
# sed -i 's/#pasv_min_port=1024/pasv_min_port=1024/g' /etc/vsftpd.conf
# sed -i 's/#pasv_max_port=1048/pasv_max_port=1048/g' /etc/vsftpd.conf
echo local_root=/var/site/html >> /etc/vsftpd.conf
echo listen_address=0.0.0.0 >> /etc/vsftpd.conf
echo pasv_min_port=1024 >> /etc/vsftpd.conf
echo pasv_max_port=1048 >> /etc/vsftpd.conf
cat conf >> /etc/vsftpd.conf

/etc/init.d/vsftpd restart

useradd -m -p $(openssl passwd -1 zeno) zeno
addgroup zeno
usermod -aG zeno zeno
echo "zeno" | tee -a /etc/vsftpd.userlist
chown -R zeno:zeno /var/site/html
chmod -R 777 /var/site/html
# Verify the ownership and permissions of the root directory and its parent directories.
#  The root directory should be owned by root and should not be writable by other users
# chown -R root:root /var/site/html
# chmod -R 775 /var/site/html

/etc/init.d/vsftpd stop

vsftpd
