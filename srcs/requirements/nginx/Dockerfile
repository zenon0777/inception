FROM debian:bullseye

RUN apt-get update && apt-get install nginx -y && apt-get \
install openssl -y

RUN openssl req -x509 -nodes \
    -subj "/CN=159.65.172.163" \
    -addext "subjectAltName=DNS:159.65.172.163" \
    -days 365 \
    -newkey rsa:2048 \
    -keyout /etc/ssl/private/self-signed.key \
    -out /etc/ssl/self-signed.crt


RUN rm  /etc/nginx/sites-enabled/default

COPY ./tools/conf /etc/nginx/sites-available/conf

RUN ln -s /etc/nginx/sites-available/conf /etc/nginx/sites-enabled/default

CMD ["/usr/sbin/nginx", "-g", "daemon off;"]