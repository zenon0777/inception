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

# echo "scrape_configs:
#   - job_name: 'prometheus'
#     static_configs:
#       - targets: ['localhost:9090']" >> /etc/prometheus/prometheus.yml

#install prometheus systemd service and set permission
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

apt install -y curl 

curl -s https://api.github.com/repos/prometheus/node_exporter/releases/latest\
| grep browser_download_url|grep linux-amd64|cut -d '"' -f 4|wget -qi -
tar -xvf node_exporter-1.6.0.linux-amd64.tar.gz
mv node_exporter-1.6.0.linux-amd64 node_exporter
mv node_exporter/node_exporter /usr/local/bin/

useradd -rs /bin/false node_exporter

echo "[Unit]
Description=Node Exporter
After=network.target

[Service]
User=node_exporter
Group=node_exporter
Type=simple
ExecStart=/usr/local/bin/node_exporter

[Install]
WantedBy=multi-user.target" > /etc/systemd/system/node_exporter.service

systemctl daemon-reload
systemctl enable node_exporter

# echo "  - job_name: 'node_exporter_metrics'
#     scrape_interval: 5s
#     static_configs:
#       - targets: ['mysql-exporter:3306']" >> /etc/prometheus/prometheus.yml

echo "  - job_name: 'node_exporter_metrics'
    scrape_interval: 5s
    static_configs:
      - targets: ['mysql-exporter:9105']" >> prometheus.yml

echo "  - job_name: 'docker'
    static_configs:
      - targets: ['127.0.0.1:9323']" >> prometheus.yml

echo "  - job_name: 'mysql'
    static_configs:
      - targets: ['mariadb:9105']" >> prometheus.yml



systemctl daemon-reload
systemctl restart node_exporter
systemctl restart prometheus
#grafana dashboard
# apt-get install -y adduser libfontconfig1
# apt --fix-broken install
# wget https://dl.grafana.com/oss/release/grafana_6.5.1_amd64.deb
# dpkg -i grafana_6.5.1_amd64.deb

# /bin/systemctl daemon-reload
# /bin/systemctl enable grafana-server
# /bin/systemctl start grafana-server

# cd /etc/grafana
# mkdir  dashboards
# cd dashboards
# cp /prometheus.yml /etc/grafana/dashboards/
# wget https://github.com/prometheus/mysqld_exporter/blob/main/mysqld-mixin/dashboards/mysql-overview.json
#listen on localhost:9010 ==> the default port is in use
prometheus --web.listen-address=:9010
