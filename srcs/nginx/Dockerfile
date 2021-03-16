FROM alpine:3.13.2

RUN apk update \
&& apk add openssl \
&& apk add vim \
&& apk add nginx

# This repo is necessary to start nginx, however it doesn't exixt on alpine image
RUN mkdir -p /run/nginx

WORKDIR /etc/nginx

# SSL installation
RUN apk add openssl
RUN mkdir -p /etc/ssl/private && \
mkdir -p /etc/ssl/certs
RUN chmod 700 /etc/ssl/private && \
chmod 700 /etc/ssl/certs
RUN openssl req -x509 \
-nodes \
-days 365 \
-newkey rsa:2048 \
-keyout /etc/ssl/private/nginx-selfsigned.key \
-out	/etc/ssl/certs/nginx-selfsigned.crt \
-subj "/C=FR/ST=Paris/L=Paris/O=42 School/OU=harlock/CN=localhost"

# Telegraf configuration
RUN apk add telegraf
RUN mkdir -p /var/log/telegraf
RUN touch /var/log/telegraf/telegraf.log
COPY telegraf.conf /etc/telegraf/telegraf.conf
RUN export TELEGRAF_CONFIG_PATH="/etc/telegraf/telegraf.conf"

WORKDIR ../..

COPY index.html /data/www/index.html

COPY nginx.conf /etc/nginx/nginx.conf

COPY init.sh /tmp/init.sh

ENTRYPOINT /tmp/init.sh
