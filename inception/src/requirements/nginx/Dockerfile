FROM debian:bullseye

RUN apt-get update && apt-get install nginx -y && apt-get \
install openssl -y && apt install dumb-init -y

# create SSL certificate
RUN openssl \
    req -x509 \
    -nodes \
    -subj "/CN=localhost" \
    -addext "subjectAltName=DNS:localhost" \
    -days 365 \
    -newkey rsa:2048 -keyout /etc/ssl/private/self-signed.key \
    -out /etc/ssl/self-signed.crt

RUN rm  /etc/nginx/sites-enabled/default

COPY ./tools/conf /etc/nginx/sites-available/conf
COPY ./tools/monitor.sh .
RUN chmod +x monitor.sh
RUN ln -s /etc/nginx/sites-available/conf /etc/nginx/sites-enabled/default

ENTRYPOINT ["dumb-init", "--"]

CMD ["bash", "/monitor.sh"]