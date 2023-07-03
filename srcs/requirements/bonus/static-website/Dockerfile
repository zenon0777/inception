FROM debian:bullseye

RUN apt-get update && apt install -y git && apt install dumb-init -y

RUN git clone https://github.com/zenon0777/incep-web.git /var/site/html/web-app

ENTRYPOINT ["dumb-init", "--"]

CMD [ "sleep", "5451" ]