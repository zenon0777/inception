#!/bin/bash

tar xvfz prometheus-2.45.0-rc.0.linux-amd64.tar.gz

mkdir -p /etc/prometheus
mkdir /var/lib/prometheus

mv prometheus-2.45.0-rc.0.linux-amd64 prometheus
mv prometheus /etc
useradd -M -r -s /bin/false prometheus

chown -R prometheus:prometheus /etc/prometheus
chown -R prometheus:prometheus /var/lib/prometheus
chown -R prometheus:prometheus /etc/prometheus/consoles
chown -R prometheus:prometheus /etc/prometheus/console_libraries
chmod -R 777 /etc/prometheus
chmod -R 777 /var/lib/prometheus
cp /etc/prometheus/prometheus /usr/local/bin/
cp /etc/prometheus/promtool /usr/local/bin/
#install prometheus systemd service

# echo "scrape_configs:
#   - job_name: 'prometheus'
#     static_configs:
#       - targets: ['localhost:9090']" >> /etc/prometheus/prometheus.yml

cp prometheus.service /etc/systemd/system/
cp /etc/prometheus/prometheus.yml .
chown -R prometheus:prometheus prometheus.yml
chmod -R 777 prometheus.yml
chown -R prometheus:prometheus /etc/systemd/system/
chmod -R 777 /etc/systemd/system/

cd / && apt install -y systemctl

systemctl daemon-reload
systemctl enable prometheus
systemctl start prometheus
prometheus