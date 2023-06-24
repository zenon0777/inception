FROM debian:bullseye

RUN apt-get update && apt-get install -y curl \
    && apt install -y php7.4-fpm && apt-get install -y php-mysql\
    && curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar\
    && apt install dumb-init -y

RUN chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

COPY ./tools/wp-config.php .

COPY ./tools/wordpress.sh .

RUN chmod +x wordpress.sh

ENTRYPOINT ["dumb-init", "--"]

CMD ["bash", "wordpress.sh"]