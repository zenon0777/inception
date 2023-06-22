#!/bin/bash

apt install -y systemctl

# groupadd --system prometheus

# useradd -s /sbin/nologin --system -g prometheus prometheus

tar xvf mysqld_exporter-0.14.0.linux-amd64.tar.gz

mv mysqld_exporter-0.14.0.linux-amd64/mysqld_exporter /usr/local/bin/

chmod -R +x /usr/local/bin/mysqld_exporter

echo "[client]
user=zenon
password=login" > /root/.my.cnf

mv mysql_exporter.service /etc/systemd/system/
chmod -R 777 /etc/systemd/system/mysql_exporter.service

chown root:root/root/.my.cnf

systemctl daemon-reload
systemctl enable mysql_exporter
systemctl start mysql_exporter
mysqld_exporter