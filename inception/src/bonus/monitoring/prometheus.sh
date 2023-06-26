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

#install prometheus systemd service and set permission
cp prometheus.service /etc/systemd/system/
cp /etc/prometheus/prometheus.yml .
chown -R prometheus:prometheus prometheus.yml
chmod -R 777 prometheus.yml
chown -R prometheus:prometheus /etc/systemd/system/
chmod -R 777 /etc/systemd/system/

cd / && apt install -y systemctl


echo "  - job_name: 'cadvisor'
    static_configs:
      - targets: ['localhost:8080']" >> prometheus.yml

systemctl daemon-reload
systemctl enable prometheus
systemctl start prometheus

#grafana dashboard
apt-get install -y adduser libfontconfig1
wget https://dl.grafana.com/enterprise/release/grafana-enterprise_10.0.1_amd64.deb
dpkg -i grafana-enterprise_10.0.1_amd64.deb
sed -i 's/http_port = 3000/http_port = 3010/g' /etc/grafana/grafana.ini

#cAdvisor
wget https://github.com/google/cadvisor/releases/download/v0.40.0/cadvisor -O /usr/local/bin/cadvisor
chmod +x /usr/local/bin/cadvisor
echo "[Unit]
Description=cAdvisor
Documentation=https://github.com/google/cadvisor
Wants=network-online.target
After=network-online.target

[Service]
ExecStart=/usr/local/bin/cadvisor
Restart=always

[Install]
WantedBy=multi-user.target
" > /etc/systemd/system/cadvisor.service

#import dashboard

# cd /etc/grafana/provisioning/dashboards
# cp /prometheus.yml /etc/grafana/datasource/
# wget https://grafana.com/api/dashboards/10566/revisions/1/download


chmod 777 -R /var/run/
systemctl daemon-reload
systemctl enable cadvisor
systemctl start cadvisor
systemctl daemon-reload
systemctl restart prometheus
systemctl enable grafana-server
systemctl start grafana-server
prometheus --web.listen-address=:9010
