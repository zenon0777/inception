FROM debian:bullseye

RUN apt-get update && apt install -y wget && wget https://www.adminer.org/latest.php\
    && apt install -y php7.4-fpm && apt install -y php-mysql

COPY ./tools/adminer.sh .

RUN chmod +x adminer.sh
CMD ["bash", "adminer.sh"]
