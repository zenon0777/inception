FROM debian:bullseye

RUN apt-get update && apt install -y curl && apt install wget\
    && curl -s https://api.github.com/repos/prometheus/mysqld_exporter/releases/latest\   
    | grep browser_download_url   | grep linux-amd64 | cut -d '"' -f 4   | wget -qi -

COPY conf.sh .
COPY mysql_exporter.service .

CMD [ "bash", "conf.sh" ]