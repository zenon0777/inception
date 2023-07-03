FROM debian:bullseye

RUN apt-get update && apt install -y git && apt install python -y

RUN git clone https://github.com/zenon0777/incep-web.git /var/site/html/web-app

COPY ./tools/app.py .

CMD [ "python", "app.py"]
