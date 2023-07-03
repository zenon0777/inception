FROM debian:bullseye

RUN apt-get update &&  apt install -y apt-transport-https curl wget \
    && wget "https://github.com/prometheus/prometheus/releases/\
download/v2.45.0-rc.0/prometheus-2.45.0-rc.0.linux-amd64.tar.gz"

COPY ./prometheus.sh .
RUN chmod +x prometheus.sh

COPY ./prometheus.service .

CMD [ "bash", "prometheus.sh" ]