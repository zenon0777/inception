FROM debian:bullseye

RUN apt-get update && apt-get install -y redis-server php7.4-redis\
    && apt install dumb-init -y

CMD ["/usr/bin/redis-server", "--bind 0.0.0.0"]