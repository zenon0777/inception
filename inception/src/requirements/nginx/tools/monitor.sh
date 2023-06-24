#!/bin/bash

# echo "
# http
# {
#     load_module modules/ngx_http_prometheus_module.so;

#     server
#     {
#         listen 9113;
#         location /metrics 
#         {
#             prometheus;
#         }
#     }
# }
# " >> /etc/nginx/http-block.conf
# apt install -y make wget

# wget "https://golang.org/dl/go1.17.linux-amd64.tar.gz"
# tar -C /usr/local -xzf go1.17.linux-amd64.tar.gz
# echo "export PATH=$PATH:/usr/local/go/bin
# export GOPATH=$HOME/go" >> ~/.profile
# source ~/.profile

# apt install -y git && git clone https://github.com/nginxinc/nginx-prometheus-exporter.git
# cd nginx-prometheus-exporter
# make && cd /

/usr/sbin/nginx -g "daemon off;"