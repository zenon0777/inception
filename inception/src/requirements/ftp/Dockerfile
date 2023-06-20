FROM debian:bullseye

RUN apt-get update && apt install -y vsftpd openssl

COPY ./tools/ftp.sh .
COPY ./tools/conf .

RUN chmod +x ftp.sh

CMD ["bash", "ftp.sh"]