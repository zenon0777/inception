FROM debian:bullseye

RUN apt-get update && apt-get install -y mariadb-server && apt install dumb-init -y

COPY ./tools/mariadb.sh .

RUN chmod +x mariadb.sh

CMD ["bash", "mariadb.sh"]